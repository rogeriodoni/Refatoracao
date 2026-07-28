# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCNT, ICLIS, GRUPOS, CODIGOS

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
  ControlSource = "crSigCdGcr.complems"
  ControlSource = "crSigCdGcr.pessoais"
  ControlSource = "crSigCdGcr.refbancs"
  ControlSource = "crSigCdGcr.followups"
  ControlSource = "crSigCdGcr.fiscais"
  ControlSource = "crSigCdGcr.contabs"
  ControlSource = "crSigCdGcr.empresas"
  ControlSource = "crSigCdGcr.commoedas"
  ControlSource = "crSigCdGcr.molimcre"
  ControlSource = "crSigCdGcr.Caracteris"
  ControlSource = "crSigCdGcr.InfCads"
  ControlSource = "crSigCdGcr.FichaTecs"
  ControlSource = "crSigCdGcr.respos"
  ControlSource = "crSigCdGcr.limcres"
  ControlSource = "crSigCdGcr.comis"
  ControlSource = "crSigCdGcr.coletors"
  ControlSource = "crSigCdGcr.cargos"
  ControlSource = "crSigCdGcr.chklimcrds"
  ControlSource = "crSigCdGcr.grupolms"
  ControlSource = "crSigCdGcr.dadcoms"
  ControlSource = "crSigCdGcr.RodRelCC"
  ControlSource = "crSigCdGcr.vrlimcre"
  ControlSource = "crSigCdGcr.LeadCad"
  ControlSource = "crSigCdGcr.cpfobrigs"
  ControlSource = "crSigCdGcr.cepobris"
  ControlSource = "crSigCdGcr.mfotos"
  ControlSource = "crSigCdGcr.Observas"
  ControlSource = "crSigCdGcr.rgobrigs"
  ControlSource = "crSigCdGcr.intconts"
  ControlSource = "crSigCdGcr.PadPgRecs"
  ControlSource = "crSigCdGcr.chkendds"
  ControlSource = "crSigCdGcr.chkendrs"
  ControlSource = "crSigCdGcr.CalcIMeds"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigCdGcr.RazObr"
  ControlSource = "crSigCdGcr.EndObr"
  ControlSource = "crSigCdGcr.PaisesObr"
  ControlSource = "crSigCdGcr.alertacad"
  ControlSource = ""
  ControlSource = "crSigCdGcr.SexObr"
  ControlSource = "crSigCdGcr.CidasObr"
  ControlSource = "crSigCdGcr.NascObr"
  ControlSource = "crSigCdGcr.BairroObr"
  ControlSource = "crSigCdGcr.NumObr"
  ControlSource = "crSigCdGcr.TitBaixado"
  ControlSource = "crSigCdGcr.Tel1Obr"
  ControlSource = "crSigCdGcr.Tel2Obr"
  ControlSource = "crSigCdGcr.contconts"
  ControlSource = "crSigCdGcr.MsgAlertaC"
  ControlSource = "crSigCdGcr.ChkDigDup"
  ControlSource = "crSigCdGcr.tipoinvs"
  ControlSource = "crSigCdGcr.trfpesas"
  ControlSource = "crSigCdGcr.compagrus"
  ControlSource = "crSigCdGcr.Pqs"
  ControlSource = "crSigCdGcr.agrupas"
  ControlSource = "crSigCdGcr.ctrlotes"
  ControlSource = "crSigCdGcr.ddretros"
  ControlSource = "crSigCdGcr.ddfutus"
  ControlSource = "crSigCdGcr.calcsalds"
  ControlSource = "crSigCdGcr.limestoqs"
  ControlSource = "crSigCdGcr.verests"
  ControlSource = "crSigCdGcr.estoques"
  ControlSource = "crSigCdGcr.ccustos"
  ControlSource = "crSigCdGcr.emprelevs"
  ControlSource = "crSigCdGcr.blqcongvs"
  ControlSource = "crSigCdGcr.ChkLimEsts"
  ControlSource = "crSigCdGcr.PatriEtqs"
  ControlSource = "crSigCdGcr.gerbals"
  ControlSource = "crSigCdGcr.unifbals"
  ControlSource = "crSigCdGcr.balfalpers"
  ControlSource = "crSigCdGcr.blqdivops"
  ControlSource = "crSigCdGcr.Chktits"
  ControlSource = "crSigCdGcr.OsPends"
  ControlSource = "crSigCdGcr.difpesags"
  ControlSource = "crSigCdGcr.Sinals"
  ControlSource = "crSigCdGcr.grufals"
  ControlSource = "crSigCdGcr.Invisivel"
  ControlSource = "crSigCdGcr.dgcods"
  ControlSource = "crSigCdGcr.codigos"
  ControlSource = "crSigCdGcr.descrs"
  ControlSource = "crSigCdGcr.internos"
  ControlSource = "crSigCdGcr.Classes"
  ControlSource = "crSigCdGcr.DClasses"
  ControlSource = "crSigCdGcr.tpcods"
  ControlSource = "crSigCdGcr.tpemps"
  ControlSource = "crSigCdGcr.tpcads"
			lcQuery = [Select RClis From SigCdCli Where IClis = '] + Padr(loObj.getCdContas.Value, 10) + [']
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)
Select CrSigCdGcr
	lcQuery = [select a.*, b.Descrs as DClasses from SigCdGcr a ]+;
			  [Left Join SigCdCss B on a.Classes = b.Classes ]+;
Select CrSigCdGcr
ThisForm.pagina.lista.grade.column4.ControlSource = [Nvl(CrSigCdGcr.DClasses,'')]
&&=Seek(CrSigCdGcr.Classes,'CrSigCdCss','Classes')
Select CrSigCdGcr
	ThisForm.poDataMgr.SQLExecute([Update SigCdCli Set TpCads = ?lnTipo Where Grupos = ?lcCodigo], [])
lcQuery = [Select Codigos, Descrs ] + ;
		    [From SigCdCst ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crListaRemota') < 1)
Select crListaRemota
	If Not Seek(This.Value, 'crListaRemota', 'Codigos')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formccr.prg) - TRECHOS RELEVANTES PARA PASS SQL (6822 linhas total):

*-- Linhas 352 a 370:
352:             .HighlightBackColor = RGB(255, 255, 255)
353:             .HighlightForeColor = RGB(15, 41, 104)
354:             .HighlightStyle     = 2
355:             .DeleteMark         = .F.
356:             .RecordMark         = .F.
357:             .RowHeight          = 16
358:             .ScrollBars         = 2
359:             .GridLines          = 3
360:             .ReadOnly           = .T.
361:             .Visible            = .T.
362:         ENDWITH
363: 
364:         THIS.TornarControlesVisiveis(loc_oPg1)
365:     ENDPROC
366: 
367:     *--------------------------------------------------------------------------
368:     * ConfigurarPaginaDados - Cria containers da Page2 (Dados)
369:     *--------------------------------------------------------------------------
370:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 5256 a 5274:
5256:                     USE IN cursor_4c_Dados
5257:                 ENDIF
5258:                 SET NULL ON
5259:                 CREATE CURSOR cursor_4c_Dados (codigos C(10), descrs C(40))
5260:                 SET NULL OFF
5261:                 loc_lResultado = .T.
5262:             ELSE
5263:                 IF THIS.this_oBusinessObject.Buscar("")
5264:                     THIS.AtualizarGrid()
5265:                     loc_lResultado = .T.
5266:                 ENDIF
5267:             ENDIF
5268:         CATCH TO loc_oErro
5269:             MsgErro(loc_oErro.Message, "Formccr.CarregarLista")
5270:             loc_lResultado = .F.
5271:         ENDTRY
5272: 
5273:         RETURN loc_lResultado
5274:     ENDPROC

*-- Linhas 5284 a 5303:
5284:         loc_oGrid.RecordSource = "cursor_4c_Dados"
5285:         loc_oGrid.ColumnCount  = 2
5286: 
5287:         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
5288:         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
5289: 
5290:         loc_oGrid.Column1.Width = 120
5291:         loc_oGrid.Column2.Width = 400
5292: 
5293:         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
5294:         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
5295:     ENDPROC
5296: 
5297:     *--------------------------------------------------------------------------
5298:     * AlternarPagina - Navega entre Page1 (Lista=1) e Page2 (Dados=2)
5299:     *--------------------------------------------------------------------------
5300:     PROCEDURE AlternarPagina(par_nPagina)
5301:         LOCAL loc_lResultado
5302:         loc_lResultado = .F.
5303: 

*-- Linhas 5611 a 5632:
5611: 
5612:             *-- Descreve moeda comissao
5613:             IF !EMPTY(ALLTRIM(loc_oBO.this_cCommoedas))
5614:                 IF SQLEXEC(gnConnHandle, "SELECT Dmoes FROM SigCdMoe WHERE RTRIM(Cmoes)=" + ;
5615:                     EscaparSQL(ALLTRIM(loc_oBO.this_cCommoedas)), "cursor_4c_Moe") >= 0
5616:                     IF USED("cursor_4c_Moe") AND RECCOUNT("cursor_4c_Moe") > 0
5617:                         SELECT cursor_4c_Moe
5618:                         loc_oPgAba.txt_4c__ds_moeda.Value = ALLTRIM(NVL(Dmoes, ""))
5619:                     ENDIF
5620:                     IF USED("cursor_4c_Moe")
5621:                         USE IN cursor_4c_Moe
5622:                     ENDIF
5623:                 ENDIF
5624:             ELSE
5625:                 loc_oPgAba.txt_4c__ds_moeda.Value = ""
5626:             ENDIF
5627: 
5628:             *-- Aba Cadastro - CfgCdGcr (posicoes)
5629:             loc_oPgAba = loc_oPg2.pgf_4c_1.Page2
5630:             loc_cCfg = PADR(loc_oBO.this_cCfgcdgcr, 40)
5631:             *-- Pos 1: ObrMails
5632:             loc_nVal = INT(VAL(SUBSTR(loc_cCfg, 1, 1)))

*-- Linhas 5762 a 5783:
5762:                     loc_oCnt.getReceitas.Value = ALLTRIM(SUBSTR(loc_cFisStr, 26, 10))
5763:                     *-- Buscar descricao da conta
5764:                     IF !EMPTY(loc_cConta)
5765:                         IF SQLEXEC(gnConnHandle, "SELECT RClis FROM SigCdCli WHERE RTRIM(IClis)=" + ;
5766:                             EscaparSQL(PADR(loc_cConta, 10)), "cursor_4c_DsCnt") >= 0
5767:                             IF USED("cursor_4c_DsCnt") AND RECCOUNT("cursor_4c_DsCnt") > 0
5768:                                 SELECT cursor_4c_DsCnt
5769:                                 loc_oCnt.getDsContas.Value = ALLTRIM(NVL(RClis, ""))
5770:                             ENDIF
5771:                             IF USED("cursor_4c_DsCnt")
5772:                                 USE IN cursor_4c_DsCnt
5773:                             ENDIF
5774:                         ENDIF
5775:                     ELSE
5776:                         loc_oCnt.getDsContas.Value = ""
5777:                     ENDIF
5778:                 ENDIF
5779:             ENDFOR
5780:         CATCH TO loc_oErro
5781:             MsgErro(loc_oErro.Message, "BOParaForm")
5782:         ENDTRY
5783:     ENDPROC

*-- Linhas 6028 a 6046:
6028:         loc_cCodigos = ""
6029: 
6030:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
6031:             SELECT cursor_4c_Dados
6032:             loc_cCodigos = ALLTRIM(NVL(cursor_4c_Dados.codigos, ""))
6033:         ENDIF
6034: 
6035:         IF EMPTY(loc_cCodigos)
6036:             MsgAviso("Selecione um registro na lista.", "Visualizar")
6037:             RETURN
6038:         ENDIF
6039: 
6040:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
6041:             THIS.this_cModoAtual = "VISUALIZAR"
6042:             THIS.BOParaForm()
6043:             THIS.HabilitarCampos(.F.)
6044:             THIS.AjustarBotoesPorModo()
6045:             THIS.AlternarPagina(2)
6046:         ENDIF

*-- Linhas 6054 a 6072:
6054:         loc_cCodigos = ""
6055: 
6056:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
6057:             SELECT cursor_4c_Dados
6058:             loc_cCodigos = ALLTRIM(NVL(cursor_4c_Dados.codigos, ""))
6059:         ENDIF
6060: 
6061:         IF EMPTY(loc_cCodigos)
6062:             MsgAviso("Selecione um registro na lista.", "Alterar")
6063:             RETURN
6064:         ENDIF
6065: 
6066:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
6067:             THIS.this_oBusinessObject.EditarRegistro()
6068:             THIS.this_cModoAtual = "ALTERAR"
6069:             THIS.BOParaForm()
6070:             THIS.HabilitarCampos(.T.)
6071:             THIS.AjustarBotoesPorModo()
6072:             THIS.AlternarPagina(2)

*-- Linhas 6082 a 6100:
6082:         loc_lConfirma = .F.
6083: 
6084:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
6085:             SELECT cursor_4c_Dados
6086:             loc_cCodigos = ALLTRIM(NVL(cursor_4c_Dados.codigos, ""))
6087:         ENDIF
6088: 
6089:         IF EMPTY(loc_cCodigos)
6090:             MsgAviso("Selecione um registro na lista.", "Excluir")
6091:             RETURN
6092:         ENDIF
6093: 
6094:         loc_lConfirma = MsgConfirma("Deseja excluir o grupo de contas correntes selecionado?", "Excluir")
6095:         IF !loc_lConfirma
6096:             RETURN
6097:         ENDIF
6098: 
6099:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigos)
6100:             IF THIS.this_oBusinessObject.Excluir()

*-- Linhas 6149 a 6170:
6149:         ENDIF
6150: 
6151:         TRY
6152:             IF SQLEXEC(gnConnHandle, "SELECT Descrs FROM SigCdCss WHERE RTRIM(Classes)=" + ;
6153:                 EscaparSQL(loc_cCls), "cursor_4c_Css") >= 0
6154:                 IF USED("cursor_4c_Css") AND RECCOUNT("cursor_4c_Css") > 0
6155:                     SELECT cursor_4c_Css
6156:                     loc_oPg2.txt_4c_DClasses.Value = ALLTRIM(NVL(Descrs, ""))
6157:                 ELSE
6158:                     THIS.AbrirBuscaClasses()
6159:                 ENDIF
6160:                 IF USED("cursor_4c_Css")
6161:                     USE IN cursor_4c_Css
6162:                 ENDIF
6163:             ENDIF
6164:         CATCH TO loc_oErro
6165:             MsgErro(loc_oErro.Message, "ClassesLostFocus")
6166:             IF USED("cursor_4c_Css")
6167:                 USE IN cursor_4c_Css
6168:             ENDIF
6169:         ENDTRY
6170:     ENDPROC

*-- Linhas 6191 a 6209:
6191:                 ENDIF
6192: 
6193:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClasse")
6194:                     SELECT cursor_4c_BuscaClasse
6195:                     loc_oPg2.txt_4c_Classes.Value  = ALLTRIM(NVL(Classes, ""))
6196:                     loc_oPg2.txt_4c_DClasses.Value = ALLTRIM(NVL(Descrs, ""))
6197:                 ELSE
6198:                     IF !loc_oBusca.this_lSelecionou
6199:                         loc_oPg2.txt_4c_Classes.Value  = ""
6200:                         loc_oPg2.txt_4c_DClasses.Value = ""
6201:                     ENDIF
6202:                 ENDIF
6203:                 loc_oBusca.Release()
6204:             ENDIF
6205: 
6206:             IF USED("cursor_4c_BuscaClasse")
6207:                 USE IN cursor_4c_BuscaClasse
6208:             ENDIF
6209:         CATCH TO loc_oErro

*-- Linhas 6244 a 6265:
6244:         ENDIF
6245: 
6246:         TRY
6247:             IF SQLEXEC(gnConnHandle, "SELECT Dmoes FROM SigCdMoe WHERE RTRIM(Cmoes)=" + ;
6248:                 EscaparSQL(loc_cMoe), "cursor_4c_MoeVal") >= 0
6249:                 IF USED("cursor_4c_MoeVal") AND RECCOUNT("cursor_4c_MoeVal") > 0
6250:                     SELECT cursor_4c_MoeVal
6251:                     loc_oPgAba.txt_4c__ds_moeda.Value = ALLTRIM(NVL(Dmoes, ""))
6252:                 ELSE
6253:                     THIS.AbrirBuscaMoedaComissao()
6254:                 ENDIF
6255:                 IF USED("cursor_4c_MoeVal")
6256:                     USE IN cursor_4c_MoeVal
6257:                 ENDIF
6258:             ENDIF
6259:         CATCH TO loc_oErro
6260:             MsgErro(loc_oErro.Message, "MoedaComissaoLostFocus")
6261:             IF USED("cursor_4c_MoeVal")
6262:                 USE IN cursor_4c_MoeVal
6263:             ENDIF
6264:         ENDTRY
6265:     ENDPROC

*-- Linhas 6286 a 6304:
6286:                 ENDIF
6287: 
6288:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeCom")
6289:                     SELECT cursor_4c_BuscaMoeCom
6290:                     loc_oPgAba.txt_4c__cd_moeda.Value = ALLTRIM(NVL(Cmoes, ""))
6291:                     loc_oPgAba.txt_4c__ds_moeda.Value = ALLTRIM(NVL(Dmoes, ""))
6292:                 ENDIF
6293:                 loc_oBusca.Release()
6294:             ENDIF
6295: 
6296:             IF USED("cursor_4c_BuscaMoeCom")
6297:                 USE IN cursor_4c_BuscaMoeCom
6298:             ENDIF
6299:         CATCH TO loc_oErro
6300:             MsgErro(loc_oErro.Message, "AbrirBuscaMoedaComissao")
6301:             IF USED("cursor_4c_BuscaMoeCom")
6302:                 USE IN cursor_4c_BuscaMoeCom
6303:             ENDIF
6304:         ENDTRY

*-- Linhas 6333 a 6352:
6333:         ENDIF
6334: 
6335:         TRY
6336:             IF SQLEXEC(gnConnHandle, "SELECT Dmoes FROM SigCdMoe WHERE RTRIM(Cmoes)=" + ;
6337:                 EscaparSQL(loc_cMoe), "cursor_4c_MoeL") >= 0
6338:                 IF !USED("cursor_4c_MoeL") OR RECCOUNT("cursor_4c_MoeL") = 0
6339:                     THIS.AbrirBuscaMoedaLimite()
6340:                 ENDIF
6341:                 IF USED("cursor_4c_MoeL")
6342:                     USE IN cursor_4c_MoeL
6343:                 ENDIF
6344:             ENDIF
6345:         CATCH TO loc_oErro
6346:             MsgErro(loc_oErro.Message, "MoedaLimiteLostFocus")
6347:             IF USED("cursor_4c_MoeL")
6348:                 USE IN cursor_4c_MoeL
6349:             ENDIF
6350:         ENDTRY
6351:     ENDPROC
6352: 

*-- Linhas 6372 a 6390:
6372:                 ENDIF
6373: 
6374:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeLim")
6375:                     SELECT cursor_4c_BuscaMoeLim
6376:                     loc_oPgAba.txt_4c__molimc.Value = ALLTRIM(NVL(Cmoes, ""))
6377:                 ENDIF
6378:                 loc_oBusca.Release()
6379:             ENDIF
6380: 
6381:             IF USED("cursor_4c_BuscaMoeLim")
6382:                 USE IN cursor_4c_BuscaMoeLim
6383:             ENDIF
6384:         CATCH TO loc_oErro
6385:             MsgErro(loc_oErro.Message, "AbrirBuscaMoedaLimite")
6386:             IF USED("cursor_4c_BuscaMoeLim")
6387:                 USE IN cursor_4c_BuscaMoeLim
6388:             ENDIF
6389:         ENDTRY
6390:     ENDPROC

*-- Linhas 6427 a 6445:
6427:                 ENDIF
6428: 
6429:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
6430:                     SELECT cursor_4c_BuscaGrp
6431:                     loc_oPgAba.txt_4c_Grupo.Value = ALLTRIM(NVL(codigos, ""))
6432:                 ENDIF
6433:                 loc_oBusca.Release()
6434:             ENDIF
6435: 
6436:             IF USED("cursor_4c_BuscaGrp")
6437:                 USE IN cursor_4c_BuscaGrp
6438:             ENDIF
6439:         CATCH TO loc_oErro
6440:             MsgErro(loc_oErro.Message, "AbrirBuscaGrupoContab")
6441:             IF USED("cursor_4c_BuscaGrp")
6442:                 USE IN cursor_4c_BuscaGrp
6443:             ENDIF
6444:         ENDTRY
6445:     ENDPROC

*-- Linhas 6473 a 6492:
6473:         ENDIF
6474: 
6475:         TRY
6476:             IF SQLEXEC(gnConnHandle, "SELECT codigos FROM SigCdCst WHERE RTRIM(codigos)=" + ;
6477:                 EscaparSQL(loc_cSit), "cursor_4c_SitVal") >= 0
6478:                 IF !USED("cursor_4c_SitVal") OR RECCOUNT("cursor_4c_SitVal") = 0
6479:                     THIS.AbrirBuscaSituacao()
6480:                 ENDIF
6481:                 IF USED("cursor_4c_SitVal")
6482:                     USE IN cursor_4c_SitVal
6483:                 ENDIF
6484:             ENDIF
6485:         CATCH TO loc_oErro
6486:             MsgErro(loc_oErro.Message, "SituacaoLostFocus")
6487:             IF USED("cursor_4c_SitVal")
6488:                 USE IN cursor_4c_SitVal
6489:             ENDIF
6490:         ENDTRY
6491:     ENDPROC
6492: 

*-- Linhas 6513 a 6531:
6513:                 ENDIF
6514: 
6515:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSit")
6516:                     SELECT cursor_4c_BuscaSit
6517:                     loc_oPgAba.getSituas.Value = ALLTRIM(NVL(codigos, ""))
6518:                 ENDIF
6519:                 loc_oBusca.Release()
6520:             ENDIF
6521: 
6522:             IF USED("cursor_4c_BuscaSit")
6523:                 USE IN cursor_4c_BuscaSit
6524:             ENDIF
6525:         CATCH TO loc_oErro
6526:             MsgErro(loc_oErro.Message, "AbrirBuscaSituacao")
6527:             IF USED("cursor_4c_BuscaSit")
6528:                 USE IN cursor_4c_BuscaSit
6529:             ENDIF
6530:         ENDTRY
6531:     ENDPROC

*-- Linhas 6568 a 6586:
6568:                 ENDIF
6569: 
6570:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpEst")
6571:                     SELECT cursor_4c_BuscaGrpEst
6572:                     loc_oPgAba.Get_grupo.Value = ALLTRIM(NVL(codigos, ""))
6573:                 ENDIF
6574:                 loc_oBusca.Release()
6575:             ENDIF
6576: 
6577:             IF USED("cursor_4c_BuscaGrpEst")
6578:                 USE IN cursor_4c_BuscaGrpEst
6579:             ENDIF
6580:         CATCH TO loc_oErro
6581:             MsgErro(loc_oErro.Message, "AbrirBuscaGrupoEstoque")
6582:             IF USED("cursor_4c_BuscaGrpEst")
6583:                 USE IN cursor_4c_BuscaGrpEst
6584:             ENDIF
6585:         ENDTRY
6586:     ENDPROC

*-- Linhas 6660 a 6678:
6660:                 ENDIF
6661: 
6662:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpFat")
6663:                     SELECT cursor_4c_BuscaGrpFat
6664:                     loc_oCnt.getCdGrupos.Value = ALLTRIM(NVL(codigos, ""))
6665:                     *-- Limpa conta ao trocar grupo
6666:                     loc_oCnt.getCdContas.Value = ""
6667:                     loc_oCnt.getDsContas.Value = ""
6668:                 ENDIF
6669:                 loc_oBusca.Release()
6670:             ENDIF
6671: 
6672:             IF USED("cursor_4c_BuscaGrpFat")
6673:                 USE IN cursor_4c_BuscaGrpFat
6674:             ENDIF
6675:         CATCH TO loc_oErro
6676:             MsgErro(loc_oErro.Message, "AbrirBuscaGrupoFat")
6677:             IF USED("cursor_4c_BuscaGrpFat")
6678:                 USE IN cursor_4c_BuscaGrpFat

*-- Linhas 6737 a 6771:
6737:         ENDIF
6738:         loc_oCnt   = THIS.ActiveControl.Parent
6739:         loc_cGrupo = ALLTRIM(NVL(loc_oCnt.getCdGrupos.Value, ""))
6740:         loc_cFiltro = IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
6741: 
6742:         TRY
6743:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
6744:                 "SigCdCli", "cursor_4c_BuscaCntFat", "iclis", ;
6745:                 ALLTRIM(NVL(loc_oCnt.getCdContas.Value, "")), ;
6746:                 "Selecionar Conta", .F., .F., loc_cFiltro)
6747: 
6748:             IF VARTYPE(loc_oBusca) = "O"
6749:                 IF !loc_oBusca.this_lAchouRegistro OR !loc_oBusca.this_lSelecionou
6750:                     loc_oBusca.mAddColuna("iclis",  "", "C" + CHR(243) + "digo")
6751:                     loc_oBusca.mAddColuna("rclis",  "", "Nome/Raz" + CHR(227) + "o Social")
6752:                     loc_oBusca.Show()
6753:                 ENDIF
6754: 
6755:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCntFat")
6756:                     SELECT cursor_4c_BuscaCntFat
6757:                     loc_oCnt.getCdContas.Value = ALLTRIM(NVL(iclis, ""))
6758:                     loc_oCnt.getDsContas.Value = ALLTRIM(NVL(rclis, ""))
6759:                 ENDIF
6760:                 loc_oBusca.Release()
6761:             ENDIF
6762: 
6763:             IF USED("cursor_4c_BuscaCntFat")
6764:                 USE IN cursor_4c_BuscaCntFat
6765:             ENDIF
6766:         CATCH TO loc_oErro
6767:             MsgErro(loc_oErro.Message, "AbrirBuscaContaFat")
6768:             IF USED("cursor_4c_BuscaCntFat")
6769:                 USE IN cursor_4c_BuscaCntFat
6770:             ENDIF
6771:         ENDTRY


### BO (C:\4c\projeto\app\classes\ccrBO.prg):
*==============================================================================
* ccrBO.prg - Business Object para Grupos de Contas Correntes (SigCdGcr)
* Herda de BusinessBase
* Tabela: SigCdGcr  |  PK: codigos
*==============================================================================

DEFINE CLASS ccrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * IDENTIFICACAO - PK e Descricao
    *--------------------------------------------------------------------------
    this_cCodigos         = ""   && codigos char(10) PK
    this_cDescrs          = ""   && descrs char(40)
    this_cDgcods          = ""   && dgcods char(1) - digito
    this_cInternos        = ""   && internos char(20) - codigo interno
    this_cClasses         = ""   && classes char(10) - FK SigCdCss
    this_cDClasses        = ""   && DClasses virtual (JOIN SigCdCss.Descrs)

    *--------------------------------------------------------------------------
    * TIPO/MODO
    *--------------------------------------------------------------------------
    this_nTpcods          = 0    && tpcods numeric(1,0) - tipo codificacao
    this_nTpemps          = 0    && tpemps numeric(1,0) - tipo empresa
    this_nTpcads          = 0    && tpcads numeric(1,0) - tipo cadastro

    *--------------------------------------------------------------------------
    * ABA GERAL - Opcoes de obrigatoriedade cadastral
    *--------------------------------------------------------------------------
    this_nComplems        = 0    && complems numeric(1,0) - Complemento
    this_nPessoais        = 0    && pessoais numeric(1,0) - Dados Pessoais
    this_nRefbancs        = 0    && refbancs numeric(1,0) - Ref. Bancarias
    this_nFollowups       = 0    && followups numeric(1,0) - Follow-Up
    this_nFiscais         = 0    && fiscais numeric(1,0) - Dados Fiscais
    this_nContabs         = 0    && contabs numeric(1,0) - Dados Contabeis
    this_nEmpresas        = 0    && empresas numeric(1,0) - Dados da Empresa
    this_nCaracteris      = 0    && caracteris numeric(1,0) - Caracteristicas
    this_nRespos          = 0    && respos numeric(1,0) - Possui Responsavel
    this_nLimcres         = 0    && limcres numeric(1,0) - Limite de Credito
    this_nComis           = 0    && comis numeric(1,0) - Comissao
    this_nDadcoms         = 0    && dadcoms numeric(1,0) - Dados Comerciais
    this_nCargos          = 0    && cargos numeric(1,0) - Cargos
    this_nChklimcrds      = 0    && chklimcrds numeric(1,0) - Checa Limite Credito
    this_nColetors        = 0    && coletors numeric(2,0) - Coletor (11 opcoes)
    this_nPrecad          = 0    && precad numeric(1,0) - Pre-Cadastro (LEAD)

    *--------------------------------------------------------------------------
    * ABA GERAL - Grupo padrao contabil / Limite de credito / Moeda
    *--------------------------------------------------------------------------
    this_cGrupolms        = ""   && grupolms char(10) - Grupo Padrao Contabil
    this_nVrlimcre        = 0    && vrlimcre numeric(11,2) - Valor Limite Credito
    this_cMolimcre        = ""   && molimcre char(3) - Moeda Limite Credito
    this_cCommoedas       = ""   && commoedas char(3) - Moeda Comissao
    this_cRodrelcc        = ""   && rodrelcc text - Rodape Relatorio Conta Corrente

    *--------------------------------------------------------------------------
    * ABA CADASTRO - Obrigatoriedades de preenchimento
    *--------------------------------------------------------------------------
    this_cCfgcdgcr        = ""   && cfgcdgcr char(40) - Config flags empacotados

    *-- Posicoes do CfgCdGcr (armazenados em cfgcdgcr):
    *-- Pos 1: ObrMails, Pos 2: ObrNome, Pos 3: VincPgRcs, Pos 4: ObrSit
    *-- Pos 5: Cpffixo, Pos 6: Carac, Pos 7: AceJob

    this_cDescsit         = ""   && descsit char(16) - Situacao Padrao
    this_nCpfobrigs       = 0    && cpfobrigs numeric(1,0) - CPF/CNPJ Obrigatorio
    this_nRgobrigs        = 0    && rgobrigs numeric(1,0) - RG/IE Obrigatorio
    this_nMfotos          = 0    && mfotos numeric(1,0) - Mostrar Foto
    this_nObservas        = 0    && observas numeric(1,0) - Observacao
    this_nInfcads         = 0    && infcads numeric(1,0) - Info Cadastrais
    this_nCalcimeds       = 0    && calcimeds numeric(1,0) - Calc. Imediato
    this_cDesccalcimeds   = ""   && desccalcimeds char(16) - Desc Calc Imediato
    this_nFpublsobr       = 0    && fpublsobr numeric(1,0) - Func.Publico Obrig.
    this_cDescfpubls      = ""   && descfpubls char(16) - Desc Func.Publico
    this_nInfsenha        = 0    && infsenha numeric(1,0) - Info Senha
    this_nLogalt          = 0    && logalt numeric(1,0) - Log Alteracao

    *-- Endereco
    this_nEndobr          = 0    && endobr numeric(1,0) - Endereco Obrigatorio
    this_nNumobr          = 0    && numobr numeric(1,0) - Numero Obrigatorio
    this_nBairroobr       = 0    && bairroobr numeric(1,0) - Bairro Obrigatorio
    this_nCidasobr        = 0    && cidasobr numeric(1,0) - Cidade Obrigatoria
    this_nCepobris        = 0    && cepobris numeric(1,0) - CEP Obrigatorio
    this_nPaisesobr       = 0    && paisesobr numeric(1,0) - Pais Obrigatorio
    this_nChkendds        = 0    && chkendds numeric(1,0) - Checa Duplic. Endereco
    this_nChkendrs        = 0    && chkendrs numeric(1,0) - Checa Restric. Endereco

    *-- Telefone e outros dados pessoais
    this_nTel1obr         = 0    && tel1obr numeric(1,0) - Telefone 1 Obrigatorio
    this_nTel2obr         = 0    && tel2obr numeric(1,0) - Telefone 2 Obrigatorio
    this_nNascobr         = 0    && nascobr numeric(1,0) - Nascimento Obrigatorio
    this_nSexobr          = 0    && sexobr numeric(1,0) - Sexo Obrigatorio
    this_nDtnascobr       = 0    && dtnascobr numeric(1,0) - Data Nasc. Obrigatoria
    this_nDtespobr        = 0    && dtespobr numeric(1,0) - Data Espera Obrigatoria
    this_nObrtelefone     = 0    && Obrtelefone numeric(1,0) - Telefone Obrigatorio
    this_cDesctlm         = ""   && desctlm char(16) - Desc Telemarketing
    this_cDesccla         = ""   && desccla char(16) - Desc Classificacao
    this_cDescseg         = ""   && descseg char(16) - Desc Segmento

    *-- Financeiro no Cadastro
    this_cContconts       = ""   && contconts char(9) - Conta Interna
    this_nIntconts        = 0    && intconts numeric(1,0) - Integracao Contabil
    this_nPadpgrecs       = 0    && padpgrecs numeric(1,0) - Padrao Preenchimento
    this_nCtvinculas      = 0    && ctvinculas numeric(1,0) - Vincula Contas PG/RC
    this_nTitbaixado      = 0    && titbaixado numeric(1,0) - Visualiza Tit.nao Baixados
    this_cContapdr        = ""   && contapdr char(10) - Conta Padrao
    this_nCcustotit       = 0    && ccustotit numeric(1,0) - C.Custo por Titulo

    *-- Alerta Cadastro
    this_nDefhideshow     = 0    && defhideshow numeric(1,0) - Emitir Mensagem Alerta
    this_nCtainatv        = 0    && ctainatv numeric(1,0) - Conta Inativa

    *--------------------------------------------------------------------------
    * ABA ESTOQUE
    *--------------------------------------------------------------------------
    this_nEstoques        = 0    && estoques numeric(1,0) - Avalia Estoque
    this_nLimestoqs       = 0    && limestoqs numeric(1,0) - Limite de Estoque
    this_nVerests         = 0    && verests numeric(1,0) - Verifica Estoque
    this_nEmprelevs       = 0    && emprelevs numeric(1,0) - Empresa Relevante
    this_nBlqcongvs       = 0    && blqcongvs numeric(1,0) - Bloqueia Consulta GV
    this_nCalcsalds       = 0    && calcsalds numeric(1,0) - Calculo de Saldo
    this_nChklimests      = 0    && chklimests numeric(1,0) - Checa Limite Estoque
    this_nPatrietqs       = 0    && patrietqs numeric(1,0) - Patrimonial por Etiqueta
    this_nCcustos         = 0    && ccustos numeric(1,0) - Centro de Custos
    this_nGerbals         = 0    && gerbals numeric(1,0) - Gerar Balanco
    this_nUnifbals        = 0    && unifbals numeric(1,0) - Balanco Unificado
    this_nBalfalpers      = 0    && balfalpers numeric(1,0) - Balanco Falhas/Perdas
    this_nBlqdivops       = 0    && blqdivops numeric(1,0) - Bloqueia Divisao OF
    this_nInvisivel       = 0    && invisivel numeric(1,0) - Grupo nao Selecionavel
    this_nDdfutus         = 0    && ddfutus numeric(5,0) - Dias Bloqueio Futuro
    this_nDdretros        = 0    && ddretros numeric(5,0) - Dias Bloqueio Retroativo
    this_nDdsems          = 0    && ddsems numeric(1,0) - Dias em Semanas
    this_nHordd           = 0    && hordd numeric(4,2) - Hora DD
    this_nTipoinvs        = 0    && tipoinvs numeric(1,0) - Tipo Inventario

    *-- Industria / Fabrica
    this_nTrfpesas        = 0    && trfpesas numeric(1,0) - Transfere Peso
    this_nDifpesags       = 0    && difpesags numeric(9,3) - Diferenca de Peso
    this_nSinals          = 0    && sinals numeric(1,0) - Sinal (+/-)
    this_cPqs             = ""   && pqs char(1) - P ou Q (tipo falha)
    this_nCompagrus       = 0    && compagrus numeric(1,0) - Agrupa Componentes
    this_cAgrupas         = ""   && agrupas char(10) - Agrupamento
    this_nFichatecs       = 0    && fichatecs numeric(1,0) - Ficha Tecnica
    this_cOsalfuns        = ""   && osalfuns char(3) - Os/Alianca/Fundicao flags
    this_cGrufals         = ""   && grufals char(10) - Grupo Falha/Diferenca Balanco
    this_nOspends         = 0    && ospends numeric(1,0) - OS Pendente Dt.Entrega
    this_nChktits         = 0    && chktits numeric(1,0) - Checa Duplicidade Titulo
    this_nTpprecos        = 0    && tpprecos numeric(1,0) - Tipo de Preco
    this_cContafalha      = ""   && contafalha char(10) - Conta Falha
    this_cGrupofalha      = ""   && grupofalha char(10) - Grupo Falha
    this_nCtrlotes        = 0    && ctrlotes numeric(1,0) - Controle de Lote

    *--------------------------------------------------------------------------
    * ABA FATURAMENTO - Configuracoes fiscais por imposto
    * Formato empacotado: grupo(10)+conta(10)+descricao(40)+aliq(9.4)+receita(8)
    *--------------------------------------------------------------------------
    this_cCfgfisics       = ""   && cfgfisics char(50) - ICMS
    this_cCfgfisips       = ""   && cfgfisips char(50) - IPI
    this_cCfgfisiis       = ""   && cfgfisiis char(50) - II
    this_cCfgfisiss       = ""   && cfgfisiss char(50) - ISS
    this_cCfgfisirs       = ""   && cfgfisirs char(50) - IRRF
    this_cCfgfisins       = ""   && cfgfisins char(50) - INSS
    this_cCfgfispis       = ""   && cfgfispis char(50) - PIS
    this_cCfgfiscss       = ""   && cfgfiscss char(50) - CSSL
    this_cCfgfiscos       = ""   && cfgfiscos char(50) - COFINS

    *==========================================================================
    * INIT
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "SigCdGcr"
        THIS.this_cCampoChave  = "codigos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *==========================================================================
    * Buscar - Carrega lista de grupos de contas correntes no cursor_4c_Dados
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT a.codigos, a.descrs, a.classes, ISNULL(b.Descrs,'') AS DClasses" + ;
                           " FROM SigCdGcr a" + ;
                           " LEFT JOIN SigCdCss b ON a.Classes = b.Classes" + ;
                           " ORDER BY a.codigos"
            ELSE
                loc_cSQL = "SELECT a.codigos, a.descrs, a.classes, ISNULL(b.Descrs,'') AS DClasses" + ;
                           " FROM SigCdGcr a" + ;
                           " LEFT JOIN SigCdCss b ON a.Classes = b.Classes" + ;
                           " WHERE RTRIM(a.codigos) LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                           " OR RTRIM(a.descrs) LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY a.codigos"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar grupos de contas correntes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.*, ISNULL(b.Descrs,'') AS DClasses" + ;
                       " FROM SigCdGcr a" + ;
                       " LEFT JOIN SigCdCss b ON a.Classes = b.Classes" + ;
                       " WHERE RTRIM(a.codigos) = " + EscaparSQL(ALLTRIM(par_cCodigos))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar grupo de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos         = TratarNulo(codigos, "C")
            THIS.this_cDescrs          = TratarNulo(descrs, "C")
            THIS.this_cDgcods          = TratarNulo(dgcods, "C")
            THIS.this_cInternos        = TratarNulo(internos, "C")
            THIS.this_cClasses         = TratarNulo(classes, "C")
            THIS.this_cDClasses        = TratarNulo(DClasses, "C")
            THIS.this_nTpcods          = TratarNulo(tpcods, "N")
            THIS.this_nTpemps          = TratarNulo(tpemps, "N")
            THIS.this_nTpcads          = TratarNulo(tpcads, "N")
            THIS.this_nComplems        = TratarNulo(complems, "N")
            THIS.this_nPessoais        = TratarNulo(pessoais, "N")
            THIS.this_nRefbancs        = TratarNulo(refbancs, "N")
            THIS.this_nFollowups       = TratarNulo(followups, "N")
            THIS.this_nFiscais         = TratarNulo(fiscais, "N")
            THIS.this_nContabs         = TratarNulo(contabs, "N")
            THIS.this_nEmpresas        = TratarNulo(empresas, "N")
            THIS.this_nCaracteris      = TratarNulo(caracteris, "N")
            THIS.this_nRespos          = TratarNulo(respos, "N")
            THIS.this_nLimcres         = TratarNulo(limcres, "N")
            THIS.this_nComis           = TratarNulo(comis, "N")
            THIS.this_nDadcoms         = TratarNulo(dadcoms, "N")
            THIS.this_nCargos          = TratarNulo(cargos, "N")
            THIS.this_nChklimcrds      = TratarNulo(chklimcrds, "N")
            THIS.this_nColetors        = TratarNulo(coletors, "N")
            THIS.this_nPrecad          = TratarNulo(precad, "N")
            THIS.this_cGrupolms        = TratarNulo(grupolms, "C")
            THIS.this_nVrlimcre        = TratarNulo(vrlimcre, "N")
            THIS.this_cMolimcre        = TratarNulo(molimcre, "C")
            THIS.this_cCommoedas       = TratarNulo(commoedas, "C")
            THIS.this_cRodrelcc        = TratarNulo(rodrelcc, "C")
            THIS.this_cCfgcdgcr        = TratarNulo(cfgcdgcr, "C")
            THIS.this_cDescsit         = TratarNulo(descsit, "C")
            THIS.this_nCpfobrigs       = TratarNulo(cpfobrigs, "N")
            THIS.this_nRgobrigs        = TratarNulo(rgobrigs, "N")
            THIS.this_nMfotos          = TratarNulo(mfotos, "N")
            THIS.this_nObservas        = TratarNulo(observas, "N")
            THIS.this_nInfcads         = TratarNulo(infcads, "N")
            THIS.this_nCalcimeds       = TratarNulo(calcimeds, "N")
            THIS.this_cDesccalcimeds   = TratarNulo(desccalcimeds, "C")
            THIS.this_nFpublsobr       = TratarNulo(fpublsobr, "N")
            THIS.this_cDescfpubls      = TratarNulo(descfpubls, "C")
            THIS.this_nInfsenha        = TratarNulo(infsenha, "N")
            THIS.this_nLogalt          = TratarNulo(logalt, "N")
            THIS.this_nEndobr          = TratarNulo(endobr, "N")
            THIS.this_nNumobr          = TratarNulo(numobr, "N")
            THIS.this_nBairroobr       = TratarNulo(bairroobr, "N")
            THIS.this_nCidasobr        = TratarNulo(cidasobr, "N")
            THIS.this_nCepobris        = TratarNulo(cepobris, "N")
            THIS.this_nPaisesobr       = TratarNulo(paisesobr, "N")
            THIS.this_nChkendds        = TratarNulo(chkendds, "N")
            THIS.this_nChkendrs        = TratarNulo(chkendrs, "N")
            THIS.this_nTel1obr         = TratarNulo(tel1obr, "N")
            THIS.this_nTel2obr         = TratarNulo(tel2obr, "N")
            THIS.this_nNascobr         = TratarNulo(nascobr, "N")
            THIS.this_nSexobr          = TratarNulo(sexobr, "N")
            THIS.this_nDtnascobr       = TratarNulo(dtnascobr, "N")
            THIS.this_nDtespobr        = TratarNulo(dtespobr, "N")
            THIS.this_nObrtelefone     = TratarNulo(Obrtelefone, "N")
            THIS.this_cDesctlm         = TratarNulo(desctlm, "C")
            THIS.this_cDesccla         = TratarNulo(desccla, "C")
            THIS.this_cDescseg         = TratarNulo(descseg, "C")
            THIS.this_cContconts       = TratarNulo(contconts, "C")
            THIS.this_nIntconts        = TratarNulo(intconts, "N")
            THIS.this_nPadpgrecs       = TratarNulo(padpgrecs, "N")
            THIS.this_nCtvinculas      = TratarNulo(ctvinculas, "N")
            THIS.this_nTitbaixado      = TratarNulo(titbaixado, "N")
            THIS.this_cContapdr        = TratarNulo(contapdr, "C")
            THIS.this_nCcustotit       = TratarNulo(ccustotit, "N")
            THIS.this_nDefhideshow     = TratarNulo(defhideshow, "N")
            THIS.this_nCtainatv        = TratarNulo(ctainatv, "N")
            THIS.this_nEstoques        = TratarNulo(estoques, "N")
            THIS.this_nLimestoqs       = TratarNulo(limestoqs, "N")
            THIS.this_nVerests         = TratarNulo(verests, "N")
            THIS.this_nEmprelevs       = TratarNulo(emprelevs, "N")
            THIS.this_nBlqcongvs       = TratarNulo(blqcongvs, "N")
            THIS.this_nCalcsalds       = TratarNulo(calcsalds, "N")
            THIS.this_nChklimests      = TratarNulo(chklimests, "N")
            THIS.this_nPatrietqs       = TratarNulo(patrietqs, "N")
            THIS.this_nCcustos         = TratarNulo(ccustos, "N")
            THIS.this_nGerbals         = TratarNulo(gerbals, "N")
            THIS.this_nUnifbals        = TratarNulo(unifbals, "N")
            THIS.this_nBalfalpers      = TratarNulo(balfalpers, "N")
            THIS.this_nBlqdivops       = TratarNulo(blqdivops, "N")
            THIS.this_nInvisivel       = TratarNulo(invisivel, "N")
            THIS.this_nDdfutus         = TratarNulo(ddfutus, "N")
            THIS.this_nDdretros        = TratarNulo(ddretros, "N")
            THIS.this_nDdsems          = TratarNulo(ddsems, "N")
            THIS.this_nHordd           = TratarNulo(hordd, "N")
            THIS.this_nTipoinvs        = TratarNulo(tipoinvs, "N")
            THIS.this_nTrfpesas        = TratarNulo(trfpesas, "N")
            THIS.this_nDifpesags       = TratarNulo(difpesags, "N")
            THIS.this_nSinals          = TratarNulo(sinals, "N")
            THIS.this_cPqs             = TratarNulo(pqs, "C")
            THIS.this_nCompagrus       = TratarNulo(compagrus, "N")
            THIS.this_cAgrupas         = TratarNulo(agrupas, "C")
            THIS.this_nFichatecs       = TratarNulo(fichatecs, "N")
            THIS.this_cOsalfuns        = TratarNulo(osalfuns, "C")
            THIS.this_cGrufals         = TratarNulo(grufals, "C")
            THIS.this_nOspends         = TratarNulo(ospends, "N")
            THIS.this_nChktits         = TratarNulo(chktits, "N")
            THIS.this_nTpprecos        = TratarNulo(tpprecos, "N")
            THIS.this_cContafalha      = TratarNulo(contafalha, "C")
            THIS.this_cGrupofalha      = TratarNulo(grupofalha, "C")
            THIS.this_nCtrlotes        = TratarNulo(ctrlotes, "N")
            THIS.this_cCfgfisics       = TratarNulo(cfgfisics, "C")
            THIS.this_cCfgfisips       = TratarNulo(cfgfisips, "C")
            THIS.this_cCfgfisiis       = TratarNulo(cfgfisiis, "C")
            THIS.this_cCfgfisiss       = TratarNulo(cfgfisiss, "C")
            THIS.this_cCfgfisirs       = TratarNulo(cfgfisirs, "C")
            THIS.this_cCfgfisins       = TratarNulo(cfgfisins, "C")
            THIS.this_cCfgfispis       = TratarNulo(cfgfispis, "C")
            THIS.this_cCfgfiscss       = TratarNulo(cfgfiscss, "C")
            THIS.this_cCfgfiscos       = TratarNulo(cfgfiscos, "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT na tabela SigCdGcr
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdGcr (" + ;
                       "codigos,descrs,dgcods,internos,classes," + ;
                       "tpcods,tpemps,tpcads,complems,pessoais," + ;
                       "refbancs,followups,fiscais,contabs,empresas," + ;
                       "caracteris,respos,limcres,comis,dadcoms," + ;
                       "cargos,chklimcrds,coletors,precad,grupolms," + ;
                       "vrlimcre,molimcre,commoedas,rodrelcc,cfgcdgcr," + ;
                       "descsit,cpfobrigs,rgobrigs,mfotos,observas," + ;
                       "infcads,calcimeds,desccalcimeds,fpublsobr,descfpubls," + ;
                       "infsenha,logalt,endobr,numobr,bairroobr," + ;
                       "cidasobr,cepobris,paisesobr,chkendds,chkendrs," + ;
                       "tel1obr,tel2obr,nascobr,sexobr,dtnascobr," + ;
                       "dtespobr,obrtelefone,desctlm,desccla,descseg," + ;
                       "contconts,intconts,padpgrecs,ctvinculas,titbaixado," + ;
                       "contapdr,ccustotit,defhideshow,ctainatv,estoques," + ;
                       "limestoqs,verests,emprelevs,blqcongvs,calcsalds," + ;
                       "chklimests,patrietqs,ccustos,gerbals,unifbals," + ;
                       "balfalpers,blqdivops,invisivel,ddfutus,ddretros," + ;
                       "ddsems,hordd,tipoinvs,trfpesas,difpesags," + ;
                       "sinals,pqs,compagrus,agrupas,fichatecs," + ;
                       "osalfuns,grufals,ospends,chktits,tpprecos," + ;
                       "contafalha,grupofalha,ctrlotes," + ;
                       "cfgfisics,cfgfisips,cfgfisiis,cfgfisiss,cfgfisirs," + ;
                       "cfgfisins,cfgfispis,cfgfiscss,cfgfiscos" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + "," + ;
                       EscaparSQL(THIS.this_cDescrs) + "," + ;
                       EscaparSQL(THIS.this_cDgcods) + "," + ;
                       EscaparSQL(THIS.this_cInternos) + "," + ;
                       EscaparSQL(THIS.this_cClasses) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpcods) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpemps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpcads) + "," + ;
                       FormatarNumeroSQL(THIS.this_nComplems) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPessoais) + "," + ;
                       FormatarNumeroSQL(THIS.this_nRefbancs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFollowups) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFiscais) + "," + ;
                       FormatarNumeroSQL(THIS.this_nContabs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEmpresas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCaracteris) + "," + ;
                       FormatarNumeroSQL(THIS.this_nRespos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLimcres) + "," + ;
                       FormatarNumeroSQL(THIS.this_nComis) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDadcoms) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCargos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChklimcrds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nColetors) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPrecad) + "," + ;
                       EscaparSQL(THIS.this_cGrupolms) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVrlimcre) + "," + ;
                       EscaparSQL(THIS.this_cMolimcre) + "," + ;
                       EscaparSQL(THIS.this_cCommoedas) + "," + ;
                       EscaparSQL(THIS.this_cRodrelcc) + "," + ;
                       EscaparSQL(THIS.this_cCfgcdgcr) + "," + ;
                       EscaparSQL(THIS.this_cDescsit) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCpfobrigs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nRgobrigs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMfotos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nObservas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nInfcads) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCalcimeds) + "," + ;
                       EscaparSQL(THIS.this_cDesccalcimeds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFpublsobr) + "," + ;
                       EscaparSQL(THIS.this_cDescfpubls) + "," + ;
                       FormatarNumeroSQL(THIS.this_nInfsenha) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLogalt) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEndobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBairroobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCidasobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCepobris) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPaisesobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChkendds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChkendrs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTel1obr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTel2obr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNascobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nSexobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDtnascobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDtespobr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nObrtelefone) + "," + ;
                       EscaparSQL(THIS.this_cDesctlm) + "," + ;
                       EscaparSQL(THIS.this_cDesccla) + "," + ;
                       EscaparSQL(THIS.this_cDescseg) + "," + ;
                       EscaparSQL(THIS.this_cContconts) + "," + ;
                       FormatarNumeroSQL(THIS.this_nIntconts) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPadpgrecs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCtvinculas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTitbaixado) + "," + ;
                       EscaparSQL(THIS.this_cContapdr) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCcustotit) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDefhideshow) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCtainatv) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEstoques) + "," + ;
                       FormatarNumeroSQL(THIS.this_nLimestoqs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nVerests) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEmprelevs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBlqcongvs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCalcsalds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChklimests) + "," + ;
                       FormatarNumeroSQL(THIS.this_nPatrietqs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCcustos) + "," + ;
                       FormatarNumeroSQL(THIS.this_nGerbals) + "," + ;
                       FormatarNumeroSQL(THIS.this_nUnifbals) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBalfalpers) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBlqdivops) + "," + ;
                       FormatarNumeroSQL(THIS.this_nInvisivel) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDdfutus) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDdretros) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDdsems) + "," + ;
                       FormatarNumeroSQL(THIS.this_nHordd) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTipoinvs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTrfpesas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDifpesags) + "," + ;
                       FormatarNumeroSQL(THIS.this_nSinals) + "," + ;
                       EscaparSQL(THIS.this_cPqs) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCompagrus) + "," + ;
                       EscaparSQL(THIS.this_cAgrupas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFichatecs) + "," + ;
                       EscaparSQL(THIS.this_cOsalfuns) + "," + ;
                       EscaparSQL(THIS.this_cGrufals) + "," + ;
                       FormatarNumeroSQL(THIS.this_nOspends) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChktits) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpprecos) + "," + ;
                       EscaparSQL(THIS.this_cContafalha) + "," + ;
                       EscaparSQL(THIS.this_cGrupofalha) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCtrlotes) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisics) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisips) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisiis) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisiss) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisirs) + "," + ;
                       EscaparSQL(THIS.this_cCfgfisins) + "," + ;
                       EscaparSQL(THIS.this_cCfgfispis) + "," + ;
                       EscaparSQL(THIS.this_cCfgfiscss) + "," + ;
                       EscaparSQL(THIS.this_cCfgfiscos) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir grupo de contas correntes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir grupo de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE na tabela SigCdGcr
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdGcr SET" + ;
                       " descrs=" + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       " dgcods=" + EscaparSQL(THIS.this_cDgcods) + "," + ;
                       " internos=" + EscaparSQL(THIS.this_cInternos) + "," + ;
                       " classes=" + EscaparSQL(THIS.this_cClasses) + "," + ;
                       " tpcods=" + FormatarNumeroSQL(THIS.this_nTpcods) + "," + ;
                       " tpemps=" + FormatarNumeroSQL(THIS.this_nTpemps) + "," + ;
                       " tpcads=" + FormatarNumeroSQL(THIS.this_nTpcads) + "," + ;
                       " complems=" + FormatarNumeroSQL(THIS.this_nComplems) + "," + ;
                       " pessoais=" + FormatarNumeroSQL(THIS.this_nPessoais) + "," + ;
                       " refbancs=" + FormatarNumeroSQL(THIS.this_nRefbancs) + "," + ;
                       " followups=" + FormatarNumeroSQL(THIS.this_nFollowups) + "," + ;
                       " fiscais=" + FormatarNumeroSQL(THIS.this_nFiscais) + "," + ;
                       " contabs=" + FormatarNumeroSQL(THIS.this_nContabs) + "," + ;
                       " empresas=" + FormatarNumeroSQL(THIS.this_nEmpresas) + "," + ;
                       " caracteris=" + FormatarNumeroSQL(THIS.this_nCaracteris) + "," + ;
                       " respos=" + FormatarNumeroSQL(THIS.this_nRespos) + "," + ;
                       " limcres=" + FormatarNumeroSQL(THIS.this_nLimcres) + "," + ;
                       " comis=" + FormatarNumeroSQL(THIS.this_nComis) + "," + ;
                       " dadcoms=" + FormatarNumeroSQL(THIS.this_nDadcoms) + "," + ;
                       " cargos=" + FormatarNumeroSQL(THIS.this_nCargos) + "," + ;
                       " chklimcrds=" + FormatarNumeroSQL(THIS.this_nChklimcrds) + "," + ;
                       " coletors=" + FormatarNumeroSQL(THIS.this_nColetors) + "," + ;
                       " precad=" + FormatarNumeroSQL(THIS.this_nPrecad) + "," + ;
                       " grupolms=" + EscaparSQL(THIS.this_cGrupolms) + "," + ;
                       " vrlimcre=" + FormatarNumeroSQL(THIS.this_nVrlimcre) + "," + ;
                       " molimcre=" + EscaparSQL(THIS.this_cMolimcre) + "," + ;
                       " commoedas=" + EscaparSQL(THIS.this_cCommoedas) + "," + ;
                       " rodrelcc=" + EscaparSQL(THIS.this_cRodrelcc) + "," + ;
                       " cfgcdgcr=" + EscaparSQL(THIS.this_cCfgcdgcr) + "," + ;
                       " descsit=" + EscaparSQL(THIS.this_cDescsit) + "," + ;
                       " cpfobrigs=" + FormatarNumeroSQL(THIS.this_nCpfobrigs) + "," + ;
                       " rgobrigs=" + FormatarNumeroSQL(THIS.this_nRgobrigs) + "," + ;
                       " mfotos=" + FormatarNumeroSQL(THIS.this_nMfotos) + "," + ;
                       " observas=" + FormatarNumeroSQL(THIS.this_nObservas) + "," + ;
                       " infcads=" + FormatarNumeroSQL(THIS.this_nInfcads) + "," + ;
                       " calcimeds=" + FormatarNumeroSQL(THIS.this_nCalcimeds) + "," + ;
                       " desccalcimeds=" + EscaparSQL(THIS.this_cDesccalcimeds) + "," + ;
                       " fpublsobr=" + FormatarNumeroSQL(THIS.this_nFpublsobr) + "," + ;
                       " descfpubls=" + EscaparSQL(THIS.this_cDescfpubls) + "," + ;
                       " infsenha=" + FormatarNumeroSQL(THIS.this_nInfsenha) + "," + ;
                       " logalt=" + FormatarNumeroSQL(THIS.this_nLogalt) + "," + ;
                       " endobr=" + FormatarNumeroSQL(THIS.this_nEndobr) + "," + ;
                       " numobr=" + FormatarNumeroSQL(THIS.this_nNumobr) + "," + ;
                       " bairroobr=" + FormatarNumeroSQL(THIS.this_nBairroobr) + "," + ;
                       " cidasobr=" + FormatarNumeroSQL(THIS.this_nCidasobr) + "," + ;
                       " cepobris=" + FormatarNumeroSQL(THIS.this_nCepobris) + "," + ;
                       " paisesobr=" + FormatarNumeroSQL(THIS.this_nPaisesobr) + "," + ;
                       " chkendds=" + FormatarNumeroSQL(THIS.this_nChkendds) + "," + ;
                       " chkendrs=" + FormatarNumeroSQL(THIS.this_nChkendrs) + "," + ;
                       " tel1obr=" + FormatarNumeroSQL(THIS.this_nTel1obr) + "," + ;
                       " tel2obr=" + FormatarNumeroSQL(THIS.this_nTel2obr) + "," + ;
                       " nascobr=" + FormatarNumeroSQL(THIS.this_nNascobr) + "," + ;
                       " sexobr=" + FormatarNumeroSQL(THIS.this_nSexobr) + "," + ;
                       " dtnascobr=" + FormatarNumeroSQL(THIS.this_nDtnascobr) + "," + ;
                       " dtespobr=" + FormatarNumeroSQL(THIS.this_nDtespobr) + "," + ;
                       " obrtelefone=" + FormatarNumeroSQL(THIS.this_nObrtelefone) + "," + ;
                       " desctlm=" + EscaparSQL(THIS.this_cDesctlm) + "," + ;
                       " desccla=" + EscaparSQL(THIS.this_cDesccla) + "," + ;
                       " descseg=" + EscaparSQL(THIS.this_cDescseg) + "," + ;
                       " contconts=" + EscaparSQL(THIS.this_cContconts) + "," + ;
                       " intconts=" + FormatarNumeroSQL(THIS.this_nIntconts) + "," + ;
                       " padpgrecs=" + FormatarNumeroSQL(THIS.this_nPadpgrecs) + "," + ;
                       " ctvinculas=" + FormatarNumeroSQL(THIS.this_nCtvinculas) + "," + ;
                       " titbaixado=" + FormatarNumeroSQL(THIS.this_nTitbaixado) + "," + ;
                       " contapdr=" + EscaparSQL(THIS.this_cContapdr) + "," + ;
                       " ccustotit=" + FormatarNumeroSQL(THIS.this_nCcustotit) + "," + ;
                       " defhideshow=" + FormatarNumeroSQL(THIS.this_nDefhideshow) + "," + ;
                       " ctainatv=" + FormatarNumeroSQL(THIS.this_nCtainatv) + "," + ;
                       " estoques=" + FormatarNumeroSQL(THIS.this_nEstoques) + "," + ;
                       " limestoqs=" + FormatarNumeroSQL(THIS.this_nLimestoqs) + "," + ;
                       " verests=" + FormatarNumeroSQL(THIS.this_nVerests) + "," + ;
                       " emprelevs=" + FormatarNumeroSQL(THIS.this_nEmprelevs) + "," + ;
                       " blqcongvs=" + FormatarNumeroSQL(THIS.this_nBlqcongvs) + "," + ;
                       " calcsalds=" + FormatarNumeroSQL(THIS.this_nCalcsalds) + "," + ;
                       " chklimests=" + FormatarNumeroSQL(THIS.this_nChklimests) + "," + ;
                       " patrietqs=" + FormatarNumeroSQL(THIS.this_nPatrietqs) + "," + ;
                       " ccustos=" + FormatarNumeroSQL(THIS.this_nCcustos) + "," + ;
                       " gerbals=" + FormatarNumeroSQL(THIS.this_nGerbals) + "," + ;
                       " unifbals=" + FormatarNumeroSQL(THIS.this_nUnifbals) + "," + ;
                       " balfalpers=" + FormatarNumeroSQL(THIS.this_nBalfalpers) + "," + ;
                       " blqdivops=" + FormatarNumeroSQL(THIS.this_nBlqdivops) + "," + ;
                       " invisivel=" + FormatarNumeroSQL(THIS.this_nInvisivel) + "," + ;
                       " ddfutus=" + FormatarNumeroSQL(THIS.this_nDdfutus) + "," + ;
                       " ddretros=" + FormatarNumeroSQL(THIS.this_nDdretros) + "," + ;
                       " ddsems=" + FormatarNumeroSQL(THIS.this_nDdsems) + "," + ;
                       " hordd=" + FormatarNumeroSQL(THIS.this_nHordd) + "," + ;
                       " tipoinvs=" + FormatarNumeroSQL(THIS.this_nTipoinvs) + "," + ;
                       " trfpesas=" + FormatarNumeroSQL(THIS.this_nTrfpesas) + "," + ;
                       " difpesags=" + FormatarNumeroSQL(THIS.this_nDifpesags) + "," + ;
                       " sinals=" + FormatarNumeroSQL(THIS.this_nSinals) + "," + ;
                       " pqs=" + EscaparSQL(THIS.this_cPqs) + "," + ;
                       " compagrus=" + FormatarNumeroSQL(THIS.this_nCompagrus) + "," + ;
                       " agrupas=" + EscaparSQL(THIS.this_cAgrupas) + "," + ;
                       " fichatecs=" + FormatarNumeroSQL(THIS.this_nFichatecs) + "," + ;
                       " osalfuns=" + EscaparSQL(THIS.this_cOsalfuns) + "," + ;
                       " grufals=" + EscaparSQL(THIS.this_cGrufals) + "," + ;
                       " ospends=" + FormatarNumeroSQL(THIS.this_nOspends) + "," + ;
                       " chktits=" + FormatarNumeroSQL(THIS.this_nChktits) + "," + ;
                       " tpprecos=" + FormatarNumeroSQL(THIS.this_nTpprecos) + "," + ;
                       " contafalha=" + EscaparSQL(THIS.this_cContafalha) + "," + ;
                       " grupofalha=" + EscaparSQL(THIS.this_cGrupofalha) + "," + ;
                       " ctrlotes=" + FormatarNumeroSQL(THIS.this_nCtrlotes) + "," + ;
                       " cfgfisics=" + EscaparSQL(THIS.this_cCfgfisics) + "," + ;
                       " cfgfisips=" + EscaparSQL(THIS.this_cCfgfisips) + "," + ;
                       " cfgfisiis=" + EscaparSQL(THIS.this_cCfgfisiis) + "," + ;
                       " cfgfisiss=" + EscaparSQL(THIS.this_cCfgfisiss) + "," + ;
                       " cfgfisirs=" + EscaparSQL(THIS.this_cCfgfisirs) + "," + ;
                       " cfgfisins=" + EscaparSQL(THIS.this_cCfgfisins) + "," + ;
                       " cfgfispis=" + EscaparSQL(THIS.this_cCfgfispis) + "," + ;
                       " cfgfiscss=" + EscaparSQL(THIS.this_cCfgfiscss) + "," + ;
                       " cfgfiscos=" + EscaparSQL(THIS.this_cCfgfiscos) + ;
                       " WHERE codigos=" + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar grupo de contas correntes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar grupo de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE da tabela SigCdGcr com verificacao de dependencias
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_cCodigo, loc_nCount, loc_nResultado, loc_lSucesso, loc_lBloqueado
        loc_lSucesso  = .F.
        loc_lBloqueado = .F.
        loc_cCodigo   = EscaparSQL(ALLTRIM(THIS.this_cCodigos))

        TRY
            IF !loc_lBloqueado
                loc_cSQL = "SELECT COUNT(*) AS cnt FROM SigMvCcr WHERE RTRIM(Grupos) = " + loc_cCodigo
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk") >= 0
                    SELECT cursor_4c_Chk
                    loc_nCount = cursor_4c_Chk.cnt
                    USE IN cursor_4c_Chk
                    IF loc_nCount > 0
                        loc_lBloqueado = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lBloqueado
                loc_cSQL = "SELECT COUNT(*) AS cnt FROM SigCdCli WHERE RTRIM(Grupos) = " + loc_cCodigo
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk") >= 0
                    SELECT cursor_4c_Chk
                    loc_nCount = cursor_4c_Chk.cnt
                    USE IN cursor_4c_Chk
                    IF loc_nCount > 0
                        loc_lBloqueado = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lBloqueado
                loc_cSQL = "SELECT COUNT(*) AS cnt FROM SigMvCab WHERE RTRIM(Grupos) = " + loc_cCodigo
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chk") >= 0
                    SELECT cursor_4c_Chk
                    loc_nCount = cursor_4c_Chk.cnt
                    USE IN cursor_4c_Chk
                    IF loc_nCount > 0
                        loc_lBloqueado = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lBloqueado
                MsgAviso("Aten" + CHR(231) + CHR(227) + "o!!! Existem Lan" + CHR(231) + "amentos Efetuados Neste Grupo!!!" + CHR(13) + ;
                        "Exclua Todos os Lan" + CHR(231) + "amentos Antes de Excluir o Grupo!!!", "ERRO!!!")
            ELSE
                loc_cSQL = "DELETE FROM SigCdGcr WHERE codigos = " + loc_cCodigo
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir grupo de contas correntes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_Chk")
                USE IN cursor_4c_Chk
            ENDIF
            MsgErro("Erro ao excluir grupo de contas correntes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

