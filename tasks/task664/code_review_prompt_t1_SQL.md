# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DEPO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS

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
		lcQuery = [Select PadEmails, PadServs, PadSenhas, pastas, PadPortas From SigCdEmp Where CEmps = '] + _EMPR + [']
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEmpMail') < 1)
		Local lcTO As String, lcFrom As String
		lcFrom = AllTrim( Nvl( ThisForm.CtnSaida_Email.TxtEmail_EnviarDE.Value,   "" ) ) 
		If Empty( lcFrom )
		ThisForm.oParentForm.oEMAIL.AddProperty( "cFrom",	lcFrom )

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprpdf.prg) - TRECHOS RELEVANTES PARA PASS SQL (1699 linhas total):

*-- Linhas 28 a 46:
28: *   compartilhado entre este dialogo e o form pai - a unica troca de dados e'
29: *   via PROPRIEDADES (par_oFormPai.Contaemail na leitura, pcArqEmail/oEMAIL na
30: *   escrita) e o unico cursor que este form abre (cursor_4c_TmpEmpMail, via
31: *   sigprpdfBO.ObterDadosContaEmail) usa gnConnHandle/SQLEXEC direto, que nao
32: *   e' escopado por data session privada. Replicar o SET DATASESSION sem um
33: *   cursor compartilhado para proteger seria copiar sintaxe sem a razao que a
34: *   justifica.
35: *   "poDataMgr = CreateObject('fSqlConector', ...)" - cada form legado cria a
36: *   propria conexao; na arquitetura nova a conexao e' UNICA e global
37: *   (gnConnHandle, aberta uma vez no startup por start\config.prg) - por isso
38: *   sigprpdfBO.ObterDadosContaEmail usa gnConnHandle direto, sem objeto de
39: *   conexao proprio por form.
40: *
41: * Historico de fases:
42: *   Fase 1/2: sigprpdfBO.prg (propriedades + metodos de negocio completos)
43: *   Fase 3:   Formsigprpdf.prg - estrutura base (heranca, propriedades
44: *             visuais, Init recebendo par_oFormPai/par_cAssunto,
45: *             InicializarForm criando o BO/validando conexao/resolvendo
46: *             this_cDiretorio, ConfigurarCabecalho equivalente ao cntSombra,

*-- Linhas 211 a 229:
211: * cnt_4c_Botoes com 6 botoes CRUD + AlternarPagina()". Conferido o dump do
212: * legado (tasks\task664\sigprpdf_form_codigo_fonte.txt e layout.json), SIGPRPDF
213: * nao tem NADA disso: zero "BaseClass: grid", zero "BaseClass: pageframe", zero
214: * AddCursor/pColuna/RecordSource/ControlSource e nenhum botao Incluir/
215: * Visualizar/Alterar/Excluir/Buscar - e' um dialogo MODAL de CAPTURA (800x360,
216: * TitleBar = 0, ControlBox = .F.) que coleta o nome do arquivo de saida e os
217: * dados do e-mail e devolve tudo ao form chamador. Inventar um PageFrame
218: * Lista/Dados com grade e 6 botoes CRUD violaria o PILAR 1 (UX fiel ao legado) e
219: * a regra "NUNCA inventar"; escrever ConfigurarPaginaLista/AlternarPagina vazios
220: * so para casar com o texto da fase seria o "stub disfarcado" que a regra de
221: * completude proibe. O que esta fase acrescenta, entao, e' a superficie que este
222: * legado DE FATO tem e que a Fase 3 (estrutura base) ainda nao tinha: a barra de
223: * acao, a area do arquivo de saida e o container colapsavel de e-mail.
224: *
225: * DIVERGENCIAS DELIBERADAS DO SCX (registradas para serem auditaveis)
226: * ------------------------------------------------------------------
227: *   SIGPRPDF.REGISTRY1 (classe "registry" do framework.vcx) e a cadeia
228: *   "optArquivo.option1.Enabled = Registry1.IsKey('PDFCreator.clsPDFCreator') Or
229: *   Registry1.IsKey('PDFCreatorBeta.JobQueue')" - NAO PORTADOS, pela mesma razao

*-- Linhas 392 a 410:
392:                 THIS.AlternarPainelEmail(.F.)
393: 
394:                 *-- Consulta de dados da conta de e-mail da empresa (o
395:                 *-- "Select ... From SigCdEmp Where CEmps = ..." do Init
396:                 *-- legado). Falha aqui IMPEDE a abertura da tela, igual ao
397:                 *-- "Return .f." do legado.
398:                 loc_lSucesso = THIS.CarregarContaEmailEmpresa()
399:             ENDIF
400:         CATCH TO loc_oErro
401:             loc_lSucesso = .F.
402:             MsgErro(loc_oErro.Message + CHR(13) + ;
403:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
404:                 "Procedure: " + loc_oErro.Procedure, ;
405:                 "Erro Formsigprpdf.InicializarForm")
406:         ENDTRY
407: 
408:         RETURN loc_lSucesso
409:     ENDPROC
410: 

*-- Linhas 1214 a 1254:
1214: 
1215:     *--------------------------------------------------------------------------
1216:     * CarregarContaEmailEmpresa - Equivalente ao trecho final do Init legado:
1217:     *   lcQuery = [Select PadEmails, PadServs, PadSenhas, pastas, PadPortas
1218:     *              From SigCdEmp Where CEmps = '] + _EMPR + [']
1219:     *   If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEmpMail') < 1)
1220:     *       =MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexao (TmpEmpMail)')
1221:     *       Return .f.
1222:     *   Endif
1223:     * A consulta propriamente dita esta no BO (ObterDadosContaEmail), que ja
1224:     * trata o cursor e mapeia as colunas em CarregarDoCursor. A empresa vem de
1225:     * go_4c_Sistema.cCodEmpresa - a global legada _EMPR NUNCA deve ser usada.
1226:     *
1227:     * Retorna .F. quando a consulta falha, reproduzindo o "Return .f." do
1228:     * legado - isto e', a tela NAO abre, porque sem os dados de SMTP o envio de
1229:     * e-mail nao teria como funcionar. Em modo de validacao de UI (sem conexao
1230:     * SQL) a consulta e' pulada e o retorno e' .T., senao nenhuma validacao
1231:     * conseguiria instanciar o form.
1232:     *
1233:     * O preenchimento visual que o legado faz em seguida
1234:     * ("CtnSaida_Email.TxtEmail_EnviarDE.Value = Lower(Alltrim(Nvl(
1235:     * TmpEmpMail.PadEmails,[])))") agora fica aqui: txt_4c_TxtEmail_EnviarDE
1236:     * (criado em ConfigurarCamposEmail, que roda ANTES deste metodo no
1237:     * InicializarForm) recebe this_cEmailDe so DEPOIS da consulta - exatamente
1238:     * como no legado, onde a atribuicao vem depois do
1239:     * "SqlExecute(lcQuery, 'TmpEmpMail')".
1240:     *--------------------------------------------------------------------------
1241:     PROCEDURE CarregarContaEmailEmpresa()
1242:         LOCAL loc_lSucesso, loc_cEmpresa
1243: 
1244:         loc_lSucesso = .T.
1245: 
1246:         IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
1247:             loc_cEmpresa = ""
1248:             IF TYPE("go_4c_Sistema") = "O"
1249:                 loc_cEmpresa = ALLTRIM(TratarNulo(go_4c_Sistema.cCodEmpresa, ""))
1250:             ENDIF
1251: 
1252:             IF !THIS.this_oBusinessObject.ObterDadosContaEmail(loc_cEmpresa)
1253:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
1254:                         "Falha na Conex" + CHR(227) + "o (TmpEmpMail)")

*-- Linhas 1271 a 1289:
1271:     * Por que o CONTROLE e' a fonte unica do valor: o Cmd_GerarPDF.Click legado
1272:     * nao consulta estado guardado em lugar nenhum, ele le o .Value na hora -
1273:     *   ThisForm.oParentForm.pcArqEmail = Alltrim(Nvl(This.Parent.TxtNomeArqSaida.Value, ""))
1274:     *   lcFrom = AllTrim(Nvl(ThisForm.CtnSaida_Email.TxtEmail_EnviarDE.Value,   ""))
1275:     *   lcTO   = AllTrim(Nvl(ThisForm.CtnSaida_Email.txtEmail_EnviarPara.Value, ""))
1276:     *   ...AddProperty("cCC",      AllTrim(Nvl(...txtEmail_CC.Value, "")))
1277:     *   ...AddProperty("cAssunto", AllTrim(Nvl(...txtEmail_Assunto.Value, "")))
1278:     *   ...AddProperty("cCorpo",   AllTrim(Nvl(...EdtEmail_Corpo.Value, "")))
1279:     *   If ThisForm.Chk_EMAIL.Value = 1
1280:     * Validar contra a property do BO sem reler a tela antes validaria o valor
1281:     * ANTIGO - o usuario limparia o campo 'PARA:' e a tela aprovaria o e-mail
1282:     * que estava la na abertura. O ALLTRIM/TratarNulo reproduz o Alltrim(Nvl())
1283:     * de cada linha acima.
1284:     *
1285:     * Chk_EMAIL.Value e' NUMERICO (CheckBox criado por AddObject): compara-se
1286:     * com 1 para virar o Logico this_lEnviarEmail - atribuir o numero direto a
1287:     * uma property declarada .F. faria o proximo AND no BO estourar.
1288:     * obj_4c_OptArquivo.Value e' o INDICE 1-based do OptionGroup (1 = PDF,
1289:     * 2 = XLS), nunca booleano.

*-- Linhas 1313 a 1331:
1313:     *       MessageBox([Selecione um nome para o arquivo!], 48, [Atencao])
1314:     *       This.Parent.CmdGetFile.SetFocus() / Return
1315:     *   If ThisForm.Chk_EMAIL.Value = 1
1316:     *       If Empty( lcFrom )
1317:     *           MessageBox("O campo 'DE:' nao foi preenchido.", 48, "Atencao")
1318:     *           ThisForm.CtnSaida_Email.TxtEmail_EnviarDE.SetFocus() / Return
1319:     *       If Empty( lcTO )
1320:     *           MessageBox("O campo 'PARA:' nao foi preenchido.", 48, "Atencao")
1321:     *           ThisForm.CtnSaida_Email.txtEmail_EnviarPara.SetFocus() / Return
1322:     * Devolve .T. quando passou e .F. quando recusou (ja tendo exibido a
1323:     * mensagem e dado o foco), para a fase de eventos escrever
1324:     * "IF !THIS.ValidarDadosEnvio() / RETURN / ENDIF" no Click do botao.
1325:     *
1326:     * PUBLIC porque e' chamado de fora (pelo handler do cmd_4c_Cmd_GerarPDF).
1327:     *
1328:     * FONTE UNICA DA REGRA: o texto e a ORDEM das tres checagens moram em
1329:     * sigprpdfBO.ValidarDadosConfirmacao(), que e' quem para na PRIMEIRA falha e
1330:     * devolve this_cMensagemErro + this_cCampoInvalido. Aqui fica so o que o BO
1331:     * nao pode fazer: ler a tela ANTES de validar (SincronizarCamposParaBO) e


### BO (C:\4c\projeto\app\classes\sigprpdfBO.prg):
*==============================================================================
* SIGPRPDFBO.PRG
* Business Object do formulario Formsigprpdf (Geracao de PDF e E-mail)
* Herda de: BusinessBase
*
* SIGPRPDF e um DIALOGO FILHO (WindowType = 1, modal), instanciado por outro
* form (par_oFormPai, equivalente a poformParent/ThisForm.oParentForm do
* legado) para o usuario escolher o nome/tipo do arquivo de saida (PDF ou
* XLS) e, opcionalmente, os dados do e-mail de envio. O proprio SIGPRPDF
* NAO gera o PDF/XLS nem envia o e-mail - o Cmd_GerarPDF.Click legado (linhas
* 749-823 do fonte original) apenas:
*   1) grava o caminho escolhido em ThisForm.oParentForm.pcArqEmail;
*   2) quando Chk_EMAIL.Value = 1, monta um objeto CUSTOM
*      (ThisForm.oParentForm.oEMAIL) com os dados de SMTP/mensagem via
*      AddProperty, e devolve esse objeto ao form PAI;
*   3) fecha o dialogo (ThisForm.Release()).
* Quem efetivamente gera o arquivo e dispara o envio e o form chamador
* (fora do escopo desta migracao - nao faz parte do acervo de SIGPRPDF).
*
* POR QUE this_cTabela/this_cCampoChave FICAM VAZIOS
* ---------------------------------------------------
* Nao ha CRUD nem PK proprios: a UNICA leitura ao SQL Server no Init legado
* e "Select PadEmails, PadServs, PadSenhas, pastas, PadPortas From SigCdEmp
* Where CEmps = <empresa>" (dados da conta de e-mail da empresa, colunas
* reais conferidas em docs/schema.sql - tabela sigcdemp: pademails,
* padservs, padsenhas, pastas, padportas). Nao ha Insert/Update/Delete em
* tabela nenhuma - por isso este BO (como o sigpremaBO irmao) nao sobrescreve
* Inserir()/Atualizar()/ExecutarExclusao(): o comportamento padrao herdado de
* BusinessBase (recusar a operacao) ja e o correto para esta tela.
*
* REGISTRY1 / PDFCREATOR (optArquivo.Option1.Enabled) - DECISAO DEFERIDA
* ------------------------------------------------------------------------
* O legado habilita a opcao "PDF" conforme
* "ThisForm.Registry1.IsKey('PDFCreator.clsPDFCreator') Or
* ThisForm.Registry1.IsKey('PDFCreatorBeta.JobQueue')" (deteccao de instalacao
* do PDFCreator via COM/Registro do Windows). O form irmao Formsigprema ja
* documentou a mesma checagem como NAO PORTADA (ver cabecalho de
* Formsigprema.prg) porque a geracao do PDF via PDFCreator esta fora do
* escopo do acervo migrado. A property this_lPdfCreatorDisponivel fica
* declarada aqui para a fase de Form decidir como resolve-la (registro real,
* sempre .T., ou configuravel) - Fase 1 so declara, nao decide.
*==============================================================================

DEFINE CLASS sigprpdfBO AS BusinessBase

    *-- Referencia ao form que instanciou este dialogo (equivalente a
    *-- ThisForm.oParentForm / par_oFormPai do legado) - usado para devolver
    *-- o caminho do arquivo escolhido (pcArqEmail) e os dados de envio
    *-- (oEMAIL) de volta ao chamador, e para ler o e-mail de destino inicial
    *-- (par_oFormPai.Contaemail)
    this_oFormPai = .NULL.

    *-- Diretorio padrao de saida (equivalente a ThisForm.Diretorio =
    *-- goSistema.DirFiscais), usado tanto para montar o nome default do
    *-- arquivo (FORTYUSPDF.PDF / FORTYUSEXCEL.XLS) quanto para abrir a
    *-- pasta via btnPastasA (CreateObject('Shell.Application').Open)
    this_cDiretorio = ""

    *-- Tipo de arquivo de saida (equivalente a optArquivo.Value - indice
    *-- 1-based do OptionGroup, NUNCA booleano): 1 = PDF, 2 = XLS
    this_nTipoArquivo = 1

    *-- .T. quando o PDFCreator (COM) esta disponivel na maquina
    *-- (equivalente a optArquivo.Option1.Enabled, resolvido via
    *-- Registry1.IsKey no legado - ver nota no cabecalho deste arquivo).
    *-- Resolucao definitiva fica para a fase do Form.
    this_lPdfCreatorDisponivel = .F.

    *-- Caminho completo do arquivo escolhido pelo usuario (equivalente a
    *-- txtNomeArqSaida.Value) - e o valor devolvido como
    *-- ThisForm.oParentForm.pcArqEmail ao confirmar (Cmd_GerarPDF.Click) e
    *-- tambem o anexo do e-mail (cAnexo) quando o envio esta habilitado
    this_cArquivoSaida = ""

    *-- .T. quando o usuario marcou a opcao de enviar e-mail (equivalente a
    *-- Chk_EMAIL.Value = 1) - controla a exibicao de CtnSaida_Email e se
    *-- Cmd_GerarPDF.Click monta o objeto de envio (oEMAIL) no form pai
    this_lEnviarEmail = .F.

    *-- Campos do bloco de e-mail (CtnSaida_Email), equivalentes a
    *-- cFrom/cTO/cCC/cAssunto/cCorpo do objeto oEMAIL montado no legado
    this_cEmailDe       = ""   && txtEmail_EnviarDE.Value (ReadOnly - preenchido com this_cEmpPadEmails)
    this_cEmailPara     = ""   && txtEmail_EnviarPara.Value (inicial: par_oFormPai.Contaemail)
    this_cEmailCC       = ""   && txtEmail_CC.Value
    this_cEmailAssunto  = ""   && txtEmail_Assunto.Value (inicial: par_cAssunto recebido no Init do form)
    this_cEmailCorpo    = ""   && EdtEmail_Corpo.Value

    *-- Dados da conta de e-mail da empresa (SigCdEmp.Cemps = empresa
    *-- corrente), equivalentes ao cursor TmpEmpMail do legado - colunas
    *-- reais conferidas em docs/schema.sql: pademails, padservs, padsenhas,
    *-- pastas, padportas
    this_cEmpPadEmails = ""   && pademails - conta remetente/usuario SMTP (cSendUserName/cFrom)
    this_cEmpPadServs  = ""   && padservs - servidor SMTP (cSmtpServer)
    this_cEmpPadSenhas = ""   && padsenhas - senha SMTP (cSendPassWord)
    this_cEmpPastas    = ""   && pastas - selecionada pelo legado (TmpEmpMail.pastas) mas nunca referenciada depois do Select; mantida so para rastrear a mesma consulta
    this_nEmpPadPortas = 0    && padportas - porta SMTP (nSmtpServerPort)

    *-- .T. apos ObterDadosContaEmail() carregar com sucesso os dados de
    *-- SigCdEmp (equivalente a "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0"
    *-- checado no Cmd_GerarPDF.Click legado antes de montar o objeto oEMAIL)
    this_lContaEmailCarregada = .F.

    *-- Identifica qual campo falhou na ultima chamada a
    *-- ValidarDadosConfirmacao() - "ARQUIVO" | "EMAIL_DE" | "EMAIL_PARA" |
    *-- "EMAIL_CONTA" | "" (sem falha). O Form usa isto so para decidir o
    *-- SetFocus, igual ao This.Parent.CmdGetFile.SetFocus() /
    *-- TxtEmail_EnviarDE.SetFocus() / txtEmail_EnviarPara.SetFocus() do
    *-- Cmd_GerarPDF.Click legado - a mensagem em si vai em this_cMensagemErro
    *-- (ja declarada em BusinessBase)
    this_cCampoInvalido = ""

    *==========================================================================
    * Init - Construtor
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()

            *-- SIGPRPDF nao tem tabela/PK propria (ver cabecalho do arquivo)
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_oFormPai = .NULL.
            THIS.this_cDiretorio = ""

            THIS.this_nTipoArquivo          = 1
            THIS.this_lPdfCreatorDisponivel = .F.
            THIS.this_cArquivoSaida         = ""
            THIS.this_lEnviarEmail          = .F.

            THIS.this_cEmailDe      = ""
            THIS.this_cEmailPara    = ""
            THIS.this_cEmailCC      = ""
            THIS.this_cEmailAssunto = ""
            THIS.this_cEmailCorpo   = ""

            THIS.this_cEmpPadEmails = ""
            THIS.this_cEmpPadServs  = ""
            THIS.this_cEmpPadSenhas = ""
            THIS.this_cEmpPastas    = ""
            THIS.this_nEmpPadPortas = 0

            THIS.this_lContaEmailCarregada = .F.
            THIS.this_cCampoInvalido       = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em sigprpdfBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas do cursor da conta de e-mail da
    * empresa (SigCdEmp) para as properties deste BO. Eh o hook canonico do
    * BusinessBase e o UNICO ponto do BO que le colunas de cursor - chamado por
    * ObterDadosContaEmail() depois do SQLEXEC, e tambem utilizavel pelo Form
    * quando o cursor TmpEmpMail/equivalente ja estiver aberto.
    *
    * As conversoes sao as do Init / Cmd_GerarPDF.Click legado, coluna a coluna
    * (linhas 652 e 801-804 do fonte original) - LOWER + ALLTRIM em PadEmails e
    * PadServs, so ALLTRIM em PadSenhas, Nvl(...,0) em PadPortas:
    *   TxtEmail_EnviarDE.Value = Lower(Alltrim(Nvl(TmpEmpMail.PadEmails, [])))
    *   "cSmtpServer"     <- Lower(Alltrim(Nvl(TmpEmpMail.PadServs,  "")))
    *   "nSmtpServerPort" <-            Nvl(TmpEmpMail.PadPortas, 0)
    *   "cSendUserName"   <- Lower(Alltrim(Nvl(TmpEmpMail.PadEmails, "")))
    *   "cSendPassWord"   <-       Alltrim(Nvl(TmpEmpMail.PadSenhas, "")))
    * Tipos conferidos em docs/schema.sql (tabela sigcdemp): pademails char(50),
    * padservs char(50), padsenhas char(30), pastas char(50), padportas
    * numeric(3,0) - por isso padportas vai para a property NUMERICA
    * this_nEmpPadPortas e as demais para properties de caractere.
    *
    * Marca this_lContaEmailCarregada, que eh o equivalente migrado de
    * "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0" checado no
    * Cmd_GerarPDF.Click legado antes de montar o objeto de envio.
    *
    * par_cAliasCursor: alias do cursor a ler. Retorna .T. se leu a linha.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_nAreaAnterior

        loc_lSucesso      = .F.
        loc_nAreaAnterior = SELECT()
        loc_cAlias        = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        THIS.this_lContaEmailCarregada = .F.

        TRY
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de dados da conta de e-mail " + ;
                                          "indispon" + CHR(237) + "vel."
            ELSE
                *-- Alias dinamico: SELECT (var) + acesso DIRETO aos campos.
                *-- NUNCA campo, que eh sintaxe invalida em VFP9.
                SELECT (loc_cAlias)
                GO TOP

                IF EOF(loc_cAlias)
                    THIS.this_cMensagemErro = "Conta de e-mail n" + CHR(227) + "o " + ;
                                              "cadastrada para a empresa."
                ELSE
                    *-- Existencia de campo em CURSOR se testa com TYPE(),
                    *-- NUNCA com PEMSTATUS (que exige objeto no 1o argumento)
                    IF TYPE(loc_cAlias + ".PadEmails") != "U"
                        THIS.this_cEmpPadEmails = LOWER(ALLTRIM(TratarNulo(PadEmails, "")))
                    ENDIF

                    IF TYPE(loc_cAlias + ".PadServs") != "U"
                        THIS.this_cEmpPadServs = LOWER(ALLTRIM(TratarNulo(PadServs, "")))
                    ENDIF

                    IF TYPE(loc_cAlias + ".PadSenhas") != "U"
                        THIS.this_cEmpPadSenhas = ALLTRIM(TratarNulo(PadSenhas, ""))
                    ENDIF

                    IF TYPE(loc_cAlias + ".Pastas") != "U"
                        THIS.this_cEmpPastas = ALLTRIM(TratarNulo(Pastas, ""))
                    ENDIF

                    *-- padportas eh numeric(3,0) no schema: NVL numerico, sem
                    *-- ALLTRIM/STR (ALLTRIM sobre numerico dispara o erro 11)
                    IF TYPE(loc_cAlias + ".PadPortas") != "U"
                        THIS.this_nEmpPadPortas = NVL(PadPortas, 0)
                    ENDIF

                    *-- Init legado: TxtEmail_EnviarDE.Value recebe PadEmails
                    THIS.this_cEmailDe = THIS.this_cEmpPadEmails

                    THIS.this_lContaEmailCarregada = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigprpdfBO.CarregarDoCursor")
        ENDTRY

        *-- Restaura a work area do chamador (o SELECT acima a trocou)
        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterDadosContaEmail - Carrega os dados da conta de e-mail parametrizada
    * para a empresa em SigCdEmp (equivalente a "Select PadEmails, PadServs,
    * PadSenhas, pastas, PadPortas From SigCdEmp Where CEmps = <empresa>"
    * no Init legado, que populava o cursor TmpEmpMail). par_cCodEmpresa deve
    * vir de go_4c_Sistema.cCodEmpresa (CLAUDE.md: NUNCA usar a legada _EMPR).
    *
    * Tambem repete o que o Init legado fazia com o resultado -
    * THIS.this_cEmailDe recebe PadEmails em minusculo/trim, equivalente a
    * "Thisform.CtnSaida_Email.TxtEmail_EnviarDE.Value = Lower(Alltrim(Nvl(
    * TmpEmpMail.PadEmails, [])))".
    *
    * Retorna .T. se a consulta foi executada com sucesso. Em caso de falha,
    * reproduz a mensagem do legado ("Favor Reinicializar o Processo!!!") em
    * this_cMensagemErro - o Form decide como exibir (MsgErro).
    *==========================================================================
    PROCEDURE ObterDadosContaEmail(par_cCodEmpresa)
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.
        THIS.this_lContaEmailCarregada = .F.
        THIS.this_cMensagemErro        = ""

        TRY
            IF USED("cursor_4c_TmpEmpMail")
                USE IN cursor_4c_TmpEmpMail
            ENDIF

            loc_cSQL = "SELECT PadEmails, PadServs, PadSenhas, Pastas, PadPortas " + ;
                       "FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(TratarNulo(par_cCodEmpresa, "")))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmpMail") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE
                *-- A leitura das colunas fica num lugar so (CarregarDoCursor),
                *-- que eh o hook canonico do BusinessBase para esse mapeamento
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_TmpEmpMail")

                IF !loc_lSucesso AND EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigprpdfBO.ObterDadosContaEmail")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterNomeArquivoPadrao - Monta o nome/caminho default do arquivo de
    * saida, equivalente a:
    *   Init legado:        ThisForm.Diretorio + [FORTYUSPDF.] + Iif(... ,[PDF],[XLS])
    *   optArquivo.Click:   ThisForm.Diretorio + [FORTYUSPDF.PDF] / [FORTYUSEXCEL.XLS]
    * par_nTipoArquivo: 1 = PDF, 2 = XLS (THIS.this_nTipoArquivo - indice
    * 1-based do OptionGroup, NUNCA booleano - CLAUDE.md regra sobre
    * ControlSource numerico).
    *==========================================================================
    PROCEDURE ObterNomeArquivoPadrao(par_nTipoArquivo)
        LOCAL loc_cDir

        loc_cDir = ALLTRIM(TratarNulo(THIS.this_cDiretorio, ""))
        IF !EMPTY(loc_cDir) AND RIGHT(loc_cDir, 1) != "\"
            loc_cDir = loc_cDir + "\"
        ENDIF

        RETURN loc_cDir + IIF(par_nTipoArquivo = 1, "FORTYUSPDF.PDF", "FORTYUSEXCEL.XLS")
    ENDPROC

    *==========================================================================
    * ValidarDadosConfirmacao - Reproduz, na ordem, as DUAS checagens
    * BLOQUEANTES do Cmd_GerarPDF.Click legado - as unicas que fazem Return
    * antecipado (o dialogo NAO fecha):
    *   1) nome do arquivo de saida preenchido (senao, igual ao legado,
    *      MessageBox + This.Parent.CmdGetFile.SetFocus());
    *   2) quando this_lEnviarEmail = .T. (Chk_EMAIL.Value = 1):
    *      2a) campo 'DE:' preenchido (TxtEmail_EnviarDE.SetFocus());
    *      2b) campo 'PARA:' preenchido (txtEmail_EnviarPara.SetFocus()).
    *
    * A terceira checagem do legado (conta de e-mail da empresa ausente -
    * "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0") NAO bloqueia: o
    * Else so exibe MessageBox('Problemas na selecao de dados do email...')
    * SEM Return, e o fluxo segue at? ThisForm.Release() (o dialogo fecha
    * mesmo assim, so sem montar o objeto de envio). Por isso essa checagem
    * fica fora deste metodo - o Form consulta THIS.this_lContaEmailCarregada
    * direto para decidir se exibe o aviso antes de chamar
    * MontarDadosEnvioEmail(), sem impedir o fechamento.
    *
    * Retorna .T. se passou nas duas checagens bloqueantes. Em caso de
    * falha, preenche this_cMensagemErro (texto IDENTICO ao MessageBox
    * legado) e this_cCampoInvalido (para o Form decidir o SetFocus) e para
    * na PRIMEIRA falha, igual ao Return antecipado do legado.
    *==========================================================================
    PROCEDURE ValidarDadosConfirmacao()
        LOCAL loc_lValido

        loc_lValido = .F.
        THIS.this_cMensagemErro  = ""
        THIS.this_cCampoInvalido = ""

        TRY
            IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cArquivoSaida, "")))
                THIS.this_cMensagemErro  = "Selecione um nome para o arquivo!"
                THIS.this_cCampoInvalido = "ARQUIVO"
            ELSE
                IF !THIS.this_lEnviarEmail
                    loc_lValido = .T.
                ELSE
                    IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cEmailDe, "")))
                        THIS.this_cMensagemErro  = "O campo 'DE:' n" + CHR(227) + "o foi preenchido."
                        THIS.this_cCampoInvalido = "EMAIL_DE"
                    ELSE
                        IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cEmailPara, "")))
                            THIS.this_cMensagemErro  = "O campo 'PARA:' n" + CHR(227) + "o foi preenchido."
                            THIS.this_cCampoInvalido = "EMAIL_PARA"
                        ELSE
                            loc_lValido = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigprpdfBO.ValidarDadosConfirmacao")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * ObterMensagemContaEmailIndisponivel - Mensagem a exibir (sem bloquear o
    * fechamento do dialogo) quando this_lEnviarEmail = .T. mas
    * this_lContaEmailCarregada = .F. - equivalente ao Else sem Return de
    * "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0" no Cmd_GerarPDF.Click
    * legado. Ver nota em ValidarDadosConfirmacao sobre por que esta checagem
    * NAO entra na cadeia bloqueante.
    *==========================================================================
    PROCEDURE ObterMensagemContaEmailIndisponivel()
        RETURN "Problemas na sele" + CHR(231) + CHR(227) + "o de dados do email. Favor enviar novamente."
    ENDPROC

    *==========================================================================
    * MontarDadosEnvioEmail - Monta a estrutura de envio equivalente ao
    * objeto CUSTOM que o Cmd_GerarPDF.Click legado cria em
    * ThisForm.oParentForm.oEMAIL via AddProperty (cSmtpServer, nSmtpServerPort,
    * cSendUserName, cSendPassWord, cFrom, cTO, cCC, cAssunto, cCorpo, cAnexo).
    * Devolve um objeto CUSTOM com as mesmas properties, na mesma grafia, para
    * o Form atribuir direto a par_oFormPai.oEMAIL - este BO nao conhece o
    * form pai, so monta o objeto (THIS.this_oFormPai existe so para o Form
    * usar, nunca eh referenciado por este BO).
    *
    * Chamar APENAS depois de ValidarDadosConfirmacao() retornar .T. E
    * this_lContaEmailCarregada = .T. - este metodo nao revalida. Sem os
    * dados da conta (this_lContaEmailCarregada = .F.), devolve .NULL.,
    * equivalente ao legado NAO atribuir ThisForm.oParentForm.oEMAIL quando
    * "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0" falha.
    *==========================================================================
    PROCEDURE MontarDadosEnvioEmail()
        LOCAL loc_oEmail

        IF !THIS.this_lContaEmailCarregada
            RETURN .NULL.
        ENDIF

        loc_oEmail = CREATEOBJECT("Empty")

        ADDPROPERTY(loc_oEmail, "cSmtpServer",     THIS.this_cEmpPadServs)
        ADDPROPERTY(loc_oEmail, "nSmtpServerPort", THIS.this_nEmpPadPortas)
        ADDPROPERTY(loc_oEmail, "cSendUserName",   THIS.this_cEmpPadEmails)
        ADDPROPERTY(loc_oEmail, "cSendPassWord",   THIS.this_cEmpPadSenhas)
        ADDPROPERTY(loc_oEmail, "cFrom",           ALLTRIM(TratarNulo(THIS.this_cEmailDe, "")))
        ADDPROPERTY(loc_oEmail, "cTO",             ALLTRIM(TratarNulo(THIS.this_cEmailPara, "")))
        ADDPROPERTY(loc_oEmail, "cCC",             ALLTRIM(TratarNulo(THIS.this_cEmailCC, "")))
        ADDPROPERTY(loc_oEmail, "cAssunto",        ALLTRIM(TratarNulo(THIS.this_cEmailAssunto, "")))
        ADDPROPERTY(loc_oEmail, "cCorpo",           ALLTRIM(TratarNulo(THIS.this_cEmailCorpo, "")))
        ADDPROPERTY(loc_oEmail, "cAnexo",           THIS.this_cArquivoSaida)

        RETURN loc_oEmail
    ENDPROC

    *==========================================================================
    * Destroy - Libera o cursor de trabalho aberto por este BO
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_TmpEmpMail")
            USE IN cursor_4c_TmpEmpMail
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

