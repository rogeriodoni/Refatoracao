# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CODIGOS

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
  ControlSource = "crSigCdCfo.codigos"
  ControlSource = "crSigCdCfo.Ndigitos"
  ControlSource = "crSigCdCfo.descricaos"
  ControlSource = "crSigCdCfo.Desc2s"
  ControlSource = "crSigCdCfo.InclIPIs"
  ControlSource = "crSigCdCfo.tipos"
  ControlSource = "crSigCdCfo.AliqII"
  ControlSource = "crSigCdCfo.AliqISSQN"
  ControlSource = "crSigCdCfo.IcmsIncs"
  ControlSource = "crSigCdCfo.InclIcms"
  ControlSource = "crSigCdCfo.IpiNCreds"
  ControlSource = "crSigCdCfo.Transps"
  ControlSource = "crSigCdCfo.aliqipis"
  ControlSource = "crSigCdCfo.icmsdscs"
  ControlSource = "crSigCdCfo.cfost60s"
  ControlSource = "crSigCdCfo.pbcipis"
  ControlSource = "crSigCdCfo.Ipi_Icms"
  ControlSource = "crSigCdCfo.cgergia1s"
  ControlSource = "crSigCdCfo.ISSQNL"
  ControlSource = "crSigCdCfo.COFCST"
  ControlSource = "crSigCdCfo.PISCST"
  ControlSource = "crSigCdCfo.IPICST"
  ControlSource = "crSigCdCfo.aliqivcs"
  ControlSource = "crSigCdCfo.pbcsts"
  ControlSource = "crSigCdCfo.coddests"
  ControlSource = "crSigCdCfo.cfosts"
  ControlSource = "crSigCdCfo.sittribs"
  ControlSource = "crSigCdCfo.AliqPIS"
  ControlSource = "crSigCdCfo.AliqCOFINS"
  ControlSource = "crSigCdCfo.IPIEnq"
  ControlSource = "crSigCdCfo.situas"
  ControlSource = "crSigCdCfo.Frticms"
  ControlSource = "crSigCdCfo.SegIcms"
  ControlSource = "crSigCdCfo.DesIcms"
  ControlSource = "crSigCdCfo.FrtIpis"
  ControlSource = "crSigCdCfo.SegIpis"
  ControlSource = "crSigCdCfo.DesIpis"
  ControlSource = "crSigCdCfo.IncIcmNFs"
  ControlSource = "crSigCdCfo.CTISSQN"
  ControlSource = "crSigCdCfo.RetTribs"
  ControlSource = "crSigCdCfo.SomaIcmFrete"
  ControlSource = "crSigCdCfo.MotDeson"
  ControlSource = "crSigCdCfo.contipcs"
  ControlSource = "crSigCdCfo.contipds"
  ControlSource = "crSigCdCfo.PonteDescs"
  ControlSource = "crSigCdCfo.agrupas"
  ControlSource = "crSigCdCfo.zeradas"
  ControlSource = "crSigCdCfo.dtintfis"
  ControlSource = "crSigCdCfo.utilvars"
  ControlSource = "crSigCdCfo.contvcds"
  ControlSource = "crSigCdCfo.contvccs"
  ControlSource = "crSigCdCfo.conticds"
  ControlSource = "crSigCdCfo.contfrt"
  ControlSource = "crSigCdCfo.contseg"
  ControlSource = "crSigCdCfo.contda"
  ControlSource = "crSigCdCfo.conticcs"
  ControlSource = "crSigCdCfo.intvlrcont"
  ControlSource = "crSigCdCfo.intvlricms"
  ControlSource = "crSigCdCfo.intvlripi"
  ControlSource = "crSigCdCfo.IndMov"
  ControlSource = "crSigCdCfo.IndPagto"
Select CrSigCdCfo
select CrSigCdCfo
	Select crSigCdCfo
Select crSigCdCfo
Select CrSigCdCfo
Select CrSigCdCfo
Select CrSigCdCfo
Select CrSigCdCfo

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfo.prg) - TRECHOS RELEVANTES PARA PASS SQL (4260 linhas total):

*-- Linhas 391 a 409:
391:             USE IN cursor_4c_Dados
392:         ENDIF
393:         SET NULL ON
394:         CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), situas N(1,0))
395:         SET NULL OFF
396: 
397:         *----------------------------------------------------------------------
398:         * Grid grd_4c_Lista
399:         * Top=164 = original 135 + compensacao 29
400:         * Width=971, Height=448 (do analise.json ajustado)
401:         * RecordSource e ColumnCount FORA de WITH para criar colunas imediatamente
402:         *----------------------------------------------------------------------
403:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
404:         loc_oGrid = loc_oPagina.grd_4c_Lista
405: 
406:         loc_oGrid.Top                 = 164
407:         loc_oGrid.Left                = 12
408:         loc_oGrid.Width               = 971
409:         loc_oGrid.Height              = 445

*-- Linhas 416 a 447:
416:         loc_oGrid.HighlightBackColor  = RGB(255, 255, 255)
417:         loc_oGrid.HighlightForeColor  = RGB(15, 41, 104)
418:         loc_oGrid.HighlightStyle      = 2
419:         loc_oGrid.DeleteMark          = .F.
420:         loc_oGrid.RecordMark          = .F.
421:         loc_oGrid.RowHeight           = 16
422:         loc_oGrid.ScrollBars          = 2
423:         loc_oGrid.ReadOnly            = .T.
424:         *-- RecordSource + ColumnCount FORA do WITH (cria colunas imediatamente)
425:         loc_oGrid.RecordSource = "cursor_4c_Dados"
426:         loc_oGrid.ColumnCount  = 2
427:         *-- Configurar colunas APOS RecordSource
428:         loc_oGrid.Column1.ControlSource        = "cursor_4c_Dados.codigos"
429:         loc_oGrid.Column1.Width                = 80
430:         loc_oGrid.Column1.Header1.Caption      = "C" + CHR(243) + "digo"
431:         loc_oGrid.Column1.DynamicForeColor     = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(128,128,128))"
432:         loc_oGrid.Column2.ControlSource        = "cursor_4c_Dados.descricaos"
433:         loc_oGrid.Column2.Width                = 400
434:         loc_oGrid.Column2.Header1.Caption      = "Descri" + CHR(231) + CHR(227) + "o"
435:         loc_oGrid.Column2.DynamicForeColor     = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(128,128,128))"
436: 
437:         *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
438:         THIS.TornarControlesVisiveis(loc_oPagina)
439:     ENDPROC
440: 
441:     *==========================================================================
442:     * ConfigurarPaginaDados - Configura Page2 (Formulario de dados do CFOP)
443:     * Contem: botoes Salvar/Cancelar + PageFrame interno com 2 sub-paginas fiscais
444:     * Os campos serao adicionados na Fase 5
445:     *==========================================================================
446:     PROTECTED PROCEDURE ConfigurarPaginaDados()
447:         LOCAL loc_oPagina

*-- Linhas 564 a 587:
564:                         *-- RecordSource + ColumnCount FORA do WITH
565:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
566:                         loc_oGrid.ColumnCount  = 2
567:                         *-- ControlSource e Headers APOS RecordSource
568:                         loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.codigos"
569:                         loc_oGrid.Column1.Width            = 80
570:                         loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
571:                         loc_oGrid.Column1.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(128,128,128))"
572:                         loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.descricaos"
573:                         loc_oGrid.Column2.Width            = 400
574:                         loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
575:                         loc_oGrid.Column2.DynamicForeColor = "IIF(cursor_4c_Dados.situas=1,RGB(0,0,0),RGB(128,128,128))"
576:                         THIS.FormatarGridLista(loc_oGrid)
577:                         loc_lResultado = .T.
578:                     ELSE
579:                         loc_lResultado = .F.
580:                     ENDIF
581:                 ENDIF
582:             ENDIF
583:         CATCH TO loException
584:             MostrarErro("Erro ao carregar lista de CFOP:" + CHR(13) + loException.Message, "Erro")
585:             loc_lResultado = .F.
586:         ENDTRY
587: 

*-- Linhas 641 a 659:
641:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
642:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
643:             ELSE
644:                 SELECT cursor_4c_Dados
645:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
646:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
647:                     THIS.BOParaForm()
648:                     THIS.this_cModoAtual = "VISUALIZAR"
649:                     THIS.HabilitarCampos(.F.)
650:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.ActivePage = 1
651:                     THIS.AlternarPagina(2)
652:                 ELSE
653:                     MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
654:                 ENDIF
655:             ENDIF
656:         CATCH TO loException
657:             MostrarErro("Erro ao visualizar:" + CHR(13) + loException.Message, "Erro")
658:         ENDTRY
659:     ENDPROC

*-- Linhas 669 a 687:
669:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
670:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
671:             ELSE
672:                 SELECT cursor_4c_Dados
673:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
674:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
675:                     THIS.this_oBusinessObject.EditarRegistro()
676:                     THIS.BOParaForm()
677:                     THIS.this_cModoAtual = "ALTERAR"
678:                     THIS.HabilitarCampos(.T.)
679:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.ActivePage = 1
680:                     THIS.AlternarPagina(2)
681:                 ELSE
682:                     MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
683:                 ENDIF
684:             ENDIF
685:         CATCH TO loException
686:             MostrarErro("Erro ao alterar:" + CHR(13) + loException.Message, "Erro")
687:         ENDTRY

*-- Linhas 699 a 717:
699:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
700:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
701:             ELSE
702:                 SELECT cursor_4c_Dados
703:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
704: 
705:                 loc_lConfirma = MsgConfirma("Confirmar exclus" + CHR(227) + "o do CFOP [" + ;
706:                     loc_cCodigo + "]?", "Confirmar")
707: 
708:                 IF loc_lConfirma
709:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
710:                         IF THIS.this_oBusinessObject.Excluir()
711:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
712:                             THIS.CarregarLista()
713:                         ELSE
714:                             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Aviso")
715:                         ENDIF
716:                     ELSE
717:                         MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")

*-- Linhas 745 a 763:
745:                     *-- Recarregar lista e posicionar no registro encontrado
746:                     THIS.CarregarLista()
747:                     IF USED("cursor_4c_Dados")
748:                         SELECT cursor_4c_Dados
749:                         LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
750:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
751:                     ENDIF
752:                 ENDIF
753:                 loc_oBusca.Release()
754:             ENDIF
755:         CATCH TO loException
756:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "Erro")
757:         ENDTRY
758: 
759:         IF USED("cursor_4c_BuscaCfop")
760:             USE IN cursor_4c_BuscaCfop
761:         ENDIF
762:     ENDPROC
763: 

*-- Linhas 824 a 850:
824: 
825:         TRY
826:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
827:                 SELECT cursor_4c_Dados
828:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
829: 
830:                 IF !EMPTY(loc_cCodigo)
831:                     THIS.LockScreen = .T.
832:                     DO FORM SigOpXml WITH THIS, loc_cCodigo, "E", "CFOP", 10
833:                     THIS.CarregarLista()
834:                     IF USED("cursor_4c_Dados")
835:                         SELECT cursor_4c_Dados
836:                         LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
837:                     ENDIF
838:                     THIS.LockScreen = .F.
839:                     loc_lResultado = .T.
840:                 ENDIF
841:             ELSE
842:                 MsgAviso("Selecione um CFOP para exportar.", "Aviso")
843:             ENDIF
844:         CATCH TO loException
845:             THIS.LockScreen = .F.
846:             MostrarErro("Erro ao exportar XML:" + CHR(13) + loException.Message, "Erro")
847:         ENDTRY
848: 
849:         RETURN loc_lResultado
850:     ENDPROC

*-- Linhas 1257 a 1275:
1257:             loc_oBO.this_nIcmsincs  = IIF(loc_oPag1.cmb_4c_IcmsInclPreco.ListIndex = 1, 1, 0)
1258:             loc_oBO.this_nIpincreds = IIF(loc_oPag1.cmb_4c_NaoCreditado.ListIndex = 1, 1, 0)
1259: 
1260:             *-- C(1) combos: store first char of selected text
1261:             IF loc_oPag1.cmb_4c_IpiIcms.ListIndex >= 1
1262:                 loc_oBO.this_cIpi_Icms  = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_IpiIcms.Value)), 1)
1263:             ENDIF
1264:             IF loc_oPag1.cmb_4c_Icms.ListIndex >= 1
1265:                 loc_oBO.this_cIcms      = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_Icms.Value)), 1)
1266:             ENDIF
1267:             IF loc_oPag1.cmb_4c_STRIB.ListIndex >= 1
1268:                 loc_oBO.this_cSubtribs  = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_STRIB.Value)), 1)
1269:             ENDIF
1270:             IF loc_oPag1.cmb_4c_ContribNFe.ListIndex >= 1
1271:                 loc_oBO.this_cContribs  = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_ContribNFe.Value)), 1)
1272:             ENDIF
1273:             IF loc_oPag1.cmb_4c_UnitImp.ListIndex >= 1
1274:                 loc_oBO.this_cUnitimps  = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_UnitImp.Value)), 1)
1275:             ENDIF

*-- Linhas 4160 a 4179:
4160:                 loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4161:                 loc_cVal  = ALLTRIM(loc_oPag2.txt_4c_ContFrt.Value)
4162:                 IF !EMPTY(loc_cVal)
4163:                     loc_cSQL   = "SELECT COUNT(*) AS nExiste FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cVal)
4164:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")
4165:                     IF loc_nResult >= 0 AND USED("cursor_4c_ChkConta")
4166:                         IF cursor_4c_ChkConta.nExiste = 0
4167:                             MsgAviso("Conta n" + CHR(227) + "o cadastrada, verifique!", "Aten" + CHR(231) + CHR(227) + "o")
4168:                         ENDIF
4169:                         USE IN cursor_4c_ChkConta
4170:                     ENDIF
4171:                 ENDIF
4172:             CATCH TO loException
4173:                 MostrarErro("Erro validacao ContFrt:" + CHR(13) + loException.Message, "Erro")
4174:             ENDTRY
4175:         ENDIF
4176:     ENDPROC
4177: 
4178:     *==========================================================================
4179:     * ValidarContSegKeyPress - Valida conta de seguro contra SigCdCli ao Enter

*-- Linhas 4185 a 4204:
4185:                 loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4186:                 loc_cVal  = ALLTRIM(loc_oPag2.txt_4c_ContSeg.Value)
4187:                 IF !EMPTY(loc_cVal)
4188:                     loc_cSQL   = "SELECT COUNT(*) AS nExiste FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cVal)
4189:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")
4190:                     IF loc_nResult >= 0 AND USED("cursor_4c_ChkConta")
4191:                         IF cursor_4c_ChkConta.nExiste = 0
4192:                             MsgAviso("Conta n" + CHR(227) + "o cadastrada, verifique!", "Aten" + CHR(231) + CHR(227) + "o")
4193:                         ENDIF
4194:                         USE IN cursor_4c_ChkConta
4195:                     ENDIF
4196:                 ENDIF
4197:             CATCH TO loException
4198:                 MostrarErro("Erro validacao ContSeg:" + CHR(13) + loException.Message, "Erro")
4199:             ENDTRY
4200:         ENDIF
4201:     ENDPROC
4202: 
4203:     *==========================================================================
4204:     * ValidarContDaKeyPress - Valida conta de despesas contra SigCdCli ao Enter

*-- Linhas 4210 a 4229:
4210:                 loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4211:                 loc_cVal  = ALLTRIM(loc_oPag2.txt_4c_ContDa.Value)
4212:                 IF !EMPTY(loc_cVal)
4213:                     loc_cSQL   = "SELECT COUNT(*) AS nExiste FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cVal)
4214:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")
4215:                     IF loc_nResult >= 0 AND USED("cursor_4c_ChkConta")
4216:                         IF cursor_4c_ChkConta.nExiste = 0
4217:                             MsgAviso("Conta n" + CHR(227) + "o cadastrada, verifique!", "Aten" + CHR(231) + CHR(227) + "o")
4218:                         ENDIF
4219:                         USE IN cursor_4c_ChkConta
4220:                     ENDIF
4221:                 ENDIF
4222:             CATCH TO loException
4223:                 MostrarErro("Erro validacao ContDa:" + CHR(13) + loException.Message, "Erro")
4224:             ENDTRY
4225:         ENDIF
4226:     ENDPROC
4227: 
4228:     *==========================================================================
4229:     * BipiChangeHandler - Se base IPI nao for F ou P, zera percentual BcIPI


### BO (C:\4c\projeto\app\classes\cfoBO.prg):
*============================================================
* cfoBO.prg - Business Object para CFOP (C" + CHR(243) + "digo Fiscal)
* Tabela: SigCdCfo | PK: codigos
*============================================================
DEFINE CLASS cfoBO AS BusinessBase

    *-- Propriedades char - SigCdCfo
    this_cCodigos     = ""  && char(10) - PK
    this_cDescricaos  = ""  && char(60)
    this_cDesc2s      = ""  && char(60)
    this_cContconts   = ""  && char(1)
    this_cContribs    = ""  && char(1)
    this_cIcms        = ""  && char(1)
    this_cIpis        = ""  && char(1)
    this_cOperacaos   = ""  && char(1)
    this_cContvcds    = ""  && char(9)
    this_cContvccs    = ""  && char(9)
    this_cContipcs    = ""  && char(9)
    this_cContipds    = ""  && char(9)
    this_cConticcs    = ""  && char(9)
    this_cConticds    = ""  && char(9)
    this_cCoddests    = ""  && char(10)
    this_cSittribs    = ""  && char(3)
    this_cIpi_Icms    = ""  && char(1)
    this_cCgergia1s   = ""  && char(1)
    this_cBcipis      = ""  && char(1)
    this_cCfosts      = ""  && char(10)
    this_cSubtribs    = ""  && char(1)
    this_cAcresipis   = ""  && char(1)
    this_cIpiimpors   = ""  && char(1)
    this_cIpiom2s     = ""  && char(1)
    this_cUnitimps    = ""  && char(1)
    this_cContda      = ""  && char(9)
    this_cContfrt     = ""  && char(9)
    this_cContseg     = ""  && char(9)
    this_cIpicst      = ""  && char(2)
    this_cPiscst      = ""  && char(2)
    this_cCofcst      = ""  && char(2)
    this_cIssqnl      = ""  && char(5)
    this_cCfost60s    = ""  && char(10)
    this_cIpienq      = ""  && char(3)
    this_cMotdeson    = ""  && char(2)

    *-- Propriedades numeric - SigCdCfo
    this_nAliqipis    = 0   && numeric(4,2)
    this_nIpincreds   = 0   && numeric(1,0)
    this_nPontedescs  = 0   && numeric(1,0)
    this_nAliqivcs    = 0   && numeric(4,2)
    this_nNdigitos    = 0   && numeric(2,0)
    this_nInclicms    = 0   && numeric(1,0)
    this_nTransps     = 0   && numeric(1,0)
    this_nAgrupas     = 0   && numeric(1,0)
    this_nZeradas     = 0   && numeric(1,0)
    this_nIcmsdscs    = 0   && numeric(1,0)
    this_nInclipis    = 0   && numeric(1,0)
    this_nSituas      = 0   && numeric(1,0)
    this_nDesicms     = 0   && numeric(1,0)
    this_nDesipis     = 0   && numeric(1,0)
    this_nFrticms     = 0   && numeric(1,0)
    this_nFrtipis     = 0   && numeric(1,0)
    this_nPbcipis     = 0   && numeric(5,2)
    this_nPbcsts      = 0   && numeric(5,2)
    this_nSegicms     = 0   && numeric(1,0)
    this_nSegipis     = 0   && numeric(1,0)
    this_nDtintfis    = 0   && numeric(1,0)
    this_nIntvlrcont  = 0   && numeric(1,0)
    this_nIntvlricms  = 0   && numeric(1,0)
    this_nIntvlripi   = 0   && numeric(1,0)
    this_nIcmsincs    = 0   && numeric(1,0)
    this_nIncicmnfs   = 0   && numeric(1,0)
    this_nTipos       = 0   && numeric(1,0)
    this_nUtilvars    = 0   && numeric(1,0)
    this_nIndmov      = 0   && numeric(1,0)
    this_nIndpagto    = 0   && numeric(1,0)
    this_nTiporecs    = 0   && numeric(1,0)
    this_nAliqcofins  = 0   && numeric(5,2)
    this_nAliqpis     = 0   && numeric(5,2)
    this_nAliqissqn   = 0   && numeric(5,2)
    this_nCtissqn     = 0   && numeric(1,0)
    this_nRettribs    = 0   && numeric(1,0)
    this_nAliqii      = 0   && numeric(5,2)
    this_nObspads     = 0   && numeric(3,0)
    this_nSomaicmfrete = 0  && numeric(1,0)

    *============================================================
    PROCEDURE Init()
    *============================================================
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCfo"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos      = TratarNulo(codigos,      "C")
                THIS.this_cContconts    = TratarNulo(contconts,    "C")
                THIS.this_nAliqipis     = TratarNulo(aliqipis,     "N")
                THIS.this_cContribs     = TratarNulo(contribs,     "C")
                THIS.this_cDescricaos   = TratarNulo(descricaos,   "C")
                THIS.this_cDesc2s       = TratarNulo(desc2s,       "C")
                THIS.this_cIcms         = TratarNulo(icms,         "C")
                THIS.this_cIpis         = TratarNulo(ipis,         "C")
                THIS.this_cOperacaos    = TratarNulo(operacaos,    "C")
                THIS.this_cContvcds     = TratarNulo(contvcds,     "C")
                THIS.this_cContvccs     = TratarNulo(contvccs,     "C")
                THIS.this_cContipcs     = TratarNulo(contipcs,     "C")
                THIS.this_cContipds     = TratarNulo(contipds,     "C")
                THIS.this_cConticcs     = TratarNulo(conticcs,     "C")
                THIS.this_cConticds     = TratarNulo(conticds,     "C")
                THIS.this_cCoddests     = TratarNulo(coddests,     "C")
                THIS.this_nIpincreds    = TratarNulo(ipincreds,    "N")
                THIS.this_nPontedescs   = TratarNulo(pontedescs,   "N")
                THIS.this_cSittribs     = TratarNulo(sittribs,     "C")
                THIS.this_nAliqivcs     = TratarNulo(aliqivcs,     "N")
                THIS.this_nNdigitos     = TratarNulo(ndigitos,     "N")
                THIS.this_cIpi_Icms     = TratarNulo(ipi_icms,     "C")
                THIS.this_nInclicms     = TratarNulo(inclicms,     "N")
                THIS.this_cCgergia1s    = TratarNulo(cgergia1s,    "C")
                THIS.this_nTransps      = TratarNulo(transps,      "N")
                THIS.this_nAgrupas      = TratarNulo(agrupas,      "N")
                THIS.this_nZeradas      = TratarNulo(zeradas,      "N")
                THIS.this_nIcmsdscs     = TratarNulo(icmsdscs,     "N")
                THIS.this_nInclipis     = TratarNulo(inclipis,     "N")
                THIS.this_nSituas       = TratarNulo(situas,       "N")
                THIS.this_cBcipis       = TratarNulo(bcipis,       "C")
                THIS.this_cCfosts       = TratarNulo(cfosts,       "C")
                THIS.this_nDesicms      = TratarNulo(desicms,      "N")
                THIS.this_nDesipis      = TratarNulo(desipis,      "N")
                THIS.this_nFrticms      = TratarNulo(frticms,      "N")
                THIS.this_nFrtipis      = TratarNulo(frtipis,      "N")
                THIS.this_nPbcipis      = TratarNulo(pbcipis,      "N")
                THIS.this_nPbcsts       = TratarNulo(pbcsts,       "N")
                THIS.this_nSegicms      = TratarNulo(segicms,      "N")
                THIS.this_nSegipis      = TratarNulo(segipis,      "N")
                THIS.this_cSubtribs     = TratarNulo(subtribs,     "C")
                THIS.this_cAcresipis    = TratarNulo(acresipis,    "C")
                THIS.this_cIpiimpors    = TratarNulo(ipiimpors,    "C")
                THIS.this_nDtintfis     = TratarNulo(dtintfis,     "N")
                THIS.this_cIpiom2s      = TratarNulo(ipiom2s,      "C")
                THIS.this_cUnitimps     = TratarNulo(unitimps,     "C")
                THIS.this_nIntvlrcont   = TratarNulo(intvlrcont,   "N")
                THIS.this_nIntvlricms   = TratarNulo(intvlricms,   "N")
                THIS.this_nIntvlripi    = TratarNulo(intvlripi,    "N")
                THIS.this_nIcmsincs     = TratarNulo(icmsincs,     "N")
                THIS.this_nIncicmnfs    = TratarNulo(incicmnfs,    "N")
                THIS.this_nTipos        = TratarNulo(tipos,        "N")
                THIS.this_nUtilvars     = TratarNulo(utilvars,     "N")
                THIS.this_cContda       = TratarNulo(contda,       "C")
                THIS.this_cContfrt      = TratarNulo(contfrt,      "C")
                THIS.this_cContseg      = TratarNulo(contseg,      "C")
                THIS.this_nIndmov       = TratarNulo(indmov,       "N")
                THIS.this_nIndpagto     = TratarNulo(indpagto,     "N")
                THIS.this_nTiporecs     = TratarNulo(tiporecs,     "N")
                THIS.this_cIpicst       = TratarNulo(ipicst,       "C")
                THIS.this_cPiscst       = TratarNulo(piscst,       "C")
                THIS.this_cCofcst       = TratarNulo(cofcst,       "C")
                THIS.this_cIssqnl       = TratarNulo(issqnl,       "C")
                THIS.this_nAliqcofins   = TratarNulo(aliqcofins,   "N")
                THIS.this_nAliqpis      = TratarNulo(aliqpis,      "N")
                THIS.this_nAliqissqn    = TratarNulo(aliqissqn,    "N")
                THIS.this_nCtissqn      = TratarNulo(ctissqn,      "N")
                THIS.this_nRettribs     = TratarNulo(rettribs,     "N")
                THIS.this_nAliqii       = TratarNulo(aliqii,       "N")
                THIS.this_cCfost60s     = TratarNulo(cfost60s,     "C")
                THIS.this_nObspads      = TratarNulo(obspads,      "N")
                THIS.this_cIpienq       = TratarNulo(ipienq,       "C")
                THIS.this_nSomaicmfrete = TratarNulo(somaicmfrete, "N")
                THIS.this_cMotdeson     = TratarNulo(motdeson,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "cfoBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCfo (
                    codigos, contconts, aliqipis, contribs, descricaos, desc2s,
                    icms, ipis, operacaos, contvcds, contvccs, contipcs, contipds,
                    conticcs, conticds, coddests, ipincreds, pontedescs, sittribs,
                    aliqivcs, ndigitos, ipi_icms, inclicms, cgergia1s, transps,
                    agrupas, zeradas, icmsdscs, inclipis, situas, bcipis, cfosts,
                    desicms, desipis, frticms, frtipis, pbcipis, pbcsts,
                    segicms, segipis, subtribs, acresipis, ipiimpors, dtintfis,
                    ipiom2s, unitimps, intvlrcont, intvlricms, intvlripi,
                    icmsincs, incicmnfs, tipos, utilvars, contda, contfrt, contseg,
                    indmov, indpagto, tiporecs, ipicst, piscst, cofcst, issqnl,
                    aliqcofins, aliqpis, aliqissqn, ctissqn, rettribs, aliqii,
                    cfost60s, obspads, ipienq, somaicmfrete, motdeson
                ) VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cContconts)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqipis, 2)>>,
                    <<EscaparSQL(THIS.this_cContribs)>>,
                    <<EscaparSQL(THIS.this_cDescricaos)>>,
                    <<EscaparSQL(THIS.this_cDesc2s)>>,
                    <<EscaparSQL(THIS.this_cIcms)>>,
                    <<EscaparSQL(THIS.this_cIpis)>>,
                    <<EscaparSQL(THIS.this_cOperacaos)>>,
                    <<EscaparSQL(THIS.this_cContvcds)>>,
                    <<EscaparSQL(THIS.this_cContvccs)>>,
                    <<EscaparSQL(THIS.this_cContipcs)>>,
                    <<EscaparSQL(THIS.this_cContipds)>>,
                    <<EscaparSQL(THIS.this_cConticcs)>>,
                    <<EscaparSQL(THIS.this_cConticds)>>,
                    <<EscaparSQL(THIS.this_cCoddests)>>,
                    <<FormatarNumeroSQL(THIS.this_nIpincreds, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPontedescs, 0)>>,
                    <<EscaparSQL(THIS.this_cSittribs)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqivcs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nNdigitos, 0)>>,
                    <<EscaparSQL(THIS.this_cIpi_Icms)>>,
                    <<FormatarNumeroSQL(THIS.this_nInclicms, 0)>>,
                    <<EscaparSQL(THIS.this_cCgergia1s)>>,
                    <<FormatarNumeroSQL(THIS.this_nTransps, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAgrupas, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nZeradas, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcmsdscs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nInclipis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nSituas, 0)>>,
                    <<EscaparSQL(THIS.this_cBcipis)>>,
                    <<EscaparSQL(THIS.this_cCfosts)>>,
                    <<FormatarNumeroSQL(THIS.this_nDesicms, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nDesipis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nFrticms, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nFrtipis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPbcipis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nPbcsts, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nSegicms, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nSegipis, 0)>>,
                    <<EscaparSQL(THIS.this_cSubtribs)>>,
                    <<EscaparSQL(THIS.this_cAcresipis)>>,
                    <<EscaparSQL(THIS.this_cIpiimpors)>>,
                    <<FormatarNumeroSQL(THIS.this_nDtintfis, 0)>>,
                    <<EscaparSQL(THIS.this_cIpiom2s)>>,
                    <<EscaparSQL(THIS.this_cUnitimps)>>,
                    <<FormatarNumeroSQL(THIS.this_nIntvlrcont, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIntvlricms, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIntvlripi, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcmsincs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIncicmnfs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nUtilvars, 0)>>,
                    <<EscaparSQL(THIS.this_cContda)>>,
                    <<EscaparSQL(THIS.this_cContfrt)>>,
                    <<EscaparSQL(THIS.this_cContseg)>>,
                    <<FormatarNumeroSQL(THIS.this_nIndmov, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIndpagto, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTiporecs, 0)>>,
                    <<EscaparSQL(THIS.this_cIpicst)>>,
                    <<EscaparSQL(THIS.this_cPiscst)>>,
                    <<EscaparSQL(THIS.this_cCofcst)>>,
                    <<EscaparSQL(THIS.this_cIssqnl)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqcofins, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqpis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqissqn, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nCtissqn, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nRettribs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqii, 2)>>,
                    <<EscaparSQL(THIS.this_cCfost60s)>>,
                    <<FormatarNumeroSQL(THIS.this_nObspads, 0)>>,
                    <<EscaparSQL(THIS.this_cIpienq)>>,
                    <<FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0)>>,
                    <<EscaparSQL(THIS.this_cMotdeson)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "cfoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCfo SET
                    contconts    = <<EscaparSQL(THIS.this_cContconts)>>,
                    aliqipis     = <<FormatarNumeroSQL(THIS.this_nAliqipis, 2)>>,
                    contribs     = <<EscaparSQL(THIS.this_cContribs)>>,
                    descricaos   = <<EscaparSQL(THIS.this_cDescricaos)>>,
                    desc2s       = <<EscaparSQL(THIS.this_cDesc2s)>>,
                    icms         = <<EscaparSQL(THIS.this_cIcms)>>,
                    ipis         = <<EscaparSQL(THIS.this_cIpis)>>,
                    operacaos    = <<EscaparSQL(THIS.this_cOperacaos)>>,
                    contvcds     = <<EscaparSQL(THIS.this_cContvcds)>>,
                    contvccs     = <<EscaparSQL(THIS.this_cContvccs)>>,
                    contipcs     = <<EscaparSQL(THIS.this_cContipcs)>>,
                    contipds     = <<EscaparSQL(THIS.this_cContipds)>>,
                    conticcs     = <<EscaparSQL(THIS.this_cConticcs)>>,
                    conticds     = <<EscaparSQL(THIS.this_cConticds)>>,
                    coddests     = <<EscaparSQL(THIS.this_cCoddests)>>,
                    ipincreds    = <<FormatarNumeroSQL(THIS.this_nIpincreds, 0)>>,
                    pontedescs   = <<FormatarNumeroSQL(THIS.this_nPontedescs, 0)>>,
                    sittribs     = <<EscaparSQL(THIS.this_cSittribs)>>,
                    aliqivcs     = <<FormatarNumeroSQL(THIS.this_nAliqivcs, 2)>>,
                    ndigitos     = <<FormatarNumeroSQL(THIS.this_nNdigitos, 0)>>,
                    ipi_icms     = <<EscaparSQL(THIS.this_cIpi_Icms)>>,
                    inclicms     = <<FormatarNumeroSQL(THIS.this_nInclicms, 0)>>,
                    cgergia1s    = <<EscaparSQL(THIS.this_cCgergia1s)>>,
                    transps      = <<FormatarNumeroSQL(THIS.this_nTransps, 0)>>,
                    agrupas      = <<FormatarNumeroSQL(THIS.this_nAgrupas, 0)>>,
                    zeradas      = <<FormatarNumeroSQL(THIS.this_nZeradas, 0)>>,
                    icmsdscs     = <<FormatarNumeroSQL(THIS.this_nIcmsdscs, 0)>>,
                    inclipis     = <<FormatarNumeroSQL(THIS.this_nInclipis, 0)>>,
                    situas       = <<FormatarNumeroSQL(THIS.this_nSituas, 0)>>,
                    bcipis       = <<EscaparSQL(THIS.this_cBcipis)>>,
                    cfosts       = <<EscaparSQL(THIS.this_cCfosts)>>,
                    desicms      = <<FormatarNumeroSQL(THIS.this_nDesicms, 0)>>,
                    desipis      = <<FormatarNumeroSQL(THIS.this_nDesipis, 0)>>,
                    frticms      = <<FormatarNumeroSQL(THIS.this_nFrticms, 0)>>,
                    frtipis      = <<FormatarNumeroSQL(THIS.this_nFrtipis, 0)>>,
                    pbcipis      = <<FormatarNumeroSQL(THIS.this_nPbcipis, 2)>>,
                    pbcsts       = <<FormatarNumeroSQL(THIS.this_nPbcsts, 2)>>,
                    segicms      = <<FormatarNumeroSQL(THIS.this_nSegicms, 0)>>,
                    segipis      = <<FormatarNumeroSQL(THIS.this_nSegipis, 0)>>,
                    subtribs     = <<EscaparSQL(THIS.this_cSubtribs)>>,
                    acresipis    = <<EscaparSQL(THIS.this_cAcresipis)>>,
                    ipiimpors    = <<EscaparSQL(THIS.this_cIpiimpors)>>,
                    dtintfis     = <<FormatarNumeroSQL(THIS.this_nDtintfis, 0)>>,
                    ipiom2s      = <<EscaparSQL(THIS.this_cIpiom2s)>>,
                    unitimps     = <<EscaparSQL(THIS.this_cUnitimps)>>,
                    intvlrcont   = <<FormatarNumeroSQL(THIS.this_nIntvlrcont, 0)>>,
                    intvlricms   = <<FormatarNumeroSQL(THIS.this_nIntvlricms, 0)>>,
                    intvlripi    = <<FormatarNumeroSQL(THIS.this_nIntvlripi, 0)>>,
                    icmsincs     = <<FormatarNumeroSQL(THIS.this_nIcmsincs, 0)>>,
                    incicmnfs    = <<FormatarNumeroSQL(THIS.this_nIncicmnfs, 0)>>,
                    tipos        = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    utilvars     = <<FormatarNumeroSQL(THIS.this_nUtilvars, 0)>>,
                    contda       = <<EscaparSQL(THIS.this_cContda)>>,
                    contfrt      = <<EscaparSQL(THIS.this_cContfrt)>>,
                    contseg      = <<EscaparSQL(THIS.this_cContseg)>>,
                    indmov       = <<FormatarNumeroSQL(THIS.this_nIndmov, 0)>>,
                    indpagto     = <<FormatarNumeroSQL(THIS.this_nIndpagto, 0)>>,
                    tiporecs     = <<FormatarNumeroSQL(THIS.this_nTiporecs, 0)>>,
                    ipicst       = <<EscaparSQL(THIS.this_cIpicst)>>,
                    piscst       = <<EscaparSQL(THIS.this_cPiscst)>>,
                    cofcst       = <<EscaparSQL(THIS.this_cCofcst)>>,
                    issqnl       = <<EscaparSQL(THIS.this_cIssqnl)>>,
                    aliqcofins   = <<FormatarNumeroSQL(THIS.this_nAliqcofins, 2)>>,
                    aliqpis      = <<FormatarNumeroSQL(THIS.this_nAliqpis, 2)>>,
                    aliqissqn    = <<FormatarNumeroSQL(THIS.this_nAliqissqn, 2)>>,
                    ctissqn      = <<FormatarNumeroSQL(THIS.this_nCtissqn, 0)>>,
                    rettribs     = <<FormatarNumeroSQL(THIS.this_nRettribs, 0)>>,
                    aliqii       = <<FormatarNumeroSQL(THIS.this_nAliqii, 2)>>,
                    cfost60s     = <<EscaparSQL(THIS.this_cCfost60s)>>,
                    obspads      = <<FormatarNumeroSQL(THIS.this_nObspads, 0)>>,
                    ipienq       = <<EscaparSQL(THIS.this_cIpienq)>>,
                    somaicmfrete = <<FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0)>>,
                    motdeson     = <<EscaparSQL(THIS.this_cMotdeson)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "cfoBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigCdCfo WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "cfoBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros para o grid (codigos, descricaos, situas)
    * DynamicForeColor usa situas para destacar registros inativos
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), situas N(1,0))
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT codigos, descricaos, situas FROM SigCdCfo"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "cfoBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT codigos, contconts, aliqipis, contribs, descricaos, desc2s,
                       icms, ipis, operacaos, contvcds, contvccs, contipcs, contipds,
                       conticcs, conticds, coddests, ipincreds, pontedescs, sittribs,
                       aliqivcs, ndigitos, ipi_icms, inclicms, cgergia1s, transps,
                       agrupas, zeradas, icmsdscs, inclipis, situas, bcipis, cfosts,
                       desicms, desipis, frticms, frtipis, pbcipis, pbcsts,
                       segicms, segipis, subtribs, acresipis, ipiimpors, dtintfis,
                       ipiom2s, unitimps, intvlrcont, intvlricms, intvlripi,
                       icmsincs, incicmnfs, tipos, utilvars, contda, contfrt, contseg,
                       indmov, indpagto, tiporecs, ipicst, piscst, cofcst, issqnl,
                       aliqcofins, aliqpis, aliqissqn, ctissqn, rettribs, aliqii,
                       cfost60s, obspads, ipienq, somaicmfrete, motdeson
                FROM SigCdCfo
                WHERE codigos = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("CFOP n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "cfoBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (para auditoria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *--------------------------------------------------------------------------
    * Validar - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Validar()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescricaos))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se codigo ja existe (para INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDuplicidade(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCfo" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCfo")

            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCfo")
                SELECT cursor_4c_ChkCfo
                loc_lExiste = (cursor_4c_ChkCfo.nExiste > 0)
                USE IN cursor_4c_ChkCfo
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "cfoBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

ENDDEFINE

