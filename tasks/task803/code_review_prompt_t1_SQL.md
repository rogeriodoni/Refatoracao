# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS, NKEYCODE
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS, NKEYCODE

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
  ControlSource = "crSigCdPgr.Grupos"
  ControlSource = "crSigCdPgr.Contas"
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = "Grupo"
  Column2.ControlSource = "Conta"
  Column3.ControlSource = "Nome"
  ControlSource = "Grupos"
  ControlSource = "Contas"
  ControlSource = "Nomes"
	Select TmpBaixa
		=Seek( moedas, 'crSigCdMoe', 'CMoes' )
If !IsEmpty( This.Value ) And !Seek( This.Value, 'crSigCdMoe', 'CMoes' )
If !IsEmpty( This.Value ) And !Seek( This.Value, 'crSigCdMoe', 'DMoes' )

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpSlc.prg) - TRECHOS RELEVANTES PARA PASS SQL (1654 linhas total):

*-- Linhas 72 a 90:
72: *     If !_GetMoeda
73: *         This.Height = This.Height - 25
74: *     Else
75: *         Select TmpBaixa
76: *         Scan for Tipos = 'X'
77: *             This.Get_cd_moeda.value = moedas
78: *             =Seek( moedas, 'crSigCdMoe', 'CMoes' )
79: *             This.Get_ds_moeda.value = crSigCdMoe.dmoes
80: *             exit
81: *         Endscan
82: *     Endif
83: *     If !_GetConta And _GetMoeda
84: *         This.Get_cd_moeda.Top = 50
85: *         This.Get_ds_moeda.top = 50
86: *         This.SayMoeda.top = 54
87: *         This.Height = 100
88: *     Endif
89: *     This.Refresh
90: *

*-- Linhas 98 a 116:
98: * TmpBaixa, como TmpCliente e crSigCdPgr (fase 4), eh cursor do FORM PAI -
99: * este dialogo so LE, nunca declara. O Seek legado em crSigCdMoe (cursor
100: * global legado, sem guarda de sucesso) equivale no sistema novo a
101: * THIS.this_oBusinessObject.ValidarMoedaPorCodigo(), que ja faz SQLEXEC em
102: * SigCdMoe e preserva o codigo mesmo se a busca falhar (regra #37/#50).
103: *
104: * ORDEM DE CRIACAO - o cabecalho eh o PRIMEIRO AddObject do form. Os botoes
105: * Cancela/Confirma do SCX ficam em Top = 3 (dentro da faixa, Top 0..80) -
106: * quem for criado depois desenha POR CIMA; invertida a ordem, a faixa cinza
107: * cobriria os dois botoes (regra #11 do CLAUDE.md).
108: *
109: * FASE 6 (esta fase): lookup de moeda. Legado:
110: *
111: *     get_cd_moeda.Valid: If !IsEmpty(This.Value) And !Seek(This.Value, 'crSigCdMoe', 'CMoes')
112: *                             <fwBuscaSel> Else If IsEmpty(This.Value) <Cd/Ds = ''>
113: *     get_ds_moeda.Valid: mesma logica, Seek por DMoes
114: *     get_ds_moeda.When:  Return IsEmpty(Thisform.Get_Cd_Moeda.Value)
115: *
116: * CdMoedaLostFocus/DsMoedaLostFocus (BINDEVENT em "LostFocus", nao em

*-- Linhas 961 a 979:
961:                 ENDIF
962: 
963:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
964:                     SELECT cursor_4c_BuscaMoeda
965:                     THIS.txt_4c__cd_moeda.Value = ALLTRIM(TratarNulo(cmoes, ""))
966:                     THIS.txt_4c__ds_moeda.Value = ALLTRIM(TratarNulo(dmoes, ""))
967: 
968:                     IF VARTYPE(THIS.this_oBusinessObject) = "O"
969:                         THIS.this_oBusinessObject.this_cCdMoeda = THIS.txt_4c__cd_moeda.Value
970:                         THIS.this_oBusinessObject.this_cDsMoeda = THIS.txt_4c__ds_moeda.Value
971:                     ENDIF
972:                 ENDIF
973: 
974:                 loc_oBusca.Release()
975:             ENDIF
976: 
977:             IF USED("cursor_4c_BuscaMoeda")
978:                 USE IN cursor_4c_BuscaMoeda
979:             ENDIF

*-- Linhas 994 a 1012:
994:     * SigOpSlcBO.prg). Transcrito por completude estrutural com o SCX
995:     * (PILAR 1), sem reativar o bloco nem "corrigir" o hardcode.
996:     *
997:     * ControlSource/RecordSource apontam para cursores do FORM PAI
998:     * (crSigCdPgr, TmpCliente) que este dialogo nao declara. Como o bloco
999:     * fica sempre invisivel, o binding so eh aplicado SE o cursor ja
1000:     * estiver aberto nesta sessao (DataSession = 1) - sem essa guarda, um
1001:     * cursor ausente derrubaria o Init (regra #41 do CLAUDE.md).
1002:     *==========================================================================
1003:     PROTECTED PROCEDURE ConfigurarBlocoContaGrupo
1004:         *-- SayGrupo -> lbl_4c_Grupo
1005:         THIS.AddObject("lbl_4c_Grupo", "Label")
1006:         WITH THIS.lbl_4c_Grupo
1007:             .FontName  = "Tahoma"
1008:             .Caption   = "Grupo : "
1009:             .Left      = 235
1010:             .Top       = 310
1011:             .ForeColor = RGB(90, 90, 90)
1012:             .Visible   = THIS.this_lExibirConta

*-- Linhas 1023 a 1075:
1023:             .Visible   = THIS.this_lExibirConta
1024:         ENDWITH
1025: 
1026:         *-- Get_Grupo -> txt_4c_Grupo (legado: ControlSource = "crSigCdPgr.Grupos")
1027:         THIS.AddObject("txt_4c_Grupo", "TextBox")
1028:         WITH THIS.txt_4c_Grupo
1029:             .Value    = ""
1030:             .Format   = "K!"
1031:             .Top      = 308
1032:             .Left     = 278
1033:             .Height   = 21
1034:             .Width    = 79
1035:             .FontName = "Tahoma"
1036:             .FontSize = 8
1037:             IF USED("crSigCdPgr")
1038:                 .ControlSource = "crSigCdPgr.Grupos"
1039:             ENDIF
1040:             .Visible  = THIS.this_lExibirConta
1041:         ENDWITH
1042: 
1043:         *-- Get_Conta -> txt_4c_Conta (legado: ControlSource = "crSigCdPgr.Contas")
1044:         THIS.AddObject("txt_4c_Conta", "TextBox")
1045:         WITH THIS.txt_4c_Conta
1046:             .Value    = ""
1047:             .Format   = "K!"
1048:             .Top      = 330
1049:             .Left     = 278
1050:             .Height   = 21
1051:             .Width    = 79
1052:             .FontName = "Tahoma"
1053:             .FontSize = 8
1054:             IF USED("crSigCdPgr")
1055:                 .ControlSource = "crSigCdPgr.Contas"
1056:             ENDIF
1057:             .Visible  = THIS.this_lExibirConta
1058:         ENDWITH
1059: 
1060:         *-- Get_DCONTA -> txt_4c_DCONTA (legado: ControlSource = "" - texto
1061:         *-- livre, sem binding)
1062:         THIS.AddObject("txt_4c_DCONTA", "TextBox")
1063:         WITH THIS.txt_4c_DCONTA
1064:             .Value       = ""
1065:             .Top         = 352
1066:             .Left        = 278
1067:             .Height      = 21
1068:             .Width       = 291
1069:             .ReadOnly    = .F.
1070:             .FontName    = "Tahoma"
1071:             .FontSize    = 8
1072:             .ToolTipText = "Passe o Cheque na Leitora"
1073:             .Visible     = THIS.this_lExibirConta
1074:         ENDWITH
1075: 

*-- Linhas 1082 a 1100:
1082:             .FontSize          = 8
1083:             .AllowHeaderSizing = .F.
1084:             .AllowRowSizing    = .F.
1085:             .DeleteMark        = .F.
1086:             .RecordMark        = .F.
1087:             .Top               = 123
1088:             .Left              = 230
1089:             .Width             = 339
1090:             .Height            = 155
1091:             .RowHeight         = 17
1092:             .ScrollBars        = 2
1093:             .ReadOnly          = .T.
1094:             .Visible           = THIS.this_lExibirConta
1095:         ENDWITH
1096: 
1097:         *-- Largura/cabecalho das colunas NAO ficam aqui: moram em
1098:         *-- AplicarFormatoGrade, que eh a FONTE UNICA desses numeros e eh
1099:         *-- reusada pelo CarregarDados depois do RecordSource (duplicar os
1100:         *-- valores nos dois lugares eh o que deixa a grade mudar de

*-- Linhas 1114 a 1132:
1114:     *
1115:     * Existe como metodo porque a grade eh configurada em DOIS momentos - na
1116:     * montagem (ConfigurarBlocoContaGrupo) e na recarga (CarregarDados, que
1117:     * mexe em RecordSource/ControlSource e pode zerar Width e Caption, o
1118:     * Problema 48). Com os dois chamando este metodo nao ha como os dois
1119:     * lados divergirem em silencio.
1120:     *
1121:     * Metodo PUBLIC: o form pai pode reaplicar o formato depois de repopular
1122:     * o proprio TmpCliente.
1123:     *==========================================================================
1124:     PROCEDURE AplicarFormatoGrade
1125:         LOCAL loc_lAplicou
1126:         loc_lAplicou = .F.
1127: 
1128:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1129:             WITH THIS.grd_4c_Dados
1130:                 .Column1.Width             = 65
1131:                 .Column1.Movable           = .F.
1132:                 .Column1.Resizable         = .F.

*-- Linhas 1172 a 1190:
1172:     * TmpCliente NAO pertence a este dialogo - eh um cursor que o chamador
1173:     * deixa aberto antes do Do Form (mesma situacao de TmpBaixa e
1174:     * crSigCdPgr, documentada no cabecalho de SigOpSlcBO.prg). Por isso aqui
1175:     * nao ha SQLEXEC: nao ha consulta propria a fazer, so o binding.
1176:     *
1177:     * Sem o cursor aberto o binding NAO eh aplicado - atribuir RecordSource
1178:     * de alias inexistente derruba o Init (regra #41). Devolve .F. nesse
1179:     * caso, e o chamador trata como "nada a exibir", nao como erro: o bloco
1180:     * de Conta/Grupo fica permanentemente oculto (regra #17), entao a
1181:     * ausencia de TmpCliente eh o caminho NORMAL desta tela.
1182:     *
1183:     * Fecha com GO TOP + Refresh (regra #21a): popular/ligar cursor nao
1184:     * repinta a grade sozinho.
1185:     *
1186:     * Metodo PUBLIC (regra #3): o harness de teste (TesteCarregarDadosReais)
1187:     * o chama de fora, SEM argumento, e PROTECTED faria a chamada estourar
1188:     * em runtime com "Property CARREGARDADOS is not found".
1189:     *==========================================================================
1190:     PROCEDURE CarregarDados

*-- Linhas 1211 a 1234:
1211:                 *-- Colunas do dump: Column1=Grupo, Column2=Conta,
1212:                 *-- Column3=Nome (os campos que o AfterRowColChange legado
1213:                 *-- le para alimentar Get_Grupo/Get_Conta/Get_DConta)
1214:                 .Column1.ControlSource = "TmpCliente.Grupo"
1215:                 .Column2.ControlSource = "TmpCliente.Conta"
1216:                 .Column3.ControlSource = "TmpCliente.Nome"
1217:             ENDWITH
1218: 
1219:             *-- Rede de seguranca do Problema 48: RecordSource/ControlSource
1220:             *-- podem zerar Width e Header1.Caption. Mesma fonte usada na
1221:             *-- montagem, entao nao ha numero duplicado aqui
1222:             THIS.AplicarFormatoGrade()
1223: 
1224:             *-- Legado: a Grade so mostra dado depois do posicionamento +
1225:             *-- repintura (o Init legado termina com This.Refresh)
1226:             GO TOP IN TmpCliente
1227:             THIS.grd_4c_Dados.Refresh()
1228: 
1229:             loc_lCarregou = .T.
1230: 
1231:         CATCH TO loc_oErro
1232:             THIS.this_cMensagemErro = loc_oErro.Message
1233:             MsgErro("Erro ao carregar a grade de contas: " + loc_oErro.Message + ;
1234:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;

*-- Linhas 1495 a 1556:
1495:     *==========================================================================
1496:     * CarregarMoedaDefaultDeTmpBaixa - legado:
1497:     *
1498:     *   Select TmpBaixa
1499:     *   Scan for Tipos = 'X'
1500:     *       This.Get_cd_moeda.value = moedas
1501:     *       =Seek( moedas, 'crSigCdMoe', 'CMoes' )
1502:     *       This.Get_ds_moeda.value = crSigCdMoe.dmoes
1503:     *       exit
1504:     *   Endscan
1505:     *
1506:     * TmpBaixa eh cursor do FORM PAI (mesma situacao de TmpCliente e
1507:     * crSigCdPgr na fase 4) - sem ele aberto nesta DataSession = 1, nao ha
1508:     * default a buscar, e isso NAO eh erro (devolve .F. calado).
1509:     *
1510:     * O Seek legado em crSigCdMoe (cursor global, SEM checar o resultado)
1511:     * equivale aqui a ValidarMoedaPorCodigo(), que faz o SQLEXEC em
1512:     * SigCdMoe e preserva o codigo encontrado em TmpBaixa mesmo que a
1513:     * busca na tabela de moedas nao encontre nada (regra #37/#50 - nunca
1514:     * apagar um codigo ja resolvido).
1515:     *
1516:     * Restaura o alias corrente ao final: SELECT TmpBaixa muda a work area
1517:     * ativa, e este metodo roda antes de qualquer outra carga do form.
1518:     *==========================================================================
1519:     PROTECTED PROCEDURE CarregarMoedaDefaultDeTmpBaixa
1520:         LOCAL loc_cAliasAnterior, loc_cMoedaDefault, loc_oErro
1521:         loc_cMoedaDefault = ""
1522: 
1523:         IF !USED("TmpBaixa")
1524:             RETURN .F.
1525:         ENDIF
1526: 
1527:         loc_cAliasAnterior = ALIAS()
1528: 
1529:         TRY
1530:             SELECT TmpBaixa
1531:             SCAN FOR Tipos = "X"
1532:                 loc_cMoedaDefault = TratarNulo(moedas, "")
1533:                 EXIT
1534:             ENDSCAN
1535:         CATCH TO loc_oErro
1536:             THIS.this_cMensagemErro = "Erro ao ler a moeda padr" + CHR(227) + ;
1537:                 "o em TmpBaixa: " + loc_oErro.Message
1538:         ENDTRY
1539: 
1540:         IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1541:             SELECT (loc_cAliasAnterior)
1542:         ENDIF
1543: 
1544:         IF EMPTY(loc_cMoedaDefault)
1545:             RETURN .F.
1546:         ENDIF
1547: 
1548:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1549:             THIS.this_oBusinessObject.ValidarMoedaPorCodigo(loc_cMoedaDefault)
1550: 
1551:             IF PEMSTATUS(THIS, "txt_4c__cd_moeda", 5)
1552:                 THIS.txt_4c__cd_moeda.Value = THIS.this_oBusinessObject.this_cCdMoeda
1553:             ENDIF
1554:             IF PEMSTATUS(THIS, "txt_4c__ds_moeda", 5)
1555:                 THIS.txt_4c__ds_moeda.Value = THIS.this_oBusinessObject.this_cDsMoeda
1556:             ENDIF


### BO (C:\4c\projeto\app\classes\SigOpSlcBO.prg):
*==============================================================================
* SigOpSlcBO.prg
*
* Business Object para FormSigOpSlc - Dialogo de Selecao de Moeda (e Conta,
* bloco permanentemente oculto - ver NOTA abaixo)
* Legado: SigOpSlc.SCX (task803)
*
* Tabela: SigCdMoe (somente CONSULTA/VALIDACAO, nunca gravacao)
*
*------------------------------------------------------------------------------
* FUNCAO DA TELA
*
* Dialogo FILHO, modal e sem barra de titulo (no SCX: WindowType = 1,
* TitleBar = 0, ControlBox ausente/Closable = .F., 800 x 400, BorderStyle = 2),
* aberto por um form pai que guarda a referencia em ThisForm.ParentForm
* (RESERVED3/ClassInfo do SCX = "parentform"). O legado abre assim:
*
*     Do Form SigOpSlc With _GetConta, _GetMoeda, ThisForm
*
* Os dois primeiros parametros ligam/desligam blocos de controles (Visible),
* e o terceiro eh o form que vai receber o resultado.
*
*------------------------------------------------------------------------------
* O CONTRATO - O QUE VOLTA PARA O FORM PAI
*
* Os dois botoes escrevem DIRETO em ThisForm.ParentForm, sem metodo
* intermediario:
*
*     Cancela.Click  -> ThisForm.ParentForm.CanceladoExterno = .T. / Release
*     Confirma.Click -> ThisForm.ParentForm.MoedaMaior = ThisForm.get_cd_moeda.Value / Release
*
* Ou seja: o UNICO dado que realmente sai desta tela eh o codigo da moeda
* escolhida (ou a confirmacao de que o usuario cancelou). O bloco de
* Grupo/Conta NUNCA alimenta o pai - ver a nota abaixo sobre por que ele
* existe no SCX mas esta morto.
*
*------------------------------------------------------------------------------
* NOTA - O BLOCO DE CONTA/GRUPO ESTA PERMANENTEMENTE OCULTO (regra #17)
*
* O Init legado recebe _GetConta como parametro e, na linha seguinte,
* SOBRESCREVE o valor recebido:
*
*     LParameters _GetConta, _GetMoeda, _Parent
*     _GetConta = .f.                    && <- ignora o que o chamador mandou
*     This.Grade.Visible     = _GetConta
*     This.Get_Grupo.Visible = _GetConta
*     This.Get_Conta.Visible = _GetConta
*     This.Get_dConta.Visible = _GetConta
*     This.SayGrupo.Visible  = _GetConta
*     This.SayConta.Visible  = _GetConta
*
* Isso significa que a Grade (RecordSource = "TmpCliente"), os campos
* Get_Grupo/Get_Conta/Get_DConta (ControlSource = crSigCdPgr.Grupos/Contas) e
* os respectivos Say ficam SEMPRE invisiveis, para QUALQUER chamador - eh
* codigo morto no legado, e se transcreve LITERAL (regra #17: nao se
* "corrige" removendo o hardcode nem se reativa o bloco). As properties deste
* BO que espelham esse bloco (this_cGrupo/this_cConta/this_cDConta) existem
* so para completude estrutural (paridade com os controles do SCX) - nenhum
* fluxo as alimenta de fato.
*
* Os validadores desses campos (Get_Grupo.Valid/Get_Conta.Valid/
* Get_DConta.Valid) chamam fAcessoContab()/fAcessoContas(), que JA EXISTEM
* como helpers globais em utils\functions.prg (linhas 709 e 991) - nao
* precisam de wrapper neste BO, e ficam no Form (camada de UI), que eh quem
* os aciona via BINDEVENT.
*
*------------------------------------------------------------------------------
* A MOEDA - O UNICO DADO QUE DE FATO CIRCULA
*
* get_cd_moeda.Valid e get_ds_moeda.Valid fazem Seek em 'crSigCdMoe' (cursor
* global legado) por CMoes/DMoes e, nao achando, abrem fwBuscaSel. No sistema
* novo o equivalente eh validar/buscar direto em SigCdMoe via SQLEXEC e
* FormBuscaAuxiliar (padrao do projeto - docs/lookup_implementation.md),
* dai this_cTabela = "SigCdMoe" / this_cCampoChave = "CMoes" neste BO.
*
* Quando _GetMoeda = .T., o Init legado tambem busca um valor DEFAULT de
* moeda varrendo um cursor do CHAMADOR (TmpBaixa, Scan For Tipos = 'X',
* pega o campo moedas da primeira linha). TmpBaixa, assim como TmpCliente e
* crSigCdPgr acima, NAO pertence a este dialogo - sao cursores que o form
* pai ja deixa abertos antes do Do Form (mesmo padrao documentado em
* SigOpCtdBO.prg: tabela do chamador nao se declara aqui). A leitura desse
* default fica para a fase do Form (que tem acesso ao cursor do pai), nao
* para este BO.
*
*------------------------------------------------------------------------------
* AJUSTE DE ALTURA (Init legado) - FICA NA FASE DO FORM, NAO AQUI
*
*     If !_GetMoeda
*         This.Height = This.Height - 25
*     Else
*         <busca o default em TmpBaixa>
*     Endif
*     If !_GetConta And _GetMoeda      && _GetConta e sempre .F., entao
*         <reposiciona get_cd_moeda/get_ds_moeda/SayMoeda e This.Height=100>
*     Endif
*
* Esse ajuste eh layout puro (Height/Top de controles) - nao ha property de
* BO que o represente. this_lExibirMoeda eh o que decide qual dos dois
* ramos a fase do Form vai aplicar.
*
*------------------------------------------------------------------------------
* NOTA DE ARQUITETURA - SOMENTE LEITURA/VALIDACAO
*
* Este BO nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao(): o dump do
* legado nao tem INSERT/UPDATE/DELETE/TABLEUPDATE - a tela so VALIDA um
* codigo de moeda e devolve a escolha ao chamador. O comportamento padrao
* herdado de BusinessBase (recusar a gravacao) ja eh o correto.
*==============================================================================

DEFINE CLASS SigOpSlcBO AS BusinessBase

    *--------------------------------------------------------------------------
    * BLOCO MOEDA - o unico dado que de fato sai desta tela
    *--------------------------------------------------------------------------
    this_lExibirMoeda = .T.    && legado: parametro _GetMoeda (Visible de get_cd_moeda/get_ds_moeda/SayMoeda)
    this_cCdMoeda      = ""    && legado: Get_cd_moeda.Value -> crSigCdMoe.CMoes -> ParentForm.MoedaMaior
    this_cDsMoeda      = ""    && legado: Get_ds_moeda.Value -> crSigCdMoe.DMoes (so exibicao)

    *--------------------------------------------------------------------------
    * BLOCO GRUPO/CONTA - SEMPRE OCULTO no legado (_GetConta = .f. hardcoded
    * no Init, independente do que o chamador passar - ver nota no cabecalho).
    * Mantido so por completude estrutural com os controles do SCX.
    *--------------------------------------------------------------------------
    this_lExibirConta = .F.    && legado: _GetConta, FORCADO .F. no Init (regra #17)
    this_cGrupo       = ""     && legado: Get_Grupo.Value  -> crSigCdPgr.Grupos (bloco oculto)
    this_cConta       = ""     && legado: Get_Conta.Value  -> crSigCdPgr.Contas (bloco oculto)
    this_cDConta      = ""     && legado: Get_DConta.Value -> descricao da conta (bloco oculto)

    *--------------------------------------------------------------------------
    * RESULTADO DA INTERACAO - o que os dois botoes decidem
    *--------------------------------------------------------------------------
    this_lCancelado = .F.      && legado: ParentForm.CanceladoExterno (Cancela.Click)
    this_lConfirmou = .F.      && .T. so quando o botao Confirma foi acionado

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Parametros, ambos opcionais:
    *     par_lExibirConta - aceito por simetria com a assinatura do form
    *                        legado (_GetConta), mas SEMPRE sobrescrito para
    *                        .F. - o legado forca isso incondicionalmente logo
    *                        apos o LParameters, e isso se transcreve literal
    *                        (regra #17), nao se "corrige".
    *     par_lExibirMoeda - legado: _GetMoeda. Omitido, assume .T. (bloco de
    *                        moeda visivel, que eh o uso real desta tela).
    *==========================================================================
    PROCEDURE Init(par_lExibirConta, par_lExibirMoeda)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMoe"
            THIS.this_cCampoChave = "CMoes"

            *-- Legado: _GetConta = .f. (hardcode incondicional, regra #17)
            THIS.this_lExibirConta = .F.

            *-- Legado: _GetMoeda (parametro real, sem hardcode)
            IF VARTYPE(par_lExibirMoeda) = "L"
                THIS.this_lExibirMoeda = par_lExibirMoeda
            ELSE
                THIS.this_lExibirMoeda = .T.
            ENDIF

            THIS.this_cCdMoeda  = ""
            THIS.this_cDsMoeda  = ""
            THIS.this_cGrupo    = ""
            THIS.this_cConta    = ""
            THIS.this_cDConta   = ""
            THIS.this_lCancelado = .F.
            THIS.this_lConfirmou = .F.

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigOpSlcBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega this_cCdMoeda/this_cDsMoeda a partir de UM
    * registro de cursor com as colunas cmoes/dmoes (SigCdMoe).
    *
    * Usado por ValidarMoedaPorCodigo/ValidarMoedaPorDescricao logo depois do
    * SQLEXEC, e tambem pelo Form apos o usuario escolher um registro no
    * FormBuscaAuxiliar (regra #37 do CLAUDE.md).
    *
    * PUBLIC (sem PROTECTED) porque BusinessBase.CarregarDoCursor() ja eh
    * PUBLIC - PROTECTED aqui so na subclasse nao bloqueia a chamada externa
    * (regra #51), mas manter o MESMO modificador da base evita confusao.
    *
    * SELECT (par_cAliasCursor) ANTES de acessar os campos - a sintaxe
    * campo nao existe em VFP9 (regra #9 da migration_guide).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        TRY
            IF !EMPTY(loc_cAlias) AND USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF(loc_cAlias)
                    *-- cmoes char(3) - legado: crSigCdMoe.CMoes
                    IF TYPE(loc_cAlias + ".cmoes") == "C"
                        THIS.this_cCdMoeda = TratarNulo(cmoes, "")
                    ENDIF

                    *-- dmoes char(15) - legado: crSigCdMoe.DMoes
                    IF TYPE(loc_cAlias + ".dmoes") == "C"
                        THIS.this_cDsMoeda = TratarNulo(dmoes, "")
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao ler os dados da moeda:" + CHR(13) + loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarMoedaPorCodigo - get_cd_moeda.Valid do legado:
    *
    *     If !IsEmpty(This.Value) And !Seek(This.Value, 'crSigCdMoe', 'CMoes')
    *         <abre fwBuscaSel, atualiza Cd/Ds com a escolha ou com '' se ESC>
    *     Else
    *         If IsEmpty(This.Value)
    *             <Cd e Ds viram ''>
    *         Endif
    *     Endif
    *
    * Equivalente no sistema novo: SQLEXEC em SigCdMoe por cmoes. Achando,
    * carrega this_cCdMoeda/this_cDsMoeda via CarregarDoCursor e devolve .T.
    * Vazio, limpa os dois e devolve .T. (o legado nao trata isso como erro).
    * Nao achando, PRESERVA o codigo digitado em this_cCdMoeda - NUNCA se
    * apaga o que o usuario digitou (regra #37/#50) - e devolve .F. para o
    * Form abrir o FormBuscaAuxiliar (equivalente ao fwBuscaSel do legado).
    *==========================================================================
    PROCEDURE ValidarMoedaPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cCodigo, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cCodigo = IIF(VARTYPE(par_cCodigo) = "C", ALLTRIM(par_cCodigo), "")

        *-- Legado: Else / If IsEmpty(This.Value) -> ambos limpos, sem erro
        IF EMPTY(loc_cCodigo)
            THIS.this_cCdMoeda = ""
            THIS.this_cDsMoeda = ""
            RETURN .T.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cCdMoeda = loc_cCodigo
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                    "n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF USED("cursor_4c_Moeda")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Moeda") > 1
                        TABLEREVERT(.T., "cursor_4c_Moeda")
                    ENDIF
                    USE IN cursor_4c_Moeda
                ENDIF

                loc_cSQL = "SELECT cmoes, dmoes" + ;
                           "  FROM SigCdMoe" + ;
                           " WHERE cmoes = " + EscaparSQL(loc_cCodigo)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")

                IF loc_nResultado > 0 AND USED("cursor_4c_Moeda") AND RECCOUNT("cursor_4c_Moeda") > 0
                    SELECT cursor_4c_Moeda
                    GO TOP
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Moeda")
                ELSE
                    *-- Nao achou: preserva o digitado, NAO limpa (regra #50)
                    THIS.this_cCdMoeda = loc_cCodigo
                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao consultar a moeda:" + CHR(13) + CapturarErroSQL()
                    ENDIF
                    loc_lSucesso = .F.
                ENDIF

                IF USED("cursor_4c_Moeda")
                    USE IN cursor_4c_Moeda
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao validar a moeda:" + CHR(13) + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarMoedaPorDescricao - get_ds_moeda.Valid do legado: mesma logica de
    * ValidarMoedaPorCodigo, mas o Seek original casa por DMoes em vez de
    * CMoes:
    *
    *     If !IsEmpty(This.Value) And !Seek(This.Value, 'crSigCdMoe', 'DMoes')
    *         <abre fwBuscaSel>
    *     Else
    *         If IsEmpty(This.Value)
    *             <Cd e Ds viram ''>
    *         Endif
    *     Endif
    *==========================================================================
    PROCEDURE ValidarMoedaPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cDescricao, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        loc_cDescricao = IIF(VARTYPE(par_cDescricao) = "C", ALLTRIM(par_cDescricao), "")

        IF EMPTY(loc_cDescricao)
            THIS.this_cCdMoeda = ""
            THIS.this_cDsMoeda = ""
            RETURN .T.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cDsMoeda = loc_cDescricao
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados " + ;
                    "n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF USED("cursor_4c_Moeda")
                    IF CURSORGETPROP("Buffering", "cursor_4c_Moeda") > 1
                        TABLEREVERT(.T., "cursor_4c_Moeda")
                    ENDIF
                    USE IN cursor_4c_Moeda
                ENDIF

                loc_cSQL = "SELECT cmoes, dmoes" + ;
                           "  FROM SigCdMoe" + ;
                           " WHERE dmoes = " + EscaparSQL(loc_cDescricao)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moeda")

                IF loc_nResultado > 0 AND USED("cursor_4c_Moeda") AND RECCOUNT("cursor_4c_Moeda") > 0
                    SELECT cursor_4c_Moeda
                    GO TOP
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Moeda")
                ELSE
                    *-- Nao achou: preserva o digitado, NAO limpa (regra #50)
                    THIS.this_cDsMoeda = loc_cDescricao
                    IF loc_nResultado < 0
                        THIS.this_cMensagemErro = "Erro ao consultar a moeda:" + CHR(13) + CapturarErroSQL()
                    ENDIF
                    loc_lSucesso = .F.
                ENDIF

                IF USED("cursor_4c_Moeda")
                    USE IN cursor_4c_Moeda
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao validar a moeda:" + CHR(13) + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - contrato padrao do projeto (carga pela chave
    * primaria). Para este BO a chave EH a propria moeda, entao eh sinonimo
    * de ValidarMoedaPorCodigo (mesmo padrao de SigOpCotBO.CarregarPorCodigo).
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        RETURN THIS.ValidarMoedaPorCodigo(par_cCodigo)
    ENDPROC

    *==========================================================================
    * Confirmar - legado: Confirma.Click
    *     ThisForm.ParentForm.MoedaMaior = ThisForm.get_cd_moeda.value
    *     ThisForm.Release
    *
    * O legado NAO valida o valor antes de atribuir - mesmo com
    * get_cd_moeda vazio, o Confirma grava e fecha (regra #17: transcrever
    * literal, sem inventar validacao nova). Copiar this_cCdMoeda para a
    * property do form pai e fechar a tela (Release) ficam no Form, que eh
    * quem tem a referencia ao pai e ao proprio ciclo de vida da janela.
    *==========================================================================
    PROCEDURE Confirmar()
        THIS.this_lConfirmou = .T.
        THIS.this_lCancelado = .F.
        RETURN .T.
    ENDPROC

    *==========================================================================
    * Cancelar - legado: Cancela.Click
    *     ThisForm.ParentForm.CanceladoExterno = .T.
    *     ThisForm.Release
    *==========================================================================
    PROCEDURE Cancelar()
        THIS.this_lCancelado = .T.
        THIS.this_lConfirmou = .F.
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave de SigCdMoe (cmoes). PROTECTED porque a
    * BusinessBase declara assim (o modificador da base PREVALECE - regra
    * #51); nunca chamado de fora, e aqui so existe por completude, ja que
    * este BO nunca chega a RegistrarAuditoria (Inserir/Atualizar nao sao
    * sobrescritos - ver NOTA DE ARQUITETURA no cabecalho do arquivo).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCdMoeda)
    ENDPROC

    *==========================================================================
    * LimparDados - devolve o BO ao estado inicial (mesmo valor do Init,
    * exceto this_lExibirMoeda/this_lExibirConta, que sao parametros de
    * abertura da tela e nao mudam durante o uso do dialogo).
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCdMoeda   = ""
        THIS.this_cDsMoeda   = ""
        THIS.this_cGrupo     = ""
        THIS.this_cConta     = ""
        THIS.this_cDConta    = ""
        THIS.this_lCancelado = .F.
        THIS.this_lConfirmou = .F.

        RETURN .T.
    ENDPROC

ENDDEFINE

