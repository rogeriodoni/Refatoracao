# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SENHAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PDESCS, PARENTFORM, LIMDESCS, DESCPORS, CCARGS, LIMACRES, ACREPORS, TIPO, SENHADS, CIDCHAVES, TIPOS, CHKBINS, BLQTABDS, CODIGOS, NIVELS, LIMITES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: PDESCS, PARENTFORM, LIMDESCS, DESCPORS, CCARGS, LIMACRES, ACREPORS, TIPO, SENHADS, CIDCHAVES, TIPOS, CHKBINS, BLQTABDS, CODIGOS, NIVELS, LIMITES

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
			lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b Where Not a.cAtivos='N' And ]+;
			lcQuery = [Select a.* ] + ;
						[From SigCdUsu a, SigCdCrg b ] + ;
			lcQuery = [Select a.* From SigCdUsu a, SigCdCrg b Where Not a.cAtivos='N' And ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpUsu') < 1)
	Select TmpUsu
	If !IsEmpty( This.Value ) And !Seek( This.Value, 'TmpUsu', 'Usuarios' )
	Select TmpUsu
	lcQuery = [Select EmpDopNums, CidChaves From SigPrSnd Where SenhaDs = '] + Alltrim(This.Value) + [']
	Thisform.podatamgr.SqlExecute(lcQuery,[TmpPrSnd])
	lcQuery = [Update SigPrSnd Set EmpDopNums = '] + lcEDN + [' Where CidChaves = '] + TmpPrSnd.CidChaves + [']
	Thisform.podatamgr.SqlExecute(lcQuery,[])
	select TmpUsu
	lcQuery = [Select a.*, b.Emps ] + ;
				[From SigCdFs a Left Join SigCdFsI b On a.Codigos = b.Codigos ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalMdsc1]) < 1)
	Select Distinct Codigos, Descrs From LocalMdsc1 Where Nvl(Emps,Thisform.pemps) = ThisForm.pEmps Into Cursor LocalMdsc ReadWrite
	Select * From LocalMdsc Into Cursor TmpMdsc ReadWrite
		lcSql = [Select b.* From SigCdClc a, SigCdCmt b Where a.Codigos = ']+ThisForm.ClaConta+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'TmpClaMt') < 1)
		Select TmpClaMt
			Select a.* From LocalMdsc a, TmpClaMt b Where a.Codigos = b.codigos And b.Tipos = 1 ;
			Select TmpClaMt
				Select * From LocalMdsc Where Codigos Not in (Select Codigos From TmpClaMt Where Tipos = 2 ) ;
	Select TmpMdsc
	If !Seek( This.Value, 'TmpMdsc', 'Codigos' )

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLim.prg) - TRECHOS RELEVANTES PARA PASS SQL (1811 linhas total):

*-- Linhas 50 a 68:
50: *   BaseClass: grid ............. 0     BaseClass: pageframe ....... 0
51: *   BaseClass: listbox .......... 0     commandbutton/commandgroup . 0
52: *   AddCursor ................... 0     pColuna .................... 0
53: *   RecordSource ................ 0     ControlSource .............. 0
54: *   token \bGrade\b | \bgrd ..... 0     API de nos (.Nodes.Add...) . 0
55: *   BaseClass: textbox .......... 3     (usuario, senha, get_Motivo)
56: *   ReadOnly = .T. .............. 0     (os 3 campos sao de ENTRADA)
57: *
58: * Nao ha UM CommandButton/CommandGroup na arvore: o dialogo se encerra pelos
59: * proprios Valid dos campos (thisform.release()), nunca por botao - por isso
60: * nao existe nem o cnt_4c_Saida/cmd_4c_Encerrar canonico (regra #10, que eh
61: * dos CRUD de 1000px; em 400px o Left=917 ficaria 517px fora da tela).
62: *
63: * Com zero lista e campos de ENTRADA (nenhum ReadOnly), o gate da Fase 4
64: * dispensa Grid/CRUD pelo ramo CAPTURA (temLayoutCaptura, case 4 do
65: * OrquestradorMigracao.ps1) - o mesmo ramo de SIGMVVDE/FormSigMvVde. Medido
66: * com os helpers REAIS do orquestrador: temListaEstritaF4 = False,
67: * temCampoCapturaF4 = True, DialogoExibicao = False => legadoCapturaF4 = True.
68: *

*-- Linhas 138 a 156:
138: *    nao como string. O Init legado absorve isso com
139: *    Iif(Type('pClaConta')='C', pClaConta, ' ') - e eh por isso que o Init
140: *    migrado testa VARTYPE = "C" em vez de so PCOUNT: so PCOUNT deixaria um
141: *    LOGICO entrar numa property de caractere, e o EscaparSQL seguinte
142: *    montaria WHERE com .F..
143: *
144: * O retorno eh lido por "to chklim" (o Unload) e testado com
145: * Type('ChkLim') = 'L' And Not chklim: LOGICO .F. significa NEGADO e
146: * qualquer CARACTERE significa autorizado. ObterResultado() devolve a mesma
147: * coisa para quem abrir por CREATEOBJECT.
148: *
149: * Consumo:
150: *   loDlg = CREATEOBJECT("FormSigOpLim", lnItens, lnValor, lnPerc, "D", .T.)
151: *   IF VARTYPE(loDlg) = "O"
152: *       loDlg.Show()                    && modal - bloqueia
153: *       luZSenha = loDlg.ObterResultado()
154: *   ENDIF                               && com Release - ver FecharDialogo
155: *==============================================================================
156: 

*-- Linhas 943 a 962:
943:     *
944:     *   If Not IsEmpty(This.Value)
945:     *       <monta LocalMdsc1 / LocalMdsc / TmpMdsc>   = BO.BuscarMotivos()
946:     *       If SqlExecute < 1 -> MessageBox 'Favor Reinicializar o Processo!!!'
947:     *       Select TmpMdsc ; Index on Codigos Tag Codigos
948:     *       If !Seek(This.Value,'TmpMdsc','Codigos')
949:     *           fwBuscaSel('TmpMdsc','codigos',...)    = AbrirBuscaMotivo()
950:     *           This.Value = TmpMdsc.Codigos
951:     *       Endif
952:     *       If Lastkey() = 27 -> Zsenha = .F. ; release
953:     *       Else
954:     *           If somotivo -> Zsenha = Space(10) + This.Value ; Release
955:     *       EndIf
956:     *   Else
957:     *       Resp = Messagebox('Motivo nao Informado!, Deseja Continuar ? (S/N)',
958:     *                          4+256, '')
959:     *       If Resp = 7 -> Zsenha = .F. ; release   Else return 0
960:     *   EndIf
961:     *
962:     * SEEK com PADR ate a largura REAL da coluna (FSIZE), nao com o valor cru.

*-- Linhas 994 a 1022:
994:             IF THIS.this_oBusinessObject.BuscarMotivos()
995:                 *-- BuscarMotivos ja fecha com INDEX ON codigos TAG codigos
996:                 IF USED(loc_cCursor)
997:                     SELECT (loc_cCursor)
998:                     loc_lAchou = SEEK(PADR(loc_cValor, FSIZE("codigos", loc_cCursor)), ;
999:                         loc_cCursor, "codigos")
1000:                 ENDIF
1001: 
1002:                 IF !loc_lAchou
1003:                     THIS.AbrirBuscaMotivo()
1004: 
1005:                     loc_cValor = ALLTRIM(NVL(THIS.txt_4c__Motivo.Value, ""))
1006:                     IF USED(loc_cCursor) AND !EMPTY(loc_cValor)
1007:                         SELECT (loc_cCursor)
1008:                         loc_lAchou = SEEK(PADR(loc_cValor, FSIZE("codigos", loc_cCursor)), ;
1009:                             loc_cCursor, "codigos")
1010:                     ENDIF
1011:                 ENDIF
1012: 
1013:                 IF loc_lAchou
1014:                     THIS.this_oBusinessObject.CarregarMotivoDoCursor(loc_cCursor)
1015: 
1016:                     *-- Legado: "This.Value = TmpMdsc.Codigos" apos o browse
1017:                     THIS.BOParaForm()
1018: 
1019:                     *-- Legado: If ThisForm.somotivo /
1020:                     *--         ThisForm.Zsenha = Space(10) + This.Value /
1021:                     *--         ThisForm.Release
1022:                     *--

*-- Linhas 1056 a 1074:
1056:     * fwBuscaSel busca em CURSOR LOCAL ja populado, nao em tabela: por isso o
1057:     * FormBuscaAuxiliar eh usado pela API de cursor pre-populado
1058:     * (CREATEOBJECT sem parametros + DefinirCursor + Mostrar), nunca pelo Init
1059:     * com parametros - esse faz SQLEXEC proprio contra uma TABELA e abriria o
1060:     * picker VAZIO, alem de ignorar os filtros de Emps/ClaConta que o BO ja
1061:     * aplicou.
1062:     *
1063:     * O cursor NAO eh fechado aqui: ValidarMotivoExec faz o SEEK nele logo
1064:     * depois, e o ciclo de vida dele eh do BO (BuscarMotivos fecha e recria).
1065:     *--------------------------------------------------------------------------
1066:     PROCEDURE AbrirBuscaMotivo()
1067:         LOCAL loc_oBusca, loc_cCursor, loc_lEmLookupAnt, loc_oErro
1068: 
1069:         IF THIS.this_lEncerrando
1070:             RETURN
1071:         ENDIF
1072: 
1073:         *-- save/restore, nao set/clear: este metodo eh chamado de DENTRO de
1074:         *-- ValidarMotivoExec (que ja ligou a flag) e tambem direto pelo F4 e

*-- Linhas 1162 a 1188:
1162:     *
1163:     *   If !IsEmpty(This.Value)
1164:     *       <Do Case por Tipo -> TmpUsu>   = BO.BuscarUsuariosAutorizados()
1165:     *       If SqlExecute < 1 -> MessageBox 'Favor Reinicializar o Processo!!!'
1166:     *       Select TmpUsu ; Index on usuarios Tag usuarios
1167:     *       If !Seek(This.Value,'TmpUsu','Usuarios')
1168:     *           fwBuscaSel('TmpUsu','Usuarios',...)   = AbrirBuscaUsuario()
1169:     *           This.Value = TmpUsu.Usuarios
1170:     *       Endif
1171:     *       Usual = This.Value
1172:     *       If IsEmpty(usual) Or Lastkey() = 27 -> Zsenha = .F. ; release
1173:     *       Select TmpUsu
1174:     *       If limdescs = "S" And Tipo <> [X]
1175:     *           zsen  = padr(ThisForm.GeraSenha(date()),06)
1176:     *           zsen1 = fCriptografar(senhas)
1177:     *       else
1178:     *           zsen  = fCriptografar(senhas)
1179:     *       endif
1180:     *       thisform.say3.visible  = .t.
1181:     *       thisform.senha.visible = .t.
1182:     *   Else
1183:     *       ThisForm.zSenha = .f. ; ThisForm.Release
1184:     *   EndIf
1185:     *
1186:     * O BLOCO zsen/zsen1 NAO eh reproduzido, e a omissao eh deliberada - sao
1187:     * DEAD STORES no proprio legado: nem zsen nem zsen1 sao lidos em lugar
1188:     * nenhum do SCX (senha.Valid recalcula a senha do zero com

*-- Linhas 1218 a 1253:
1218:                 *-- BuscarUsuariosAutorizados ja fecha com
1219:                 *-- INDEX ON usuarios TAG usuarios
1220:                 IF USED(loc_cCursor)
1221:                     SELECT (loc_cCursor)
1222:                     loc_lAchou = SEEK(PADR(loc_cValor, FSIZE("usuarios", loc_cCursor)), ;
1223:                         loc_cCursor, "usuarios")
1224:                 ENDIF
1225: 
1226:                 IF !loc_lAchou
1227:                     THIS.AbrirBuscaUsuario()
1228: 
1229:                     loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Usuario.Value, ""))
1230:                     IF USED(loc_cCursor) AND !EMPTY(loc_cValor)
1231:                         SELECT (loc_cCursor)
1232:                         loc_lAchou = SEEK(PADR(loc_cValor, FSIZE("usuarios", loc_cCursor)), ;
1233:                             loc_cCursor, "usuarios")
1234:                     ENDIF
1235:                 ENDIF
1236: 
1237:                 IF loc_lAchou
1238:                     *-- Legado: Select TmpUsu (a linha do autorizador fica
1239:                     *-- corrente e senha.Valid le TmpUsu.senhas/.usuarios)
1240:                     THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursor)
1241: 
1242:                     *-- Legado: thisform.say3.visible  = .t.
1243:                     *--         thisform.senha.visible = .t.
1244:                     THIS.lbl_4c_Label3.Visible = .T.
1245:                     THIS.txt_4c_Senha.Visible  = .T.
1246: 
1247:                     *-- Legado: "This.Value = TmpUsu.Usuarios" - o codigo que
1248:                     *-- vale eh o do CURSOR, nao o que foi digitado (que pode
1249:                     *-- diferir em caixa/padding do canonico).
1250:                     THIS.BOParaForm()
1251: 
1252:                     *-- O When de senha passa a valer agora que Usuario.Value
1253:                     *-- esta preenchido

*-- Linhas 1279 a 1297:
1279:     *
1280:     * Mesma API de cursor pre-populado do AbrirBuscaMotivo. O universo aqui
1281:     * NAO eh "todos os usuarios" - eh so quem tem alcada para o valor e o
1282:     * percentual pedidos (o Do Case por Tipo do BO). Trocar por um SELECT
1283:     * direto em SigCdUsu mostraria usuarios sem alcada e deixaria o dialogo
1284:     * autorizar o que o legado recusa.
1285:     *--------------------------------------------------------------------------
1286:     PROCEDURE AbrirBuscaUsuario()
1287:         LOCAL loc_oBusca, loc_cCursor, loc_lEmLookupAnt, loc_oErro
1288: 
1289:         IF THIS.this_lEncerrando
1290:             RETURN
1291:         ENDIF
1292: 
1293:         loc_lEmLookupAnt = THIS.this_lEmLookupUsuario
1294:         THIS.this_lEmLookupUsuario = .T.
1295: 
1296:         TRY
1297:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorUsuarios

*-- Linhas 1368 a 1390:
1368:     * Legado (SIGOPLIM.senha.Valid), transcrito:
1369:     *
1370:     *   If Thisform.Tipo = 'L'                     && senha livre
1371:     *       Select ... From SigPrSnd Where SenhaDs = <valor>
1372:     *       If Eof -> 'Senha invalida.' ; Zsenha = .F. ; release
1373:     *       If !Empty(EmpDopNums) -> 'Senha ja utilizada.' ; Zsenha=.F. ; release
1374:     *       lcEDN = TprMvCab.Emps + TprMvCab.Dopes + Str(TprMvCab.Numes,6)
1375:     *       Update SigPrSnd Set EmpDopNums = lcEDN Where CidChaves = ...
1376:     *       ThisForm.Zsenha = Usuar ; release
1377:     *   Else
1378:     *       Senha = fCriptografar(TmpUsu.senhas)
1379:     *       If Padr(this.value,10) <> Padr(senha,10)
1380:     *           resp = messagebox('Senha Conflitante. Deseja Continuar?',4+256,'Aviso')
1381:     *           if resp = 7 -> Zsenha = .F. ; release   else return 0
1382:     *       Else
1383:     *           Zsenha = Iif(Tipo = [X], Usuario.Value,
1384:     *                        TmpUsu.Usuarios + Get_motivo.Value)
1385:     *           release
1386:     *       Endif
1387:     *   Endif
1388:     *
1389:     * Os tres ramos de composicao do retorno moram no BO
1390:     * (ComporAutorizacaoSenhaLivre / ComporAutorizacaoUsuarioSenha, mais

*-- Linhas 1476 a 1494:
1476:     * Chave POSICIONAL (regra #42): o padding FAZ PARTE da chave. Emps char(3)
1477:     * + Dopes char(20) + STR(Numes,6) = 29 = SigPrSnd.EmpDopNums char(29) -
1478:     * conferido no docs/schema.sql. PADR em CADA parte; ALLTRIM nas partes
1479:     * encurtaria a chave e o UPDATE casaria a linha errada (ou nenhuma).
1480:     *
1481:     * TprMvCab eh cursor GLOBAL do form chamador (Fortyus), que este dialogo
1482:     * nao possui. Ausente, devolve vazio - e o BO gravaria EmpDopNums em
1483:     * branco, que para o legado significa "senha ainda disponivel", ou seja a
1484:     * senha seria aceita e continuaria reutilizavel. Por isso o retorno vazio
1485:     * NAO eh silencioso: quem chamar com Tipo = "L" sem TprMvCab aberto recebe
1486:     * o aviso.
1487:     *--------------------------------------------------------------------------
1488:     PROTECTED FUNCTION MontarEmpDopNumsMovimento()
1489:         LOCAL loc_cChave
1490: 
1491:         loc_cChave = ""
1492: 
1493:         IF USED("TprMvCab")
1494:             IF !EOF("TprMvCab")


### BO (C:\4c\projeto\app\classes\SigOpLimBO.prg):
*==============================================================================
* SigOpLimBO.prg - Business Object para SigOpLim (Limite de Descontos)
*
* Form OPERACIONAL do tipo DIALOGO DE AUTORIZACAO ("Limite Ultrapassado...").
* Nao eh cadastro: nao inclui, nao altera e nao exclui registro proprio. O
* legado (SIGOPLIM.SCX) eh chamado por outra tela quando o operador tenta um
* desconto/acrescimo acima do limite do cargo dele, e devolve em ThisForm.zsenha
* a credencial de quem liberou (ou .F. quando a liberacao foi negada).
*
* Fluxos do legado, selecionados por this_cTipo:
*   "D" - Desconto  : confere SigCdCrg.Limdescs / DescPors
*   "A" - Acrescimo : confere SigCdCrg.Limacres / AcrePors  (ramo Other do Do Case)
*   "X" - Limite    : confere SigCdCrg.Limites = "S" (ignora valor/percentual)
*   "L" - Senha livre: ignora usuario/cargo e consome senha pre-cadastrada
*                      em SigPrSnd (marcando-a como utilizada)
*
* Tabelas lidas (nomes e colunas conferidos em docs/schema.sql):
*   SigCdUsu  usuarios, senhas, ccargs, cativos, limdescs char(1)
*   SigCdCrg  ccargs, limdescs/descpors/limacres/acrepors numeric, nivels, limites
*   SigPrSnd  senhads, empdopnums, cidchaves          (senha livre)
*   SigCdFs   codigos, descrs, tipos, chkbins, blqtabds (motivos)
*   SigCdFsI  codigos, emps                            (motivo por empresa)
*   SigCdClc  codigos, cidchaves                       (classificacao da conta)
*   SigCdCmt  codigos, fkchaves, tipos                 (motivos da classificacao)
*
* ATENCAO - colunas homonimas de tipos DIFERENTES (regra #22 do CLAUDE.md):
*   SigCdUsu.limdescs eh char(1)        -> this_cLimDescs  (teste = "S")
*   SigCdCrg.limdescs eh numeric(11,2)  -> entra so no WHERE da consulta
* O "If limdescs = 'S'" do legado roda sobre TmpUsu (Select a.* de SigCdUsu),
* portanto eh a coluna CHAR. Trocar uma pela outra quebra a comparacao.
*
* Unica gravacao do fluxo: UPDATE SigPrSnd SET EmpDopNums (marca senha livre
* como consumida). Nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao() -
* o comportamento padrao herdado de BusinessBase ja eh o correto.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpLimBO AS BusinessBase

    *==========================================================================
    * Parametros recebidos do form chamador
    * Legado: Parameter totite, valor, pvalor, tipo, poform, Pcx, pMotivo,
    *                   pClaConta, plCheckBin, plCheckTabD, pcEmpresa
    * (poform/Pcx - form pai e data manager - ficam no Form, nao no BO: o
    *  acesso a dados aqui usa gnConnHandle)
    *==========================================================================
    this_nTotIte   = 0      && totite  - Total de itens da operacao
    this_nValDesc  = 0      && valor   - Valor do desconto/acrescimo pedido
    this_nPDescs   = 0      && pvalor  - Percentual do desconto/acrescimo pedido
    this_cTipo     = "D"    && tipo    - "D"/"C"/"X"/"L" (default "D" como no legado)
    this_lMotivo   = .F.    && pMotivo - .T. quando a tela exige informar motivo
    this_cClaConta = " "    && pClaConta - Classificacao da conta (SigCdClc.codigos)
    this_lCheckBin = .F.    && plCheckBin  - .T. filtra motivos com SigCdFs.ChkBins  <> 1
    this_lCheckTbd = .F.    && plCheckTabD - .T. filtra motivos com SigCdFs.BlqTabDs <> 1
    this_cEmps     = ""     && pcEmpresa - Empresa (SigCdFsI.emps); default = empresa logada

    *==========================================================================
    * Estado derivado (calculado a partir dos parametros)
    *==========================================================================
    *-- somotivo do legado: ( totite + valor + pvalor = 0 ) And ( Tipo <> "X" )
    *-- Quando .T. a tela pede SOMENTE o motivo, sem usuario/senha.
    this_lSoMotivo = .F.

    *==========================================================================
    * Resultado da autorizacao (equivale a ThisForm.zsenha do legado)
    *
    * No legado zsenha eh variante: recebe .F. quando negado e uma STRING
    * quando liberado. Aqui a decisao fica em this_lAutorizado (logico) e o
    * conteudo em this_cZSenha (caractere), para nao haver property de tipo
    * ambiguo; o Form remonta o valor de retorno do dialogo.
    *
    * Conteudo por tipo, conforme o legado:
    *   "X" -> usuario digitado
    *   "L" -> usuario logado (Usuar)
    *   so motivo -> Space(10) + codigo do motivo
    *   demais    -> SigCdUsu.usuarios + codigo do motivo
    *==========================================================================
    this_lAutorizado = .F.
    this_cZSenha     = ""

    *==========================================================================
    * Usuario autorizador selecionado (SigCdUsu / TmpUsu do legado)
    *==========================================================================
    this_cUsuarios = ""    && char(10) - Codigo do usuario que libera
    this_cSenhas   = ""     && char(10) - Senha gravada (conferida via fCriptografar)
    this_cCCargs   = ""     && char(10) - Cargo do usuario (FK SigCdCrg.ccargs)
    this_cLimDescs = ""     && char(1)  - SigCdUsu.limdescs ("S" = senha por data)

    *==========================================================================
    * Motivo selecionado (SigCdFs)
    *==========================================================================
    this_cCodigoMotivo  = ""   && char(10) - SigCdFs.codigos
    this_cDescrsMotivo  = ""   && char(40) - SigCdFs.descrs

    *==========================================================================
    * Senha livre (SigPrSnd) - fluxo this_cTipo = "L"
    *==========================================================================
    this_cSenhaDs     = ""   && char(6)  - Senha pre-cadastrada digitada
    this_cCidChaves   = ""   && char(20) - PK da senha livre localizada
    this_cEmpDopNums  = ""   && char(29) - Movimento que consumiu a senha
                             &&            (vazio = senha ainda disponivel)

    *==========================================================================
    * Espelho do que esta DIGITADO nos tres campos do dialogo (FormParaBO)
    *
    * Sao DIFERENTES de this_cUsuarios / this_cCodigoMotivo, que o legado le
    * do CURSOR (TmpUsu / TmpMdsc) via CarregarDoCursor/CarregarMotivoDoCursor
    * - nao se pode reusar as mesmas properties: o legado consulta as DUAS
    * origens no MESMO statement e elas tem significados distintos. Em
    * senha.Valid, "Zsenha = Iif(Tipo = [X], Usuario.Value,
    * TmpUsu.Usuarios + Get_motivo.Value)": o ramo "X" devolve o DIGITADO e o
    * ramo Else devolve o do CURSOR. Achatar os dois num campo so faria o
    * ramo "X" devolver o autorizador em vez de quem foi digitado - sem erro
    * e sem aviso, trocando a credencial gravada no movimento.
    *
    * this_cSenhaDigitada x this_cSenhaDs: o legado tem os dois usos tambem -
    * SenhaDs eh a senha pre-cadastrada que vira CHAVE DE BUSCA em SigPrSnd
    * (fluxo "L"), enquanto no fluxo normal a senha digitada eh so COMPARADA
    * com fCriptografar(SigCdUsu.Senhas) e nunca consultada em tabela.
    *==========================================================================
    this_cUsuarioDigitado = ""   && usuario.Value    - codigo digitado no campo
    this_cMotivoDigitado  = ""   && get_Motivo.Value - codigo digitado no campo
    this_cSenhaDigitada   = ""   && senha.Value      - senha digitada no campo

    *==========================================================================
    * Aliases dos cursores que este BO popula/consome
    * (mantidos como property para o Form nao repetir literais)
    *==========================================================================
    this_cCursorUsuarios   = "cursor_4c_Usuarios"     && TmpUsu     - usuarios com alcada
    this_cCursorMotivos    = "cursor_4c_Motivos"      && TmpMdsc    - motivos ja filtrados
    this_cCursorMotivosBase = "cursor_4c_MotivosBase" && LocalMdsc  - motivos antes da classificacao
    this_cCursorSenhaLivre = "cursor_4c_SenhaLivre"   && TmpPrSnd   - senha livre consultada
    this_cCursorClaMotivo  = "cursor_4c_ClaMotivo"    && TmpClaMt   - motivos da classificacao

    *==========================================================================
    * Init - Configura tabela/chave e resolve os defaults do legado
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            *-- Tabela principal consultada: cadastro de usuarios autorizadores
            THIS.this_cTabela     = "SigCdUsu"
            THIS.this_cCampoChave = "usuarios"

            *-- Empresa default = empresa logada.
            *-- Legado: ThisForm.pEmps = Iif(Type('pcempresa') = [C], pcempresa, _Empr)
            *-- _EMPR eh legado e nao se usa: a fonte eh go_4c_Sistema.cCodEmpresa.
            IF EMPTY(THIS.this_cEmps)
                IF VARTYPE(go_4c_Sistema) = "O"
                    THIS.this_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                ENDIF
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar SigOpLimBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega o usuario autorizador selecionado a partir
    * de uma linha de cursor_4c_Usuarios (equivalente a "Select TmpUsu" do
    * legado, lido direto por THIS.this_cUsuarios/Senhas/CCargs/LimDescs).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cUsuarios = TratarNulo(usuarios, "")
            THIS.this_cSenhas   = TratarNulo(senhas, "")
            THIS.this_cCCargs   = TratarNulo(ccargs, "")
            THIS.this_cLimDescs = TratarNulo(limdescs, "")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarUsuariosAutorizados - Legado: SIGOPLIM.usuario.Valid, Do Case
    * por this_cTipo. Popula this_cCursorUsuarios (TmpUsu do legado) com os
    * usuarios cujo cargo (SigCdCrg) tem alcada para o valor/percentual
    * pedidos. "X" confere Limites = "S" (ignora valor/percentual); os
    * demais ("D" Desconto e "C" Acrescimo, os dois pelo Other do Do Case)
    * conferem o
    * limite e o percentual do cargo.
    *==========================================================================
    PROCEDURE BuscarUsuariosAutorizados()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF USED(THIS.this_cCursorUsuarios)
                USE IN (THIS.this_cCursorUsuarios)
            ENDIF

            DO CASE
                CASE THIS.this_cTipo = "D"
                    loc_cSQL = "SELECT a.* FROM SigCdUsu a, SigCdCrg b " + ;
                        "WHERE NOT a.cativos = 'N' " + ;
                        "AND (b.limdescs = 0 OR b.limdescs >= " + FormatarNumeroSQL(THIS.this_nValDesc, 2) + ") " + ;
                        "AND (b.descpors = 0 OR b.descpors >= " + FormatarNumeroSQL(THIS.this_nPDescs, 2) + ") " + ;
                        "AND (b.limdescs <> 0 OR b.descpors <> 0) " + ;
                        "AND a.ccargs = b.ccargs " + ;
                        "AND b.nivels = 'S' " + ;
                        "AND a.senhas <> '  '"

                CASE THIS.this_cTipo = "X"
                    loc_cSQL = "SELECT a.* FROM SigCdUsu a, SigCdCrg b " + ;
                        "WHERE NOT a.cativos = 'N' " + ;
                        "AND a.ccargs = b.ccargs " + ;
                        "AND b.limites = 'S' " + ;
                        "AND a.senhas <> '  '"

                OTHERWISE
                    *-- "A" (Acrescimo) - ramo Other do Do Case legado
                    loc_cSQL = "SELECT a.* FROM SigCdUsu a, SigCdCrg b " + ;
                        "WHERE NOT a.cativos = 'N' " + ;
                        "AND (b.limacres = 0 OR b.limacres >= " + FormatarNumeroSQL(THIS.this_nValDesc, 2) + ") " + ;
                        "AND (b.acrepors = 0 OR b.acrepors >= " + FormatarNumeroSQL(THIS.this_nPDescs, 2) + ") " + ;
                        "AND (b.limacres <> 0 OR b.acrepors <> 0) " + ;
                        "AND a.ccargs = b.ccargs " + ;
                        "AND b.nivels = 'S' " + ;
                        "AND a.senhas <> '  '"
            ENDCASE

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorUsuarios)

            IF loc_nResultado < 1 OR !USED(THIS.this_cCursorUsuarios)
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE
                SELECT (THIS.this_cCursorUsuarios)
                INDEX ON usuarios TAG usuarios
                GO TOP
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BuscarMotivos - Legado: SIGOPLIM.get_Motivo.Valid. Monta a base
    * (SigCdFs Left Join SigCdFsI, filtrada por Tipos/ChkBins/BlqTabDs) em
    * this_cCursorMotivosBase (LocalMdsc do legado, ja filtrada por Emps) e
    * copia para this_cCursorMotivos (TmpMdsc do legado), que eh o cursor
    * final - restringido por FiltrarMotivosPorClassificacao() quando
    * this_cClaConta estiver preenchido.
    *==========================================================================
    PROCEDURE BuscarMotivos()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cCursorJoin
        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""
        loc_cCursorJoin = "cursor_4c_MotivosJoin"

        TRY
            IF USED(loc_cCursorJoin)
                USE IN (loc_cCursorJoin)
            ENDIF
            IF USED(THIS.this_cCursorMotivosBase)
                USE IN (THIS.this_cCursorMotivosBase)
            ENDIF
            IF USED(THIS.this_cCursorMotivos)
                USE IN (THIS.this_cCursorMotivos)
            ENDIF

            loc_cSQL = "SELECT a.*, b.emps FROM SigCdFs a LEFT JOIN SigCdFsI b ON a.codigos = b.codigos " + ;
                "WHERE a.tipos = " + EscaparSQL(THIS.this_cTipo) + " " + ;
                IIF(THIS.this_lCheckBin, "AND a.chkbins <> 1 ", "") + ;
                IIF(THIS.this_lCheckTbd, "AND a.blqtabds <> 1 ", "") + ;
                "ORDER BY a.codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorJoin)

            IF loc_nResultado < 1 OR !USED(loc_cCursorJoin)
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE
                *-- Legado: Select Distinct Codigos, Descrs From LocalMdsc1
                *--         Where Nvl(Emps, pEmps) = pEmps Into Cursor LocalMdsc
                SELECT DISTINCT codigos, descrs FROM (loc_cCursorJoin) ;
                    WHERE NVL(emps, THIS.this_cEmps) = THIS.this_cEmps ;
                    INTO CURSOR (THIS.this_cCursorMotivosBase) READWRITE

                USE IN (loc_cCursorJoin)

                *-- Legado: Select * From LocalMdsc Into Cursor TmpMdsc ReadWrite
                SELECT * FROM (THIS.this_cCursorMotivosBase) ;
                    INTO CURSOR (THIS.this_cCursorMotivos) READWRITE

                IF !EMPTY(ALLTRIM(NVL(THIS.this_cClaConta, "")))
                    THIS.FiltrarMotivosPorClassificacao()
                ENDIF

                SELECT (THIS.this_cCursorMotivos)
                INDEX ON codigos TAG codigos
                GO TOP
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FiltrarMotivosPorClassificacao - Legado: bloco "If Not Empty(ThisForm.
    * ClaConta)" dentro de get_Motivo.Valid. SigCdCmt.Tipos=1 RESTRINGE
    * this_cCursorMotivos aos codigos daquela classificacao; Tipos=2
    * EXCLUI os codigos daquela classificacao. So chamado por BuscarMotivos.
    *==========================================================================
    PROTECTED PROCEDURE FiltrarMotivosPorClassificacao()
        LOCAL loc_cSQL, loc_nResultado

        TRY
            IF USED(THIS.this_cCursorClaMotivo)
                USE IN (THIS.this_cCursorClaMotivo)
            ENDIF

            loc_cSQL = "SELECT b.* FROM SigCdClc a, SigCdCmt b " + ;
                "WHERE a.codigos = " + EscaparSQL(ALLTRIM(THIS.this_cClaConta)) + " " + ;
                "AND a.cidchaves = b.fkchaves"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorClaMotivo)

            IF loc_nResultado >= 1 AND USED(THIS.this_cCursorClaMotivo)
                SELECT (THIS.this_cCursorClaMotivo)
                LOCATE FOR tipos = 1

                IF FOUND()
                    *-- Legado: Select a.* From LocalMdsc a, TmpClaMt b
                    *--         Where a.Codigos = b.codigos And b.Tipos = 1
                    *--         Into Cursor TmpMdsc ReadWrite
                    SELECT a.* FROM (THIS.this_cCursorMotivosBase) a, (THIS.this_cCursorClaMotivo) b ;
                        WHERE a.codigos = b.codigos AND b.tipos = 1 ;
                        INTO CURSOR (THIS.this_cCursorMotivos) READWRITE
                ELSE
                    SELECT (THIS.this_cCursorClaMotivo)
                    LOCATE FOR tipos = 2

                    IF FOUND()
                        *-- Legado: Select * From LocalMdsc Where Codigos Not in
                        *--         (Select Codigos From TmpClaMt Where Tipos = 2)
                        *--         Into Cursor TmpMdsc ReadWrite
                        SELECT * FROM (THIS.this_cCursorMotivosBase) ;
                            WHERE codigos NOT IN ;
                                (SELECT codigos FROM (THIS.this_cCursorClaMotivo) WHERE tipos = 2) ;
                            INTO CURSOR (THIS.this_cCursorMotivos) READWRITE
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarMotivoDoCursor - Carrega o motivo selecionado a partir de uma
    * linha de cursor_4c_Motivos (equivalente a ler TmpMdsc.Codigos/Descrs
    * apos o Seek do legado).
    *==========================================================================
    PROCEDURE CarregarMotivoDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigoMotivo = TratarNulo(codigos, "")
            THIS.this_cDescrsMotivo = TratarNulo(descrs, "")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GeraSenha - Transcricao literal de ThisForm.GeraSenha (SIGOPLIM.SCX).
    *
    * ATENCAO - metodo preservado so por fidelidade (PILAR 3), o resultado
    * NAO eh consultado em lugar nenhum do fluxo legado: pridig/segdig nunca
    * sao atribuidos (ficam 0) porque o legado esperava que fValidarCNPJ()
    * os preenchesse por efeito colateral (variavel nao-local visivel na
    * pilha de chamada); o wrapper novo (utils\fvalidarcnpj.prg) delega a
    * ValidarCNPJ() e devolve so um logico, sem esse efeito. zsen/zsen1,
    * calculados em usuario.Valid a partir deste metodo, tambem nunca sao
    * lidos depois. Quem chamar este metodo NAO deve basear autorizacao
    * nenhuma no retorno.
    *==========================================================================
    PROCEDURE GeraSenha(par_dData)
        LOCAL loc_nPriDig, loc_nSegDig, loc_cVar, loc_cVar1, loc_cSenha

        loc_nPriDig = 0
        loc_nSegDig = 0
        loc_cVar  = SUBSTR(DTOC(par_dData), 1, 2) + SUBSTR(DTOC(par_dData), 4, 2) + SUBSTR(DTOC(par_dData), 7, 2)
        loc_cVar  = loc_cVar + loc_cVar
        loc_cVar1 = TRANSFORM(loc_cVar + "00", "@R 99999999/9999-99")
        = fValidarCNPJ(loc_cVar1)
        loc_cSenha  = STR(loc_nPriDig, 1) + STR(loc_nSegDig, 1)
        loc_nPriDig = 0
        loc_nSegDig = 0
        loc_cVar1 = PADL(ALLTRIM(STR(VAL(loc_cVar) + VAL(loc_cSenha), 12)), 12, "0")
        loc_cVar1 = TRANSFORM(loc_cVar1 + "00", "@R 99999999/9999-99")
        loc_cSenha  = loc_cSenha + STR(loc_nPriDig, 1) + STR(loc_nSegDig, 1)

        RETURN loc_cSenha
    ENDPROC

    *==========================================================================
    * ValidarSenhaUsuario - Legado: SIGOPLIM.senha.Valid (ramo Else, Tipo
    * <> 'L'). Confere a senha digitada contra SigCdUsu.Senhas (ja carregada
    * em this_cSenhas por CarregarDoCursor) via fCriptografar.
    *
    * fCriptografar() NUNCA foi portada (funcao global legado Fortyus,
    * sig.prg/SIGFUNCS.PRG - nao vieram no acervo, e o algoritmo do hash nao
    * esta legivel em fonte nenhum). Transcrever a chamada literalmente e
    * deixar estourar dentro do TRY: o CATCH devolve a mensagem ao Form via
    * this_cMensagemErro em vez de fechar a tela (regra #27 do CLAUDE.md -
    * "DEIXAR AUSENTE", nunca inventar stub que devolva valor de calculo).
    *==========================================================================
    PROCEDURE ValidarSenhaUsuario(par_cSenhaDigitada)
        LOCAL loc_lResultado, loc_cSenhaPad, loc_cSenhaCripto
        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cSenhaPad    = PADR(ALLTRIM(NVL(par_cSenhaDigitada, "")), 10)
            loc_cSenhaCripto = fCriptografar(THIS.this_cSenhas)

            IF loc_cSenhaPad == PADR(loc_cSenhaCripto, 10)
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Senha Conflitante."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarEConsumirSenhaLivre - Legado: SIGOPLIM.senha.Valid (ramo Tipo
    * = 'L'). Confere a senha pre-cadastrada em SigPrSnd e, se ainda nao
    * consumida, marca EmpDopNums com a chave do movimento que a consumiu.
    *
    * par_cEmpDopNumsMovimento: chave POSICIONAL (Emps char(3) + Dopes
    * char(20) + Str(Numes,6) = 29, igual EmpDopNums) - o Form monta com
    * PADR em cada parte (NUNCA ALLTRIM nas partes, regra da chave
    * posicional) a partir do cursor global TprMvCab do form chamador, que
    * este BO nao possui.
    *==========================================================================
    PROCEDURE ValidarEConsumirSenhaLivre(par_cSenhaDigitada, par_cEmpDopNumsMovimento)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cEmpDopNums
        loc_lResultado = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF USED(THIS.this_cCursorSenhaLivre)
                USE IN (THIS.this_cCursorSenhaLivre)
            ENDIF

            THIS.this_cSenhaDs = ALLTRIM(NVL(par_cSenhaDigitada, ""))

            loc_cSQL = "SELECT empdopnums, cidchaves FROM SigPrSnd WHERE senhads = " + ;
                EscaparSQL(THIS.this_cSenhaDs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorSenhaLivre)

            IF loc_nResultado < 1 OR !USED(THIS.this_cCursorSenhaLivre) OR RECCOUNT(THIS.this_cCursorSenhaLivre) = 0
                THIS.this_cMensagemErro = "Senha inv" + CHR(225) + "lida."
            ELSE
                SELECT (THIS.this_cCursorSenhaLivre)
                GO TOP

                IF !EMPTY(empdopnums)
                    THIS.this_cMensagemErro = "Senha j" + CHR(225) + " utilizada."
                ELSE
                    THIS.this_cCidChaves = ALLTRIM(cidchaves)
                    loc_cEmpDopNums = PADR(NVL(par_cEmpDopNumsMovimento, ""), 29)

                    loc_cSQL = "UPDATE SigPrSnd SET empdopnums = " + EscaparSQL(loc_cEmpDopNums) + ;
                        " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                    SQLEXEC(gnConnHandle, loc_cSQL)

                    THIS.this_cEmpDopNums = loc_cEmpDopNums
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ComporAutorizacaoSoMotivo - Legado: get_Motivo.Valid, "If ThisForm.
    * somotivo / ThisForm.Zsenha = Space(10) + This.Value". Usado quando a
    * tela so pede o motivo (totite+valor+pvalor=0 e Tipo<>'X').
    *==========================================================================
    PROCEDURE ComporAutorizacaoSoMotivo(par_cCodigoMotivo)
        THIS.this_cZSenha = SPACE(10) + NVL(par_cCodigoMotivo, "")
        THIS.this_lAutorizado = .T.
        THIS.RegistrarAuditoria("AUTORIZACAO")
    ENDPROC

    *==========================================================================
    * ComporAutorizacaoSenhaLivre - Legado: senha.Valid, Tipo = 'L',
    * "ThisForm.Zsenha = Usuar" apos ValidarEConsumirSenhaLivre() ter
    * sucesso. Usuar (legado) = gc_4c_UsuarioLogado (CLAUDE.md: _EMPR/Usuar
    * sao legado, nunca usar direto).
    *==========================================================================
    PROCEDURE ComporAutorizacaoSenhaLivre()
        THIS.this_cZSenha = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
        THIS.this_lAutorizado = .T.
        THIS.RegistrarAuditoria("AUTORIZACAO")
    ENDPROC

    *==========================================================================
    * ComporAutorizacaoUsuarioSenha - Legado: senha.Valid, ramo Else, apos
    * ValidarSenhaUsuario() ter sucesso. Tipo = "X" devolve o usuario
    * DIGITADO (par_cUsuarioDigitado); os demais devolvem o usuario
    * AUTORIZADOR (this_cUsuarios, carregado por CarregarDoCursor) + o
    * codigo do motivo.
    *==========================================================================
    PROCEDURE ComporAutorizacaoUsuarioSenha(par_cUsuarioDigitado, par_cCodigoMotivo)
        IF THIS.this_cTipo = "X"
            THIS.this_cZSenha = ALLTRIM(NVL(par_cUsuarioDigitado, ""))
        ELSE
            THIS.this_cZSenha = THIS.this_cUsuarios + NVL(par_cCodigoMotivo, "")
        ENDIF
        THIS.this_lAutorizado = .T.
        THIS.RegistrarAuditoria("AUTORIZACAO")
    ENDPROC

    *==========================================================================
    * LimparDados - zera SO o estado de uma rodada de autorizacao, PRESERVANDO
    * os parametros de abertura (this_nTotIte/this_nValDesc/this_nPDescs/
    * this_cTipo/this_lMotivo/this_cClaConta/this_lCheckBin/this_lCheckTbd/
    * this_cEmps/this_lSoMotivo).
    *
    * A separacao eh o ponto deste metodo, nao detalhe: os parametros de
    * abertura descrevem O QUE foi pedido (chegam pelo Init do Form e nao
    * mudam durante a vida do dialogo), enquanto o estado abaixo descreve QUEM
    * autorizou. Zerar os parametros aqui faria a rodada seguinte consultar
    * alcada para valor 0 com Tipo "D" - ou seja, QUALQUER usuario passaria a
    * ter alcada, em silencio.
    *
    * PUBLIC (eh PUBLIC na BusinessBase, regra #51): o Form chama no funil de
    * reentrada (LimparCampos). Sem este reset, reabrir o MESMO objeto de
    * dialogo deixaria this_cUsuarios/this_cSenhas carregados do autorizador
    * ANTERIOR - e como ValidarSenhaUsuario confere a senha digitada contra
    * this_cSenhas, a segunda rodada autorizaria com a senha de quem liberou
    * a primeira, sem que o novo usuario fosse sequer escolhido.
    *==========================================================================
    PROCEDURE LimparDados()
        *-- Resultado da autorizacao
        THIS.this_lAutorizado = .F.
        THIS.this_cZSenha     = ""

        *-- Usuario autorizador (TmpUsu do legado)
        THIS.this_cUsuarios = ""
        THIS.this_cSenhas   = ""
        THIS.this_cCCargs   = ""
        THIS.this_cLimDescs = ""

        *-- Motivo selecionado (TmpMdsc do legado)
        THIS.this_cCodigoMotivo = ""
        THIS.this_cDescrsMotivo = ""

        *-- Senha livre (TmpPrSnd do legado)
        THIS.this_cSenhaDs    = ""
        THIS.this_cCidChaves  = ""
        THIS.this_cEmpDopNums = ""

        *-- Espelho dos campos digitados
        THIS.this_cUsuarioDigitado = ""
        THIS.this_cMotivoDigitado  = ""
        THIS.this_cSenhaDigitada   = ""

        *-- BusinessBase.LimparDados limpa this_cMensagemErro
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Usuario autorizador (ou o usuario logado, no
    * fluxo de senha livre, que nao passa por CarregarDoCursor). Usado so
    * por RegistrarAuditoria - nunca chamado de fora do BO (regra #51).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(NVL(THIS.this_cUsuarios, ""))

        IF EMPTY(loc_cChave) AND TYPE("gc_4c_UsuarioLogado") = "C"
            loc_cChave = ALLTRIM(gc_4c_UsuarioLogado)
        ENDIF

        RETURN loc_cChave
    ENDPROC

ENDDEFINE

