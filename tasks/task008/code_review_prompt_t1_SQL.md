# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (19)
- [SQL-COLUNA] Coluna 'Instalas' referenciada como 'P.Instalas' NAO existe na tabela SigCdPro. Colunas validas: matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, cpros, cunis, custofs, cvens, datas, datatrans, descfis, dpros, dtfilms, fcustos, figjpgs, flagctabs, fvendas, icms, ifors, linhas, locals, margems, moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, obspeds, obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, reffs, sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, sgrus, metals, teors, cftios, codservs, mftios, pftios, codcors, codtams, compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs, tamhs, tamls, tamps, tptribs, volumes, ipis, dpro2s, dsccompras, encoms, figtecs, obscompras, codacbs, cravcers, cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts, cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, fabrproprs, qtminfabs, tents, codfinp, codmatp, dpro3s, consigs, ltminsv, status, aliqipis, codgarras, descecfs, encargos, idpro, nidentfixa, pesobris, pesometal, pesopdrs, extipi, iats, conquilhas, fatuals, fideals, contaccus, gruccus, dtsituas, prodvars, prodwebs, codident, conjunts, pmins, cotacalcp, qtdultcomp, figjpgs64, diasgar, chkgarvit, altura, largura, diametro, espessura, compriment, mohs, refracao, refracaodp, ativosite, categoria, codctgsite, coddptsite, custocp, dtlacto, foralinha, mostruario, mtiposervs, obsinsp, obsmkt, precode, prodnovo, prodoff, segfem, seginf, segkids, segmasc, seguni, semconsulta, skuvtex, varpesoms, dtalts, usuaalts, bestseller, obrtamser, prototipo, lancamento, fimdtlacto, origemlac, codmacro, reposauto, procfigjpgs, propriedades, unidade1, resultado1, valorminimo, valormaximo, metodoreferencia1, qtped
- [SQL-COLUNA] Coluna 'Unisp' referenciada como 'C.Unisp' NAO existe na tabela SigPrCpo. (voce quis dizer 'unicompos'?) Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal
- [SQL-COLUNA] Coluna 'Vals' referenciada como 'C.Vals' NAO existe na tabela SigPrCpo. Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal
- [SQL-COLUNA] Coluna 'Totals' referenciada como 'C.Totals' NAO existe na tabela SigPrCpo. (voce quis dizer 'totas'?) Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal
- [SQL-COLUNA] Coluna 'Moedas' referenciada como 'C.Moedas' NAO existe na tabela SigPrCpo. (voce quis dizer 'moeds'?) Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal
- [SQL-COLUNA] Coluna 'Obss' referenciada como 'C.Obss' NAO existe na tabela SigPrCpo. (voce quis dizer 'obscompos'?) Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal
- [SQL-COLUNA] Coluna 'Es' referenciada como 'C.Es' NAO existe na tabela SigPrCpo. Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal
- [SQL-COLUNA] Coluna 'Conss' referenciada como 'C.Conss' NAO existe na tabela SigPrCpo. Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal
- [SQL-COLUNA] Coluna 'Qtdss' referenciada como 'C.Qtdss' NAO existe na tabela SigPrCpo. (voce quis dizer 'qtds'?) Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal
- [SQL-COLUNA] Coluna 'Unis' referenciada como 'C.Unis' NAO existe na tabela SigPrCpo. (voce quis dizer 'unicompos'?) Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal
- [SQL-COLUNA] Coluna 'Ords' referenciada como 'C.Ords' NAO existe na tabela SigPrCpo. (voce quis dizer 'ordems'?) Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal
- [SQL-COLUNA] Coluna 'Bloqueio' referenciada como 'C.Bloqueio' NAO existe na tabela SigPrCpo. Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal
- [SQL-COLUNA] Coluna 'Ccats' referenciada como 'C.Ccats' NAO existe na tabela SigPrCpo. (voce quis dizer 'cats'?) Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal
- [SQL-COLUNA] Coluna 'Descrs' referenciada como 'F.Descrs' NAO existe na tabela SigCdPrf. Colunas validas: produtos, ordems, grupos, etiquetas, figprocs, obs, ordem2, cidchaves, minutos, uniprdts, matprdts
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MOEMRKAPS, TPCALCPS, TPCALCP, ACRESCS, VALORS, TPFTIOS, ARREDCS, VENDPESO, TPCALCCUS, TIPOS, ESTIMADO, CPROS, CGRUS, PGRU, CODS, I, SGRUS, ALTCOEF, QTDS, PRODUTOS, CUSTOS, MATS, IFORS, REFFS, COLECOES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, CIDCHAVES, _XNRG, CUNIS, PCOMPOS, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, 1, SINALS, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, CESTOS, CONJUNTS, USARPAS, APAGAR, VERSAOWEB, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, CONSESTOQ, CODTAMS, CODCORS, EAN13, CATS, OBGFATOR, ENCOMS, MKPOBRIGS, MERCS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CONTAS, PCESCOLHA, ETIQCDPRO, ETIQREF, DWVENDAS, LINHAS, LNMARCKUPA, TPCONGLOP, CNJTSQTDS, QTEQUALPS, TAG, ORDEMS, DESCRS, CODCADS, USUARS, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CSGRUS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MOEMRKAPS, TPCALCPS, TPCALCP, ACRESCS, VALORS, TPFTIOS, ARREDCS, VENDPESO, TPCALCCUS, TIPOS, ESTIMADO, CPROS, CGRUS, PGRU, CODS, I, SGRUS, ALTCOEF, QTDS, PRODUTOS, CUSTOS, MATS, IFORS, REFFS, COLECOES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, CIDCHAVES, _XNRG, CUNIS, PCOMPOS, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, 1, SINALS, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, CESTOS, CONJUNTS, USARPAS, APAGAR, VERSAOWEB, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, CONSESTOQ, CODTAMS, CODCORS, EAN13, CATS, OBGFATOR, ENCOMS, MKPOBRIGS, MERCS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CONTAS, PCESCOLHA, ETIQCDPRO, ETIQREF, DWVENDAS, LINHAS, LNMARCKUPA, TPCONGLOP, CNJTSQTDS, QTEQUALPS, TAG, ORDEMS, DESCRS, CODCADS, USUARS, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CLINS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MOEMRKAPS, TPCALCPS, TPCALCP, ACRESCS, VALORS, TPFTIOS, ARREDCS, VENDPESO, TPCALCCUS, TIPOS, ESTIMADO, CPROS, CGRUS, PGRU, CODS, I, SGRUS, ALTCOEF, QTDS, PRODUTOS, CUSTOS, MATS, IFORS, REFFS, COLECOES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, CIDCHAVES, _XNRG, CUNIS, PCOMPOS, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, 1, SINALS, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, CESTOS, CONJUNTS, USARPAS, APAGAR, VERSAOWEB, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, CONSESTOQ, CODTAMS, CODCORS, EAN13, CATS, OBGFATOR, ENCOMS, MKPOBRIGS, MERCS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CONTAS, PCESCOLHA, ETIQCDPRO, ETIQREF, DWVENDAS, LINHAS, LNMARCKUPA, TPCONGLOP, CNJTSQTDS, QTEQUALPS, TAG, ORDEMS, DESCRS, CODCADS, USUARS, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CCOLS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MOEMRKAPS, TPCALCPS, TPCALCP, ACRESCS, VALORS, TPFTIOS, ARREDCS, VENDPESO, TPCALCCUS, TIPOS, ESTIMADO, CPROS, CGRUS, PGRU, CODS, I, SGRUS, ALTCOEF, QTDS, PRODUTOS, CUSTOS, MATS, IFORS, REFFS, COLECOES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, CIDCHAVES, _XNRG, CUNIS, PCOMPOS, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, 1, SINALS, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, CESTOS, CONJUNTS, USARPAS, APAGAR, VERSAOWEB, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, CONSESTOQ, CODTAMS, CODCORS, EAN13, CATS, OBGFATOR, ENCOMS, MKPOBRIGS, MERCS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CONTAS, PCESCOLHA, ETIQCDPRO, ETIQREF, DWVENDAS, LINHAS, LNMARCKUPA, TPCONGLOP, CNJTSQTDS, QTEQUALPS, TAG, ORDEMS, DESCRS, CODCADS, USUARS, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODFINPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MOEMRKAPS, TPCALCPS, TPCALCP, ACRESCS, VALORS, TPFTIOS, ARREDCS, VENDPESO, TPCALCCUS, TIPOS, ESTIMADO, CPROS, CGRUS, PGRU, CODS, I, SGRUS, ALTCOEF, QTDS, PRODUTOS, CUSTOS, MATS, IFORS, REFFS, COLECOES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, CIDCHAVES, _XNRG, CUNIS, PCOMPOS, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, 1, SINALS, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, CESTOS, CONJUNTS, USARPAS, APAGAR, VERSAOWEB, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, CONSESTOQ, CODTAMS, CODCORS, EAN13, CATS, OBGFATOR, ENCOMS, MKPOBRIGS, MERCS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CONTAS, PCESCOLHA, ETIQCDPRO, ETIQREF, DWVENDAS, LINHAS, LNMARCKUPA, TPCONGLOP, CNJTSQTDS, QTEQUALPS, TAG, ORDEMS, DESCRS, CODCADS, USUARS, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  ControlSource = "crSigCdPro.cpros"
  ControlSource = "crSigCdPro.dpros"
  ControlSource = "crSigCdPro.cbars"
  ControlSource = "crSigCdPro.ifors"
  ControlSource = "crSigCdPro.reffs"
  ControlSource = "crSigCdPro.custofs"
  ControlSource = "crSigCdPro.pvens"
  ControlSource = "crSigCdPro.fvendas"
  ControlSource = "crSigCdPro.obspes"
  ControlSource = "crSigCdPro.obspeds"
  ControlSource = "crSigCdPro.moecusfs"
  ControlSource = "crSigCdPro.moevs"
  ControlSource = "crSigCdPro.moepvs"
  ControlSource = "crSigCdPro.linhas"
  ControlSource = "crSigCdPro.colecoes"
  ControlSource = "crSigCdPro.cgrus"
  ControlSource = "crSigCdPro.dtincs"
  ControlSource = "crSigCdPro.SGrus"
  ControlSource = "crSigCdPro.ean13"
  ControlSource = "crSigCdPro.mercs"
  ControlSource = "crSigCdPro.cproeqs"
  ControlSource = "crSigCdPro.dpro2s"
  ControlSource = "crSigCdPro.cunis"
  ControlSource = "crSigCdPro.qmins"
  ControlSource = "crSigCdPro.locals"
  ControlSource = "crSigCdPro.cunips"
  ControlSource = "crSigCdPro.situas"
  ControlSource = "crSigCdPro.obsetqs"
  ControlSource = "crSigCdPro.UltComps"
  ControlSource = "crSigCdPro.vUltComps"
  ControlSource = "crSigCdPro.MUltComps"
  ControlSource = "crSigCdPro.cClass"
  ControlSource = "crSigCdPro.UsuIncs"
  ControlSource = "crSigCdPro.IdeCPros"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigCdPro.CodFinP"
  ControlSource = "crSigCdPro.ltminsv"
  ControlSource = "crSigCdPro.dsccompras"
  ControlSource = "crSigCdPro.obscompras"
  ControlSource = "crSigCdPro.DPro3s"
  ControlSource = "crSigCdPro.pesoms"
  ControlSource = "crSigCdPro.pesobs"
  ControlSource = "crSigCdPro.volumes"
  ControlSource = "crSigCdPro.tamps"
  ControlSource = "crSigCdPro.tamls"
  ControlSource = "crSigCdPro.tamhs"
  ControlSource = "crSigCdPro.tents"
  ControlSource = "crSigCdPro.consigs"
  ControlSource = "crSigCdPro.fabrproprs"
  ControlSource = "crSigCdPro.CodTams"
  ControlSource = "crSigCdPro.CodCors"
  ControlSource = "crSigCdPro.codAcbs"
  ControlSource = "crSigCdPro.encoms"
  ControlSource = "crSigCdPro.DtSituas"
  ControlSource = "crSigCdPro.prodwebs"
  ControlSource = "crSigCdPro.prodvars"
  ControlSource = "crSigCdPro.Conjunts"
  ControlSource = "crSigCdPro.qtdultcomp"
  ControlSource = "crSigCdPro.CodIdent"
  ControlSource = "crSigCdPro.DiasGar"
  ControlSource = "crSigCdPro.ChkGarVit"
  ControlSource = "crSigCdPro.altura"
  ControlSource = "crSigCdPro.largura"
  ControlSource = "crSigCdPro.diametro"
  ControlSource = "crSigCdPro.espessura"
  ControlSource = "crSigCdPro.compriment"
  ControlSource = "crSigCdPro.qtPed"
  ControlSource = "crSigCdPro.MarkupA"
  Column1.ControlSource = ""
  Column1.SelectOnEntry = .F.
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  ControlSource = "crSigCdPro.pcuss"
  ControlSource = "crSigCdPro.montadescs"
  ControlSource = "crSigCdPro.digimaxs"
  ControlSource = "crSigCdPro.ordcompos"
  ControlSource = "crSigCdPro.compos"
  ControlSource = "crSigCdPro.casas"
  ControlSource = "crSigCdPro.pesoms"
  ControlSource = "crSigCdPro.fcustos"
  ControlSource = "crSigCdPro.custofs"
  ControlSource = "crSigCdPro.moecs"
  ControlSource = "crSigCdPro.moepcs"
  ControlSource = "crSigCdPro.moecusfs"
  DeleteMark = .F.
  Column1.ControlSource = "TotGrupo.Grupo"
  Column2.ControlSource = "TotGrupo.ValGrupo"
  Column3.ControlSource = "TotGrupo.Moeda"
  ControlSource = "crSigCdPro.cftios"
  ControlSource = "crSigCdPro.moedas"
  ControlSource = "crSigCdPro.mftios"
  ControlSource = "crSigCdPro.pftios"
  ControlSource = "crSigCdPro.moepvs"
  ControlSource = "crSigCdPro.moevs"
  ControlSource = "crSigCdPro.fvendas"
  ControlSource = "crSigCdPro.pvens"
  ControlSource = "crSigCdPro.margems"
  ControlSource = "crSigCdPro.MatPrincs"
  ControlSource = "crSigCdPro.pvideals"
  ControlSource = "CrSigPrCpo.Dcompos"
  ControlSource = "crSigCdPro.cftiocs"
  ControlSource = "crSigCdPro.pftiocs"
  ControlSource = "crSigCdPro.Status"
  ControlSource = "crSigCdPro.Encargos"
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  ControlSource = "CrSigSubCp.Dcompos"
  ControlSource = "crSigSubCp.matsubs"
  ControlSource = "crSigCdPro.FAtuals"
  ControlSource = "crSigCdPro.fideals"
  ControlSource = "CrSigPrCpo.ObsOFs"
  ControlSource = "crSigCdPro.cotaCalcP"
  ControlSource = "crSigCdPro.clfiscals"
  ControlSource = "crSigCdPro.origmercs"
  ControlSource = "crSigCdPro.tptribs"
  ControlSource = "crSigCdPro.sittricms"
  ControlSource = "crSigCdPro.CodServs"
  ControlSource = "crSigCdPro.teors"
  ControlSource = "crSigCdPro.metals"
  ControlSource = "crSigCdPro.descfis"
  ControlSource = "crSigCdPro.valors"
  ControlSource = "crSigCdPro.moedas"
  ControlSource = "crSigCdPro.icms"
  ControlSource = "crSigCdPro.descecfs"
  ControlSource = "crSigCdPro.AliqIpis"
  ControlSource = "crSigCdPro.extipi"
  ControlSource = "crSigCdPro.iats"
  DeleteMark = .F.
  ControlSource = "crSigCdPro.gruccus"
  ControlSource = "crSigCdPro.contaccus"
  ControlSource = ""
  ControlSource = "crSigCdPrf.Obs"
  ControlSource = "crSigCdGcr.descrs"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  ControlSource = "crSigCdPro.codAcbs"
  ControlSource = "crSigCdPro.qtminFabs"
  ControlSource = "crSigCdPro.CodTams"
  ControlSource = "crSigCdPro.CodCors"
  ControlSource = "crSigCdPro.PesoPdrs"
  ControlSource = "crSigCdPro.PesoBris"
  ControlSource = "crSigCdPro.CodGarras"
  ControlSource = "crSigCdPro.PesoMetal"
  ControlSource = "crSigCdPro.Varias"
  ControlSource = "crSigCdPro.CravCers"
  ControlSource = "crSigCdPro.Conquilhas"
  DeleteMark = .F.
  Column1.ControlSource = ""
  ControlSource = "crSigCdPro.qtdcpnts"
  ControlSource = "crSigCdPro.chkFunds"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  ControlSource = "crSigPrCpo.Dcompos"
  DeleteMark = .F.
  Column1.ControlSource = "TotGrupo2.Grupo"
  Column2.ControlSource = "TotGrupo2.ValGrupo"
  Column3.ControlSource = "TotGrupo2.Moeda"
  DeleteMark = .F.
  ControlSource = "crSigPrTar.ObsTars"
  DeleteMark = .F.
		Select crSigPrCpo
Select crSigCdPro
	Select Cgrus, Moeds, pCompos, Qtds From crSigPrCp2 into cursor crtmp
	Select crTmp
		Select TotGrupo
			Insert Into TotGrupo (Grupo, ValGrupo, Moeda) Values (crTmp.Cgrus, Valgr, crTmp.Moeds)
		Select TotGrupo2
			Insert Into TotGrupo2 (Grupo, ValGrupo, Moeda) Values (crTmp.Cgrus, Valgr, crTmp.Moeds)
		Select Cgrus, Moeds, pCompos, Iif(chkInstalas=2, Pesos, Qtds) as Qtds ;
		  From crSigPrCpo Where TpCalcCus = 1 into cursor crtmp
		Select Cgrus, Moeds, pCompos, Iif(chkInstalas=2, Pesos, Qtds) as Qtds ;
		  From crSigPrCpo Into cursor crtmp
	Select crTmp
		Select TotGrupo
			Insert Into TotGrupo (Grupo, ValGrupo, Moeda, Estimado ) Values ;
		Select Cgrus, Moeds, pCompos, Iif(chkInstalas=2, Pesos, Qtds) as Qtds ;
		  From crSigPrCpo ;
		Select Cgrus, Moeds, pCompos, Iif(chkInstalas=2, Pesos, Qtds) as Qtds From crSigPrCpo Into cursor crtmp
	Select crTmp
		Select TotGrupo2
			Insert Into TotGrupo2 (Grupo, ValGrupo, Moeda, Estimado ) Values ;
	Select TotGrupo
	Select TotGrupo2
SELECT CrSigPrCpo
lcQuery = [Select * ] + ;
		    [From SigOpEtq ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEti') < 1)
	Update crSigCdPro Set ImpEtiqs = crTmp.ImpEtiqs Where CPros = ThisForm.Produto
Select crSigCdPro
Select crSigCdPrd
			lcQuery = [Select Descs ] + ;
					    [From SigCdCor ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCor]) < 1)
			Select * ;
			  From crSigCdCls ;
			Select LocalClas
			Select LocalClas
		Select crSigCdDic
	Select Cgrus, Moeds, VlrCvs, QtdCvs From crSigPrCp2 Into cursor CrTmp
	Select crTmp
		Select TotGrucv
			Insert Into TotGrucv (Grupo, ValGrupo, Moeda) Values (crTmp.Cgrus, Valgr, crTmp.Moeds)
	Select Cgrus, Moeds, VlrCvs, QtdCvs, pCompos, Iif(chkInstalas=2, Pesos, Qtds) as Qtds ;
	  From crSigPrCpo Where TpCalcCus = 1 Into cursor crtmp
	Select crTmp
		Select TotGrucv
			Insert Into TotGrucv (Grupo, ValGrupo, Moeda) Values (crTmp.Cgrus, Valgr, crTmp.Moeds)
SELECT CrSigPrCpo
	.DeleteMark            = .F.
	.Column1.ControlSource = 'crListaPro.CPros'
	.Column2.ControlSource = 'Iif(ThisForm.OrdGrade = 2, crListaPro.DPro2s, crListaPro.DPros)'
		.Column4.ControlSource   = 'crListaPro.PVens'
		.Column5.ControlSource   = 'Dtoc(crListaPro.DataAlts) + Space(4) + crListaPro.HoraAlts'
		.Column6.ControlSource   = 'crListaPro.UsuaAlts'
		.Column7.ControlSource   = 'crListaPro.ImpEtiqs'
		.Column3.ControlSource   = []
		.Column3.ControlSource   = 'crListaPro.CGrus'
		.Column4.ControlSource   = 'crListaPro.SGrus'
			.Column5.ControlSource   = 'crListaPro.Compos'
			.Column5.ControlSource   = 'crListaPro.Reffs'
		.Column6.ControlSource   = 'crListaPro.Colecoes'
		.Column7.ControlSource   = 'crListaPro.ImpEtiqs'
	.Column1.ControlSource  = 'crSigCdMin.Emps'
	.Column2.ControlSource  = 'crSigCdMin.QMins'
	.DeleteMark             = .F.
	.Column1.ControlSource  = 'crSigPrCpo.Mats'
	.Column2.ControlSource  = 'crSigPrCpo.DCompos'
	.Column3.ControlSource  = 'crSigPrCpo.UniCompos'
	.Column4.ControlSource  = 'crSigPrCpo.PCompos'
	.Column5.ControlSource  = 'crSigPrCpo.Qtds'
	.Column6.ControlSource  = 'Round(Iif(crSigPrCpo.chkInstalas=2, crSigPrCpo.Pesos, crSigPrCpo.Qtds) * crSigPrCpo.PCompos, 3)'
	.Column7.ControlSource  = 'crSigPrCpo.Moeds'
	.Column8.ControlSource  = 'crSigPrCpo.ObsCompos'
	.Column9.ControlSource  = 'crSigPrCpo.Etiqs'
	.Column10.ControlSource = 'crSigPrCpo.QtsCons'
	.Column11.ControlSource = 'crSigPrCpo.Pesos'
	.Column12.ControlSource = 'crSigPrCpo.cUniPs'
	.Column13.ControlSource = 'crSigPrCpo.OrdTs'
	.Column14.ControlSource = 'crSigPrCpo.Matriz'
	.DeleteMark             = .F.
	.Column1.ControlSource  = 'crSigSubCp.Mats'
	.Column2.ControlSource  = 'crSigSubCp.DCompos'
	.Column3.ControlSource  = 'crSigSubCp.UniCompos'
	.Column4.ControlSource  = 'crSigSubCp.PCompos'
	.Column5.ControlSource  = 'crSigSubCp.Qtds'
	.Column6.ControlSource  = 'crSigSubCp.Qtds * crSigSubCp.PCompos'
	.Column7.ControlSource  = 'crSigSubCp.Moeds'
	.Column8.ControlSource  = 'crSigSubCp.ObsCompos'
	.Column9.ControlSource  = 'crSigSubCp.Etiqs'
	.Column10.ControlSource = 'crSigSubCp.QtsCons'
	.Column11.ControlSource = 'crSigSubCp.Pesos'
	.Column12.ControlSource = 'crSigSubCp.cUniPs'
	.Column13.ControlSource = 'crSigSubCp.OrdTs'
	.Column14.ControlSource = 'crSigSubCp.Matriz'
	.Column15.ControlSource = 'crSigSubCp.CodTams'	
	.DeleteMark             = .F.
	.Column1.ControlSource  = 'crSigPrCpo.Mats'
	.Column2.ControlSource  = 'crSigPrCpo.DCompos'
	.Column3.ControlSource  = 'crSigPrCpo.UniCompos'
	.Column4.ControlSource  = 'crSigPrCpo.PCompos'
	.Column5.ControlSource  = 'crSigPrCpo.Qtds'
	.Column6.ControlSource  = 'iif(crSigPrCpo.chkInstalas=2, crSigPrCpo.Pesos, crSigPrCpo.Qtds) * crSigPrCpo.PCompos'
	.Column7.ControlSource  = 'crSigPrCpo.Moeds'
	.Column8.ControlSource  = 'crSigPrCpo.ObsCompos'
	.Column9.ControlSource  = 'crSigPrCpo.Etiqs'
	.Column10.ControlSource = 'crSigPrCpo.QtsCons'
	.Column11.ControlSource = 'crSigPrCpo.Pesos'
	.Column12.ControlSource = 'crSigPrCpo.cUniPs'
	.DeleteMark             = .F.
	.Column1.ControlSource  = 'crSigCdPrf.Ordems'
	.Column2.ControlSource  = 'crSigCdPrf.Grupos'
	.Column3.ControlSource  = 'crSigCdPrf.Minutos'
	.Column4.ControlSource  = 'crSigCdPrf.UniPrdts'
	.Column5.ControlSource  = 'crSigCdPrf.MatPrdts'
	.Column1.ControlSource  = 'crSigProTp.agrupas'
	.Column2.ControlSource  = 'crSigProTp.pertemps'
	.Column1.ControlSource  = 'crSigCdCmv.Datas'
	.Column2.ControlSource  = 'crSigCdCmv.ValCuss'
	.Column3.ControlSource  = 'crSigCdCmv.Moedas'	
	.DeleteMark             = .F.
	.Column1.ControlSource  = 'crSigPrMtz.CMats'
	.Column3.ControlSource  = 'crSigPrMtz.Locals'
	.Column4.ControlSource  = 'crSigPrMtz.Qtds'
	.DeleteMark             = .f.
	.Column1.ControlSource  = [crSigPrTar.DtInis]
	.Column2.ControlSource  = [crSigPrTar.DtFims]
	.Column3.ControlSource  = [crSigPrTar.Usuars]
	.Column4.ControlSource  = [crSigPrTar.Tarefas]
	.DeleteMark             = .f.
	.Column1.ControlSource  = [crSigPrArq.Arquivos]
	.Column1.ControlSource  = 'crSigPrCpo.Mats'
	.Column2.ControlSource  = 'crSigPrCpo.Qtds'
	.Column3.ControlSource  = 'crSigPrCpo.UniCompos'
	.Column4.ControlSource  = 'crSigPrCpo.Grupos'
	.Column5.ControlSource  = 'crSigPrCpo.Dscgrp'
	.Column6.ControlSource  = 'crSigPrCpo.Ordems'
	.Column7.ControlSource  = 'crSigPrCpo.QtsCons'
	.Column8.ControlSource  = 'crSigPrCpo.Cats'
	.Column9.ControlSource  = 'crSigPrCpo.Dcompos'
Select crSigCdPrf
Select crSigPrCpo
Update crSigPrCpo Set Etiqs = [N] Where Not Etiqs = [S]
Select crSigSubCp
Update crSigSubCp Set Etiqs = [N] Where Not Etiqs = [S]
Select crSigPrCpo
Select crListaPro
Select crSigPrCpo
Select crSigSubCp
Select crSigCdPrc
Select crSigPrCp2
Select crSigSubC2
Select crSigCdPrf
Select crSigCdPfc
Select crSigPrMt2
Select crSigPrMdc
Select crSigCdGrp
Select crSigPrTam
Select crSigPrTa2
Select crSigPrCa2
Select crSigPrTar
Select crSigCdPro
	Select crSigCdGrp
	Select crSigCdGpr
	Select * From crSigPrCpo Into Cursor csTemCompo
		Select CrSigPrCpo
			Select LocalLinI
				lcSql = [Select CustoFs as pCompos, MoeCusfs as Moeds From SigCdPro Where Cpros = ']+LocalLini.Mats+[']
				ThisForm.PodataMgr.SqlExecute(lcSql,'TmpProL')
				Select TmpProl
				Insert Into crSigPrCpo From Memvar
Select &cCompo.
ThisForm.poDatamgr.SqlExecute([Select EstMins From SigCdPac],'csSigCdPac')
	Select crSigCdMin
Select Cgrus As Grupo, Mats As CPros, Moeds As Moeda, Pesos, Qtds, PCompos, 00000000.000 As ValGrupo, chkInstalas, Space(6) As sGrus ;
	From crSigPrCpo ;
Update LocalTGrupo Set ValGrupo = Iif(chkInstalas=2, Pesos, Qtds) * PCompos
Select LocalTGrupo
	Select crTmpSGr
	Select LocalTGrupo
	lcSql = [Select * From SigPrFti Where Cods = ']+MarkCus+[']
	Thisform.poDataMgr.Sqlexecute(lcSql,'TmpFtio')
	Select TmpFtio
		lcSql = [Select a.*, b.Dgrus From SigPrFto a, SigCdGrp b ] + ;
		Thisform.poDataMgr.Sqlexecute(lcSql,'TmpFtioC')
			Select LocalTGrupo
				Select TmpFtioC
					Select CsGrade
			Select CsGrade
		lcSql = [Select a.*, b.Dpros From SigPrFto a, SigCdPro b Where a.Cods = ']+MarkCus+[' And ]+;
		Thisform.poDataMgr.Sqlexecute(lcSql,'TmpFtioC')
		Select TmpFtioC
			Select CsGrade
	lcSql = [Select * From SigPrFti Where Cods = ']+MarkVen+[']
	Thisform.poDataMgr.Sqlexecute(lcSql,'TmpFtio')
	Select TmpFtio
		lcSql = [Select a.*, b.Dgrus, 0 as altcoef ] + ;
			[From SigPrFto a, SigCdGrp b ] + ;
		Thisform.poDataMgr.Sqlexecute(lcSql,'TmpFtioC')
		Select crPrFtp
				Select TmpFtioC
			Select LocalTGrupo
				Select TmpFtioC
					Select CsGrade
			Select CsGrade
		lcSql = [Select a.*, b.Dpros From SigPrFto a, SigCdPro b Where a.Cods = ']+MarkVen+[' And ]+;
		Thisform.poDataMgr.Sqlexecute(lcSql,'TmpFtioC')
		Select TmpFtioC
			Select CsGrade
		Select CsGrade
	lcQuery = [Select Top 1 CPros, Datars ] + ;
				[From SigMvHst ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalHis') < 1)
Select crSigPrCpo
Select Mats, ObsCompos ;
  From crSigPrCpo ;
Select crMontaCPros
Select CrSigPrCpo
Update crSigPrCpo Set CPros = pPro
Update crSigSubCp Set CPros = pPro
Update crSigPrMdl Set CPros = pPro
Update crSigCdPrc Set CPros = pPro
Update crSigPrCp2 Set CPros = pPro
Update crSigSubC2 Set CPros = pPro
Update crSigPrMdc Set CPros = pPro
Update crSigPrPmi Set CPros = pPro
Update crSigCdMin Set CPros = pPro
Update crSigPrCrr Set CPros = pPro
Update crSigCdPft Set CPros = pPro, ProCarTits = Cpros + CCars + CTits
Update crSigCdPrf Set Produtos = pPro
Update crSigPrMtz Set CPros = pPro
Update crSigCdPfc Set Produtos = pPro
Update crSigPrMt2 Set CPros = pPro
Update crSigPrTam Set CPros = pPro
Update crSigPrCar Set CPros = pPro
Update crSigPrTa2 Set CPros = pPro
Update crSigPrCa2 Set CPros = pPro
Update crListaPro Set CPros = pPro &&& Tiago - 17/07/2013 - Inclui para atualizar o cursor principal pois quando copiava um produto estava gravado o produto copiado com o código do original
Update crSigPrTar Set CPros = pPro
Update crSigPrArq Set CPros = pPro
lcQuery = [Select * From SigCdPro Where CPros = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarPro]) < 1)
Select CopiarPro
Insert Into crSigCdPro From Memvar
Insert Into crListaPro From Memvar
lcQuery = [Select * From SigPrCpo Where CPros = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarCompo]) < 1)
Select CopiarCompo
	Insert Into crSigPrCpo From Memvar
lcQuery = [Select * From SigCdPrf Where Produtos = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarProF]) < 1)
Select CopiarProF
	Insert Into crSigCdPrf From Memvar
lcQuery = [Select * From SigPrMtz Where CPros = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarMtz]) < 1)
Select CopiarMtz
	Insert Into crSigPrMtz From Memvar
lcQuery = [Select * From SigPrTar Where CPros = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarTar]) < 1)
Select CopiarTar
	Insert Into crSigPrTar From Memvar
lcQuery = [Select * From SigPrArq Where CPros = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarArq]) < 1)
Select CopiarArq
	Insert Into crSigPrArq From Memvar
lcQuery = [Select * From SigCdPft Where CPros = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarProFt]) < 1)
Select CopiarProFt
	Insert Into crSigCdPft From Memvar
lcQuery = [Select * From SigPrTam Where CPros = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarProTam]) < 1)
Select CopiarProTam
	Insert Into crSigPrTam From Memvar
lcQuery = [Select * From SigPrCar Where CPros = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarProCar]) < 1)
Select CopiarProCar
	Insert Into crSigPrCar From Memvar
Select CrSigPrCpo
Update crSigPrCpo ;
Select CrSigSubCp
Update CrSigSubCp ;
Update crSigCdPrf ;
Update crSigPrMtz ;
Update crSigCdPft ;
Update crSigPrTam ;
Update crSigPrCar ;
Update crSigPrTar ;
Update crSigPrArq ;
ThisForm.poDataMgr.Update([crSigCdPft])
	Select &cCompo.
		Select &cCompo.
			Select crSigCdCom
			Select &cCompo.
					Select crSigCdCom
Select &cCompo.
lcQuery = [Select * ] + ;
		    [From SigPrFnc ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalFPro]) < 1)
			Select LocalFPro
			Select LocalFPro
			Select LocalFPro
			Select LocalFPro
Select crSigPrCpo
		lcQuery = [Select CGrus ] + ;
				    [From SigCdGrp ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
			Select *, 999 as DigiMaxs ;
			  From crSigPrCpo ;
			Select crOrdCompos
			Select crSigPrCpo
					Select crSigPrCpo
					Insert Into crOrdCompos From Memvar								
			Select crOrdCompos
		Select Mats From CrSigPrCpo Where Etiqs = 'S' Into Cursor selecao Order by OrdTs
		Select Selecao
				Select CsClass
					Insert Into csClass (Cods ) Values (CrTmp.cClass)
	Select &lcArea
lcQuery = [Select resultado from SigPrSic where cIdChaves = ']+lcChave+[']
If( ThisForm.poDataMgr.SQLExecute(lcQuery,[crSigPrSic]) < 1 )
	lcQuery = [Insert into SigPrSic(cTipos,Mercs,Indicador,ValorCmp,Resultado,cIdChaves) Values ('] + ;
	ThisForm.poDataMgr.SQLExecute(lcQuery)
Select Distinct CGrus, Linguas, TpMontas ;
  From crSigCdPrd ;
Select LocalMontas
			Select crSigCdDic
Select crSigPrCpo
Select crSigPrCpo
	Select crSigPrCpo
			lcQuery = [Select a.cUnis, a.cUnips, b.BPesos ] + ;
					  [From SigCdPro a, SigCdGrp b ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSomaGru') < 1)
				lcSql = [Select Fators From SigCdUni Where Cunis = ']+Iif(CrSomaGru.bPesos=1,CrSomaGru.Cunis,CrSomagru.CUnips)+[']
				=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalUni')
				Select crSigPrCpo
		Select crSigPrCpo
	Select CrSigPrCpo
	SELECT crSigPrCpo
		lcSql = [Select a.*, b.rClis From SigPrFnc a Inner Join SigCdCli b on b.iClis = a.IFors Where cPros = ']+crSigPrCpo.mats+[']
		lcSql = [Select * ] + ;
				    [From SigPrFnc ] + ;
		thisform.Podatamgr.Sqlexecute(lcSql,'CrSigPrFnctmp')
		SELECT CrSigPrFnctmp
			SELECT crSigPrCpo
			SELECT CrSigPrFnctmp
	lcSql = [Select * From SigcdCpo Where grupos = ']+crSigCdPro.cgrus+[']
	ThisForm.Podatamgr.Sqlexecute(lcSql,'crSigCdCpo')
	SELECT crSigcdCpo
		lcQ = [SELECT * from crsigcdcpo where 1=1 ]+lcCheTp + lcCheVal + [ into cursor crCpo]
		SELECT crCpo
	SELECT crSigcdPro
lcQuery = [Select b.chkInstalas ] + ;
			[From SigCdPro a, SigCdGrp b ] + ;
If ThisForm.poDataMgr.SqlExecute(lcQuery,'LocalInstal') < 1
Select crSigPrCpo
		lcQuery = [Select a.PesoMs, b.CfgGerGprs ] + ;
				    [From SigCdPro a, SigCdGrp b ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalProCp]) < 1)
		Select crSigPrCpo
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigOpArq Where fkChaves = '] + Padr(pPro, 30) + ['], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdPro Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrMdl Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdPrf Where Produtos = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrCpo Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrPmi Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrCrr Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdPft Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigSubCp Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdCat Where Cods = '] + Left(pPro,6) + ['], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdSvc Where cCats = '] + Left(pPro,6) + ['], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrFnc Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrTam Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrCar Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigOpArq Where fkChaves = '] + Padr(pPro, 30) + ['], '') < 1)
	If Not ThisForm.poDataMgr.Update('crSigCdPrc')
	If Not ThisForm.poDataMgr.Update('crSigPrMdc')
	If Not ThisForm.poDataMgr.Update('crSigCdPfc')
	If Not ThisForm.poDataMgr.Update('crSigPrMt2')
	If Not ThisForm.poDataMgr.Update('crSigPrCp2')
	If Not ThisForm.poDataMgr.Update('crSigPrCrr')
	If Not ThisForm.poDataMgr.Update('crSigSubC2')
	If Not ThisForm.poDataMgr.Update('crSigPrTa2')
	If Not ThisForm.poDataMgr.Update('crSigPrCa2')
	Delete From crProcurar Where CPros = pPro
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrMdl Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdPrf Where Produtos = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrCpo Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrPmi Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrCrr Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdPft Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigSubCp Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrFtp Where CPros = ?pPro], '') < 1)
	If Not ThisForm.poDataMgr.Update('crSigCdPro')
	If Not ThisForm.poDataMgr.Update('crSigPrMdl')
	If Not ThisForm.poDataMgr.Update('crSigCdPrf')
	If Not ThisForm.poDataMgr.Update('crSigPrMtz')
	If Not ThisForm.poDataMgr.Update('crSigPrCpo')
	If Not ThisForm.poDataMgr.Update('crSigPrPmi')
	If Not ThisForm.poDataMgr.Update('crSigCdPrc')
	If Not ThisForm.poDataMgr.Update('crSigPrMdc')
	If Not ThisForm.poDataMgr.Update('crSigCdPfc')
	If Not ThisForm.poDataMgr.Update('crSigPrMt2')
	If Not ThisForm.poDataMgr.Update('crSigPrCp2')
	If Not ThisForm.poDataMgr.Update('crSigPrCrr')
	If Not ThisForm.poDataMgr.Update('crSigPrFnc')
	If Not ThisForm.poDataMgr.Update('CrSigCdCat')
	If Not ThisForm.poDataMgr.Update('crSigCdSvc')
	If Not ThisForm.poDataMgr.Update('crSigSubCp')
	If Not ThisForm.poDataMgr.Update('crSigSubC2')
	If  Not ThisForm.poDataMgr.Update('crSigCdPft')
	If Not ThisForm.poDataMgr.Update('crSigPrFtp')
	If Not ThisForm.poDataMgr.Update('crSigPrTam')
	If Not ThisForm.poDataMgr.Update('crSigPrCar')
	If Not ThisForm.poDataMgr.Update('crSigPrTa2')
	If Not ThisForm.poDataMgr.Update('crSigPrCa2')
	If Not ThisForm.poDataMgr.Update('crSigPrTar')
	If Not ThisForm.poDataMgr.Update('crSigPrArq')
	Select crListaPro
	If Seek(lcChv, 'crProcurar', 'CPros')
		Select crProcurar
	Select crListaPro
	If Not ThisForm.poDataMgr.Update('crSigCdPro')
	If Not ThisForm.poDataMgr.Update('crSigPrMdl')
	If Not ThisForm.poDataMgr.Update('crSigCdPrf')
	If Not ThisForm.poDataMgr.Update('crSigPrMtz')
	If Not ThisForm.poDataMgr.Update('crSigPrCpo')
	If Not ThisForm.poDataMgr.Update('crSigPrPmi')
	If Not ThisForm.poDataMgr.Update('crSigCdPrc')
	If Not ThisForm.poDataMgr.Update('crSigPrMdc')
	If Not ThisForm.poDataMgr.Update('crSigCdPfc')
	If Not ThisForm.poDataMgr.Update('crSigPrMt2')
	If Not ThisForm.poDataMgr.Update('crSigPrCp2')
	If Not ThisForm.poDataMgr.Update('crSigPrCrr')
	If not ThisForm.podatamgr.Update('crSigPrFnc')
	If Not ThisForm.poDataMgr.Update('CrSigCdCat')
	If Not ThisForm.poDataMgr.Update('crSigCdSvc')
	If Not ThisForm.poDataMgr.Update('crSigCdPft')
	If Not ThisForm.poDataMgr.Update('crSigSubCp')
	If Not ThisForm.poDataMgr.Update('crSigSubC2')
	If Not ThisForm.poDataMgr.Update('crSigPrTam')
	If Not ThisForm.poDataMgr.Update('crSigPrCar')
	If Not ThisForm.poDataMgr.Update('crSigPrTa2')
	If Not ThisForm.poDataMgr.Update('crSigPrCa2')
	If Not ThisForm.poDataMgr.Update('crSigPrTar')
	If Not ThisForm.poDataMgr.Update('crSigPrArq')
Delete From crProcurar Where CPros = pPro
			ThisForm.poDataMgr.SqlExecute([Select * From SigCdPrc Where ] + lcBus + [DPros = ?pDes], [crTmp])
			ThisForm.poDataMgr.SqlExecute([Select * From SigCdPro Where ] + lcBus + [DPros = ?pDes], [crTmp])
					ThisForm.poDataMgr.SqlExecute([Select * From SigCdPrc Where ] + lcBus + [Rtrim(DPros) Like ?pDes], [crTmp])
					ThisForm.poDataMgr.SqlExecute([Select * From SigCdPro Where ] + lcBus + [Rtrim(DPros) Like ?pDes], [crTmp])
			ThisForm.poDataMgr.SqlExecute([Select * From SigCdPrc Where ] + lcBus + [DPro2s = ?pD2s], [crTmp])
			ThisForm.poDataMgr.SqlExecute([Select * From SigCdPro Where ] + lcBus + [DPro2s = ?pD2s], [crTmp])
					ThisForm.poDataMgr.SqlExecute([Select * From SigCdPrc Where ] + lcBus + [Rtrim(DPro2s) Like ?pD2s], [crTmp])
					ThisForm.poDataMgr.SqlExecute([Select * From SigCdPro Where ] + lcBus + [Rtrim(DPro2s) Like ?pD2s], [crTmp])
					ThisForm.poDataMgr.SqlExecute([Select * From SigCdPrc Where Rtrim(Reffs) Like ?pRff], [crTmp])
					ThisForm.poDataMgr.SqlExecute([Select * From SigCdPro Where Rtrim(Reffs) Like ?pRff], [crTmp])
	Select CrTmp
		If Not Seek(CrTmp.Cgrus,'crSigCdGrpFilter','CGrus')
			Delete In CrTmp
	Select * From CrTmp Into Cursor CrTmp2 ReadWrite
		Select crTmp2
				If Not Seek(CrTmp2.Cgrus,'crSigCdGrpFilter','CGrus')
				If Not Seek(lcChv, [crProcurar], [cIdChaves])
				 	Insert Into crProcurar From MemVar
				If Not Seek(crTmp2.Cgrus,'crSigCdGrpFilter','CGrus')
				If Not Seek(lcChv, [crProcurar], [CPros])
				 	Insert Into crProcurar From MemVar
Select crListaPro
Select crListaPro
		Select crProcurar
			If Not Seek(lcChv, 'crListaPro', 'cIdChaves')
			 	Insert Into crListaPro From MemVar
		Select crProcurar
			If Not Seek(lcChv, 'crListaPro', 'CPros')
			 	Insert Into crListaPro From MemVar
Select crListaPro
	lcLstPro = [Select CPros, DPros, DPro2s, CGrus, SGrus, Reffs, Colecoes, ImpEtiqs, Situas, Compos, ] + ;
				 [From SigCdPrc ] + ;
	lcQryPro = [Select * From SigCdPrc Where cIdChaves = ?pIds]
	lcQryCompo = 'Select *, 0 as TpCalcCus, Space(20) as Tipos, 0 as Bloqueio, 0 as chkInstalas From SigPrCp2 Where CPros = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
	lcQrySubCp = 'Select *, 0 as TpCalcCus, Space(20) as Tipos, 0 as Bloqueio From SigSubC2 Where CPros = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
	lcQryModP  = 'Select * From SigPrMdc Where CPros = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
	lcQryProF  = 'Select a.*,b.Descrs From SigCdPfc a Inner Join SigCdGcr b On a.Grupos = b.Codigos Where Produtos = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
	lcQryMtz   = 'Select a.*, b.Locals From SigPrMt2 a Inner Join SigCdPro b On a.CMats = b.CPros Where a.CPros = ?pPro And a.DataAlts = ?pDtA And a.HoraAlts = ?pHrA And a.UsuaAlts = ?pUsA'
		lcQryPro = [Select *, Space(20) as cIdChaves From SigCdPro Where CPros = ?pPro]
			lcLstPro = [Select a.CPros, a.DPros, a.DPro2s, a.CGrus, a.SGrus, a.Reffs, a.Colecoes, a.ImpEtiqs, ] + ;
						 [From SigCdPro a, SigCdPst b ] + ;
			lcLstPro = [Select CPros, DPros, DPro2s, CGrus, SGrus, Reffs, Colecoes, ImpEtiqs, Situas, ] + ;
						 [From SigCdPro ] + ;
		lcQryPro = [Select *, Space(20) as cIdChaves ] + ;
					 [From SigCdPro ] + ;
	lcQryCompo = 'Select *, 0 as TpCalcCus, 0 as Bloqueio, 0 as chkInstalas From SigPrCpo Where CPros = ?pPro Order by OrdTs'
	lcQrySubCp = 'Select *, 0 as TpCalcCus, 0 as Bloqueio From SigSubCp Where CPros = ?pPro Order by OrdTs'	
	lcQryModP  = 'Select * From SigPrMdl  Where CPros = ?pPro'
	lcQryProF  = 'Select a.*,b.Descrs, a.Grupos+Str(a.Ordems,2) as GrpOrdem From SigCdPrf a Inner Join SigCdGcr b On a.Grupos = b.Codigos Where Produtos = ?pPro'
	lcQryMtz   = 'Select a.*, b.Locals From SigPrMtz a Inner Join SigCdPro b On a.CMats = b.CPros Where a.CPros = ?pPro'
lcQryPro2  = 'Select * From SigCdPrc Where CPros = ?pPro'
lcQryComp2 = 'Select * From SigPrCp2 Where CPros = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
lcQrySubC2 = 'Select * From SigSubC2 Where CPros = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
lcQryModP2 = 'Select * From SigPrMdc Where CPros = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
lcQryProF2 = 'Select * From SigCdPfc Where Produtos = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
lcQryMtz2  = 'Select * From SigPrMt2 Where CPros = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
lcQryProMI = 'Select * From SigPrPmi Where CPros = ?pPro'
lcQryPrEmp = 'Select * From SigCdMin Where CPros = ?pPro'
lcQryGru   = 'Select * From SigCdGrp Where CGrus = ?pGru'
lcQrySGru  = 'Select * From SigCdPsg Where CGrus = ?pGru And Codigos = ?pSGr'
lcQryCrPro = 'Select * From SigPrCrr Where CPros = ?pPro'
lcQryProFT = 'Select * From SigCdPft Where CPros = ?pPro'
lcQryFPro  = 'Select a.*, b.rClis From SigPrFnc a Inner Join SigCdCli b on b.iClis = a.IFors Where cPros = ?pPro'
lcQryGccr  = 'Select * From SigCdGcr'
lcQryParam = 'Select * From SigCdPam'
lcQryMTal  = 'Select * From SigCdMtl'
lcQryPFtp  = 'Select * From SigPrFtp'
lcQryProTp = 'Select * from SigProTp Where Cpros = ?pPro'
lcQryCmv = 'Select * from SigCdCmv where Cpros = ?pPro'
lcQryPrTam = [Select a.*, b.Descs from SigPrTam a Inner Join SigCdTam b On a.CodTams = b.Cods where a.Cpros = ?pPro]
lcQryPrCar = [Select a.*, b.Descrs from SigPrCar a Inner Join SigCrRap b On a.Codigos = b.Codigos Where a.CPros = ?pPro]
lcQryPrTa2 = [Select a.*, b.Descs from SigPrTa2 a Inner Join SigCdTam b On a.CodTams = b.Cods where a.Cpros = ?pPro And a.DataAlts = ?pDtA And a.HoraAlts = ?pHrA And a.UsuaAlts = ?pUsA]
lcQryPrCa2 = [Select a.*, b.Descrs from SigPrCa2 a Inner Join SigCrRap b On a.Codigos = b.Codigos Where a.CPros = ?pPro And a.DataAlts = ?pDtA And a.HoraAlts = ?pHrA And a.UsuaAlts = ?pUsA]
lcQryPrTar = [Select * From SigPrTar Where CPros = ?pPro]
lcQryPrArq = [Select * From SigPrArq Where CPros = ?pPro]
		Select LocalGru
lcQuery = [select cgrus,codigos, cgrucods  from sigcdpsg]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSubGrupo]) < 1)
Select crSubGrupo
lcQuery = [Select a.Tipos, a.Custos, b.CGrus ] + ;
		    [From SigCdTpc a, SigCdCom b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdCom]) < 1)
Select crSigCdCom
lcQuery = [Select a.Cods, a.Descs, b.CGrus ] + ;
			[From SigCdCls a ] + ;
			[Left Join SigCdCla b On a.Cods = b.Cods]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdCls]) < 1)
Select crSigCdCls
Update crSigCdCls Set CGrus = [] Where IsNull(CGrus )
lcQuery = [Select * From SigCdPrd]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdPrd]) < 1)
Select crSigCdPrd
lcQuery = [Select Tipos ] + ;
		    [From SigCdTpc ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdTpc]) < 1)
Select crSigCdTpc
lcSql = [Select Count(1) as Qt From SigCdUni WherE cEstos = '3' ]
If (ThisForm.poDataMgr.SqlExecute(lcSql, 'CstmpUni') < 1)
lcSql = [Select * From SigCdPac]
If (ThisForm.poDataMgr.SqlExecute(lcSql, 'CrSigCdPac') < 1)
lcQuery = [Select * From SigCdCat]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CsProCat]) < 1)
Select CsProCat
lcQuery = [Select * From SigCdSvc ]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CsProSer]) < 1)
Select CsProSer
Select crSigCdGcr
lStrQuery = [Select Distinct a.CPros, a.DPros, a.Locals, a.CGrus, a.MontaDescs, b.MtPrimas, Space(20) as Tipos, 1 as Custos, b.CfgGerGprs, a.Situas, a.Reffs ] + ;
			  [From SigCdPro a, SigCdGrp b ] + ;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrMtPrimaC') < 1
Select * From CrMtPrimaC Where MtPrimas = 4 Into Cursor crMatrizes ReadWrite
Select crMatrizes
Select * From CrMtPrimaC Where MtPrimas In (1, 2) And Iif(Int(Val(Substr(CfgGerGprs, 38, 1))) = 1,Situas = 1,.t.) Into Cursor crMtPrima ReadWrite
Select CrMtPrima
lcQuery = [Select Distinct a.Conjunts From SigCdPro a Inner Join SigCdGrp b On a.CGrus = b.CGrus Where b.MtPrimas = 3 And a.Conjunts <> '' Order By a.Conjunts]
If ThisForm.poDataMgr.SqlExecute(lcQuery,'CrConjunto') < 1
Select crConjunto
lStrQuery = [Select Tipos From SigCdCom]			  
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'LocalCdCom') < 1
	Select * From CrMtPrima Into Cursor CrMtPrimaT ReadWrite
	lStrQuery = [Select Distinct a.CPros, a.DPros, a.CGrus, a.MontaDescs, b.MtPrimas, c.Tipos, d.Custos, a.Reffs ] + ;
				  [From SigCdPro a, SigCdGrp b, SigCdCom c, SigCdTpc d ] + ;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrMtPrimaT') < 1
	Select CrMtPrimaT
lcQuery = [Select CGrus, DGrus, Mercs, Margems, 'S' as Apagar From SigCdGrp]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdGrpFilter') < 1)
Select crSigCdGrpFilter
		If Not Empty(lcBus) And Seek(lcBus, 'crSigCdGrpFilter', 'CGrus')
Delete From crSigCdGrpFilter Where Apagar = 'S'
Select crSigCdMtl
		Insert Into TmpMtal (Codigos, Descs) Values (crSigCdMtl.Codigos, crSigCdMtl.Descs)
		Insert Into TmpTeor (Codigos, Descs) Values (crSigCdMtl.Codigos, crSigCdMtl.Descs)
Select * From crListaPro Into Cursor crProcurar ReadWrite
		Select crListaPro
			Select crListaPro
	Select crListaPro
		Select crListaPro
				Select crTmp
				Insert Into crProcurar From Memvar
lcQuery = [Select Distinct a.Cods, a.Cond1s, a.Cond2s, a.Cond3s, a.Cond4s ] + ;
			[From SigCdPst a ] + ;
		   		[Select Distinct b.Resumos ] + ;
		   		  [From SigSyCpo b ] + ;
		   		[Select Distinct b.Resumos ] + ;
		   		  [From SigSyCpo b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdPst]) < 1)
lcQuery = [Select Str(Len(Ltrim(Rtrim(a.Expressao))), 10) as COrdems, a.Expressao, a.Traducao ] + ;
			[From SigCdDic a ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdDic]) < 1)
	lcQuery = [Select Left(CodCads, 10) as CodCads, DesCads ] + ;
				[From SigCdCad ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crTarefas]) < 1)
	Select crTarefas
	lcSql = [Select FigJpgs From SigCdPro where Cpros = ']+CrListaPro.Cpros+[']
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalPro') > 0
Select crListaPro
		Select crListaPro
		Select crSigCdPro
SELECT *, pkchaves as cidChaves from crSigPrFtp where cpros = pPro1 into cursor crPrFtp READWRITE
Select crListaPro
	lcQuery = [Update SigCdPro Set DPros = ?pcDpro Where CPros = '] + crSigCdPro.CPros + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Select AltProds ] + ;
					[From SigCdCol ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crBusCol]) < 1)
		Select crBusCol
lcSql = [Select TpCalcPs,PesMts,MarkAplics,MoeMrkaps,CodProds From SigCdGrp Where Cgrus = ']+pGru+[']
ThisForm.poDataMgr.SqlExecute(lcSql, [crTmpGru])
	Select crSigCdPro
				Select crSigCdPrd
	Select crSigCdGrp
	Select crSigCdPro
		Select crSigPrCpo
		lcQuery = [Select * ] + ;
				    [From SigCdCli ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
	Select crSigCdPrf
	=Seek(crSigCdPro.Metals, 'TmpMtal', 'Codigos')
	=Seek(crSigCdPro.Teors,  'TmpTeor', 'Codigos')
	Select crSigPrCpo
	Update crSigPrCpo Set Etiqs = [N] Where Not Etiqs = [S]
	Select crSigSubCp
	Update crSigSubCp Set Etiqs = [N] Where Not Etiqs = [S]
	Select crSigPrMtz
			Insert Into crSigPrMtz (CPros, cIdChaves) Values (crSigCdPro.CPros, fUniqueIds())
Select crSigCdPro
		lStrQuery = [Select Top 1 UsuaAlts ] + ;
					  [From SigCdPrc ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpUltimo') < 1)
	Select crSigCdPro
	Insert Into crSigCdPrc From MemVar
	Select crSigPrCpo
		Select crSigPrCpo
		Insert Into crSigPrCp2 From MemVar
	Select crSigSubCp
		Select crSigSubCp
		Insert Into crSigSubC2 From MemVar
	Select crSigCdPrf
		Select crSigCdPrf
		Insert Into crSigCdPfc From MemVar
	Select crSigPrMtz
		Select crSigPrMtz
		Insert Into crSigPrMt2 From MemVar
	Select crSigPrMdl
		Select crSigPrMdl
		Insert Into crSigPrMdc From MemVar
	Select crSigPrTam
		Select crSigPrTam
		Insert Into crSigPrTa2 From MemVar
	Select crSigPrCar
		Select crSigPrCar
		Insert Into crSigPrCa2 From MemVar
		Insert Into crSigPrCrr (CPros, cIdChaves) Values (crSigCdPro.CPros, fUniqueIds())
=Seek(pGru, 'crSigCdGrpFilter', 'CGrus')
Select crSigCdPro
		lcQuery = [Select a.Linhas, b.Descs ] + ;
				    [From SigCdGpr a, SigCdLin b ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalLinha]) < 1)
lnOldSel = Select()
		Select crEstoque 
		lcQuery=[select a.Emps, a.Grupos, a.Estos, a.Sqtds, a.Cpros, c.Dpros, a.codtams, a.codcors ] + ;
				[From sigmvest a ] + ;
				[Join SigCdEmp b on a.emps = b.cemps ] + ;
				[Join SigCdPro c on a.Cpros = c.Cpros ] + ;
		If ThisForm.podatamgr.SqlExecute(lcQuery,[crTmpEst]) < 1
		Select crTmpEst
			Select crEstoque
		Select crEstoque
Select(lnOldSel)
		Select crSigCdTpc
		Select crSigPrCpo
				Select crSigCdCom
		Select crSigSubCp
				Select crSigCdCom
	Select crSigCdPro
	Select crSigCdPro
	lcQuery = [Select DataAlts, UsuaAlts ] +;
				[From SigCdPrc ] +;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crBusPro2]) < 1)
	Select crBusPro2
	lcQuery = [Select e.Sqtds ] + ;
				[From SigMvEst e ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crBusPro2]) < 1)
	Select crBusPro2
		Select * ;
		  From crSigCdCls ;
Select crSigCdPro
Select crSigPrCpo
Select crSigSubCp
Select crSigCdPrf
	lcQuery = [Select CPros ] + ;
			    [From SigCdPro ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
Delete From crSigPrMtz Where Qtds <= 0 Or Empty(CMats)
Delete From crSigPrTar Where IsEmpty(DtInis) Or Empty(Tarefas)
Delete From crSigPrArq Where Empty(Arquivos)
		lcQuery = [Select CPros From SigCdPro Where Reffs = '] + crSigcdpro.reffs + ['] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
		Select LocalPro
		lcQuery = [Select CPros, Cunis, CuniPs ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro') < 1)
		lcQuery = [Select CPros, DPros ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro') < 1)
	Select crSigPrCpo
				Select CrMtPrima
			  		Select crSigPrCpo
				Select CrMtPrima
			  		Select crSigPrCpo
		Select crSigPrCpo
				Select Produtos ;
				  From crSigCdPrf ;
		Select cpros,Mats from CrSigPrCpo Where cats = ' ' group by cpros,mats having sum(1) > 1 ;
		Select CsDuplCompo
	Select crSigPrCpo
			Delete
			lcQuery = [Select CGrus ] + ;
					    [From SigCdGrp ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
				Select *, 999 as DigiMaxs ;
				  From crSigPrCpo ;
				Select crOrdCompos
				Select crSigPrCpo
						Select crSigPrCpo
						Insert Into crOrdCompos From Memvar								
				Select crOrdCompos
			Select Mats From CrSigPrCpo Where Etiqs = 'S' Into Cursor selecao Order by OrdTs
			Select Selecao
					Select CsClass
						Insert Into csClass (Cods ) Values (CrTmp.cClass)
					lcSql = [Select * From SigPrFti Where Cods = ']+MarkVd+[']
					ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtio')
	Select LocalProCo
		Select LocalGru
		Select a.Mats,a.Cgrus,b.Mercs From CrSigPrCpo a, LocalGru b Where a.Cgrus = b.cgrus ;
		Select LocalProCo
					Select CsComposicao
						Select CsComposicao
						Select CsComposicao
						Select CsComposicao
						Select CsComposicao
					Select CsComposicao
					Select crSigCdPrd
	Select crSigCdPro
		Select crSigCdPrf
	Select crSigCdPro
	lcSQLCmd = 'Delete From SigPrCrr Where CPros = ?pPro'
	If (ThisForm.poDataMgr.SQLExecute(lcSQLCmd, '') < 1)
	lcQrySGru  = [Select * From SigCdPsg Where CGrus = ']+oPag.PgDados.Getcgru.Value+[' Order By nFaixaFins]
	If (ThisForm.poDatamgr.SqlExecute(lcQrySGru,'csSigCdPsg') < 1)
	Select csSigCdPsg
			Select crSigCdPro
			Select crSigCdPro
	Select CrSigPrFtp
	Select CrSigCdCat
	Select CrSigCdSvc
			Insert Into CrSigCdCat (Cods,Descs,Desc2s,CidChaves) Values ;
			Insert Into CrSigCdSvc (cCats,cMoeds,Bases,GruFins,CidChaves,coefs,coefretrs) Values ;
			lcQuery = [Select * from SigCdSvc where cCats = '] + Left(crSigCdPro.CPros,6) + [']
			ThisForm.poDataMgr.SqlExecute(lcQuery,[TmpServ])
			Select TmpServ
				Insert into CrSigCdSvc from MEMVAR
	SELECT csGrade
			Insert Into CrSigPrFtp (cGrus, cods, coefs, cpros, PkChaves) Values ;
	lcQuery = [Delete From SigPrPrt Where CPros = '] + CrSigCdPro.Cpros + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		lcQuery = [Select Emps, Cpros, Sum(Sqtds) as Qtds ] + ;
					[From SigMvEst ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'dbImp') < 1)
		Select dbImp
						lcSql = [Select Str(Cbars,14) as Cpros, Empos as EmpS, Qtds From SigOpEtq ]+;
						ThisForm.Podatamgr.Sqlexecute(lcsql,'DbImp')
						Select dbImp
							Insert Into dbImpressao (Cpros, Qtds, Empresa) Values (dbImp.Cpros, dbImp.Qtds, dbImp.Emps)
							Insert Into dbImpressao (Cpros, Qtds, Empresa) Values (pPro, _QtEtiq, _Empr)
							Select dbImp
								Insert Into dbImpressao (Cpros, Qtds, Empresa) Values (pPro, dbImp.Qtds, dbImp.Emps)
						Select dbImpressao
			Select crUni
						Select crSigCdPro
						Select crSigCdPro
	Select crSigCdPro
	Select crSigCdPro
	Select crSigCdPrf
	Delete From crSigCdPrf Where Produtos=ThisForm.CodAnt
	Select crSigCdPro
			Delete From crSigPrMdl Where CPros = This.Parent.Parent.pgframeDados.pgDados.getCpro.Value
			Delete From crSigPrMdl ;
		Update crSigCdPro ;
		Update crSigPrMdl ;
		Update crSigCdPrf ;
		Update crSigPrMtz ;
		Update crSigPrCpo ;
		Update crSigPrPmi ;
		Update crSigPrTar ;
		Update crSigPrArq ;
	Update crSigCdPrc ;
	Update crSigPrMdc ;
	Update crSigCdPfc ;
	Update crSigPrMt2 ;
	Update crSigPrCp2 ;
	Update crSigSubC2 ;
	Delete From crSigPrCrr ;
	Update crSigPrCrr Set Cidchaves = fUniqueIds() Where IsEmpty(Cidchaves)
	Update crSigPrTa2 ;
	Update crSigPrCa2 ;
		lStrQuery = [Select Distinct a.CPros, a.DPros, a.CGrus, a.MontaDescs, b.MtPrimas, b.CfgGerGprs, a.Situas, a.Reffs ] + ;
					  [From SigCdPro a, SigCdGrp b ] + ;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'LocalMtP') < 1
		Select LocalMtP
			Select LocalMtP
			Select crMtPrima
				Insert Into crMtPrima From Memvar
		Select crConjunto
		If !Seek(pConj,[crConjunto],[Conjunts])
			Insert Into crConjunto(Conjunts) Values (pConj)
			Delete From crMtPrima where CPros = Padr(pPro, 14)
		lcQuery = [Select Conjunts From SigCdPro Where Conjunts = '] + pConj + [']
		If ThisForm.poDataMgr.SqlExecute(lcQuery,'LocalConj') < 1
		Select LocalConj
			Delete From crConjunto Where Conjunts = pConj
	Select crSigCdPrf
	Select crSigCdPro
	Select crSigCdPro
	Select crSigCdPro
Select crSigCdPro
SELECT *, pkchaves as cidChaves from crSigPrFtp where cpros = pPro1 into cursor crPrFtp READWRITE
lStrQuery = [Select CGrus,CodProds,IdeCPros,Mercs From SigCdGrp Where CGrus = ']+lcCGrus+[' ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpGruPro') < 1
Select TmpGruPro
Select crListaPro
lStrQuery = [Select CGrus, Mercs, CodProds, IdeCPros, CfgGerGprs From SigCdGrp Where CGrus = '] + this.Parent.getNewCGrus.Value + [']
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpGruPro') < 1
Select TmpGruPro
	lcQuery = [Select CPros From SigCdPro Where Reffs = '] + ALLTRIM(lcNewRefs) + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crTmp]) < 1)
	Select crTmp
	If (ThisForm.poDataMgr.SqlExecute([Select IdeCpros, iFors From SigCdPro Where Cpros = '] + ALLTRIM(lcLocPros) + ['], [crTmpIdPro]) < 1)
Select crSigPrCpo
	Select crTmp
		Select crTmp
		Insert Into crSigPrCpo From Memvar
Select crSigCdPrf
	Select crTmp
		Select crTmp
		Insert Into crSigCdPrf From Memvar
Select crSigPrMtz 
	Select crTmp
		Select crTmp
			Insert Into crSigPrMtz From Memvar
Select CrSigCdPft
	Select crTmp
		Select crTmp
		Insert Into crSigCdPft From Memvar
Select crSigPrTar
	Select crTmp
		Select crTmp
		Insert Into crSigPrTar From Memvar
Select crSigPrCar
	Select crTmp
		Select crTmp
		Insert Into crSigPrCar From Memvar
Select crSigPrArq
	Select crTmp
		Select crTmp
		Insert Into crSigPrArq From Memvar
lcQuery = [Select * ] + ;
		    [From SigCdPro ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCPros]) < 1)
Select LocalCPros
Insert Into crSigCdPro From Memvar
Insert Into crListaPro From Memvar
Select crSigCdPro
ThisForm.poDataMgr.Update('crSigCdPft')
Select crListaPro
lStrQuery = [Select CGrus,CodProds,IdeCPros From SigCdGrp Where CGrus = ']+lcCGrus+[' ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpGruPro') < 1
Select TmpGruPro
		Select TmpGruPro
	lStrQuery = [Select CGrus, Mercs, CodProds, IdeCPros From SigCdGrp Where CGrus = '] + lcCGrus + [']
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpGruPro') < 1
	Select TmpGruPro
			Select crSigCdGpr1
		lcQuery = [Select CPros ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
		Select LocalPro
			Select LocalPro
		lcQuery = [Select CPros ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
		Select LocalPro
			Select LocalPro
	If Not Seek(This.Value, 'crSigCdGrpFilter', 'CGrus')
	If Not Seek(This.Value, 'crSigCdGrpFilter', 'DGrus')
Select crSigCdPro
	Select crSigCdPrf
	Select crSigCdPro
Select TmpAux
Select crSigCdPrf
		Insert Into TmpAux (Ordems, Grupo, Descr) Values (crSigCdPrf.Ordems, crTmp.Codigos, crTmp.Descrs)
Select crSigCdPro
		Select crSigCdPro
		Select crSigCdPro
			Select crSigPrCpo
			Update crSigPrCpo ;
			Select crSigSubCp
			Update crSigSubCp ;
			Update crSigCdPrf ;
			Insert Into crSigPrCrr (CPros, cIdChaves) Values (crSigCdPro.CPros, fUniqueIds())
	Select crSigCdPro
			Select crSigCdPro
				Select crSigCdPro
					Select crSigPrCpo
					Update crSigPrCpo ;
					Select crSigSubCp
					Update crSigSubCp ;
				Select crSigCdPro
			Select crSigCdPro
		Select crSigCdPro
			Select crSigCdPro
				Select crSigCdPro
					Select crSigPrCpo
					Update crSigPrCpo ;
					Select crSigSubCp
					Update crSigSubCp ;
				Select crSigCdPro
			Select crSigCdPro
		Select crSigCdPro
		lcQuery = [Select CPros ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
		Select LocalPro
			Select LocalPro
			Select crSigCdPrf
			lcSql = [Select a.*, b.descrs from SigCdLnf a, SigCdGcr b where a.linhas = ']+this.Value+[' ]+;
			If ThisForm.poDataMgr.sqlexecute(lcsql, 'crTmp') > 0
				Select crTmp
					Select crSigCdPrf
						Insert Into crSigCdPrf (Produtos, Grupos, Obs, UniPrdts, MatPrdts, cIdChaves, Descrs, Ordem2) ;
			Select crSigCdPrf
			lcSql = [Select a.*, b.descrs from SigCdLnf a, SigCdGcr b where a.linhas = ']+This.Parent.GetLin.Value+[' ]+;
			If ThisForm.poDataMgr.sqlexecute(lcsql, 'crTmp') > 0
				Select crTmp
					Select crSigCdPrf
						Insert Into crSigCdPrf (Produtos, Grupos, Obs, UniPrdts, MatPrdts, cIdChaves, Descrs, Ordem2) ;
	If Not Seek(This.Value, 'crSigCdGrpFilter', 'CGrus')
Select crSigCdPro
		lcSql = [Select cEstos From SigCdUni Where cunis = '] + crSigCdPro.CUnis+[']
		ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
						Select crSigCdPrd
				Select crSigPrCpo
				Update crSigPrCpo ;
				Select crSigSubCp
				Update crSigSubCp ;
			Select crSigCdPro
	Select crSigCdPro
	Select crSigCdPro
	If Not Seek(This.Value, 'crSigCdGrpFilter', 'DGrus')
Select crSigCdPro
						Select crSigCdPrd
				Select crSigPrCpo
				Update crSigPrCpo ;
				Select crSigSubCp
				Update crSigSubCp ;
			Select crSigCdPro
Select crSigCdPro
		Select crSigCdPro
			Delete File (lcFigura)
Select crSigCdPro
	.Column1.ControlSource  = 'crSigCdMin.Emps'
	.Column2.ControlSource  = 'crSigCdMin.QMins'
	lcSql = [Select cEstos From SigCdUni Where cunis = ']+CrSigCdPro.cUnis+[']
	ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
	Select * ;
	  From crSigCdCls ;
	Select LocalClas
	Select LocalClas
		lcQuery = [Select a.CPros ] + ;
					[From SigCdMin a ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca]) < 1)
Select crSigCdPro
		Select crSigCdPro
			Delete File (lcFigura)
	Select crConjunto
	If !Seek(lcConjunto,[crConjunto],[Conjunts])
Select crSigCdPro
		Select crSigCdPro
			Delete File (lcFigura)
	Select crSigCdPro
	Select crSigPrCpo
		Insert Into crSigPrCpo (Cpros, DtMovs, cIdChaves, TpCalcCus) Values (crSigCdPro.Cpros, DateTime(), fUniqueIds(), 1)
	Select crSigPrCpo
		Delete
Select crSigPrCpo
Select crSigPrCpo
		Select crSigPrCpo
			lcQuery = [Select a.cUnis, a.cUnips, b.BPesos, A.Moevs, b.chkInstalas, b.AtuComps ] + ;
						[From SigCdPro a, SigCdGrp b ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSomaGru') < 1)
				lcSql = [Select Fators From SigCdUni Where Cunis = ']+Iif(CrSomaGru.bPesos=1,CrSomaGru.Cunis,CrSomagru.CUnips)+[']
				=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalUni')
				Select crSigPrCpo
			Select crSigPrCpo
		Select CrSigPrCpo
Select CrSigCdPro
Select crSigPrCpo
Select crSigPrCpo
Select CrSigPrCpo
lnOldSel = Select()
Select(lnOldSel)
		Select &lcArq.
		Select crSigCdPro
			If Not Seek(Padr(This.Value, 14), lcArq, [CPros]) And Not Seek(This.Value, lcArq, [Reffs])
				If Not Seek(Padr(This.Value, 14), lcArq, [CPros]) And Not Seek(This.Value, lcArq, [Reffs])
							If Not Seek(Padr(This.Value, 14), lcArq, [CPros])
					Select &lcArq.
					lStrQuery = [Select * ] + ;
								[From SigCdPro ] + ;
					If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrListaRemota') < 1
						Select &lcArq.
							Select CrSigCdPrf
						Select CrSigPrCpo
				Select &lcArq.
	Select &lcArq.
	Select crSigPrCpo
		Select &lcArq.
		Select crSigCdPro
			Select &lcArq.
			If Not Seek(Padr(This.Value, 65), lcArq, [DPros])
					Select &lcArq.
					lStrQuery = [Select * ] + ;
								  [From SigCdPro ] + ;
					If ThisForm.poDataMgr.SqlExecute(lStrQuery, [crListaRemota]) < 1
						Select &lcArq.
							Select CrSigCdPrf
						Select CrSigPrCpo
				Select &lcArq.
	Select &lcArq.
	Select crSigPrCpo
	Select crSigPrCpo
	lcQuery = [Select b.pCustVens ] + ;
			    [From SigCdPro a, SigCdGrp b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
	Select crSigPrCpo	
	lcQuery = [Select b.pCustVens,b.Fators,qtequalps, a.PesoMs, a.cGrus ] + ;
			    [From SigCdPro a, SigCdUni b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
	Select crSigPrCpo
	Select crSigPrCpo
	Select crSigPrCpo	
	lcQuery = [Select b.pCustVens,b.Fators, a.PesoMs, a.cGrus ] + ;
			    [From SigCdPro a, SigCdUni b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
	Select crSigPrCpo
	lcSql = [Select cEstos From SigCdUni Where cunis = ']+CrSigPrCpo.UniCompos+[']
	ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
	Select crMatrizes
	If Not Seek(Padr(This.Value, 14), [crMatrizes], [CPros])
	Select CrSigPrCpo
	lcSql = [Select Cods, Descs, Moedas, Acrescs From SigPrFti Where Tipos <> 1]
	ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtio')
	Select TmpFtio
	If Not Seek(This.Value,'TmpFtio','Cods')
	lcSql = [Select * From SigPrFti Where Cods = ']+MarkVd+[']
	ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtio')
	lcSql = [Select Cods, Descs, Moedas, Valors, TpFtios From SigPrFti Where Tipos = 1]
	ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtio')
	Select TmpFtio
	If Not Seek(This.Value,'TmpFtio','Cods')
		Select &lcArq.
		Select crSigCdPro
			If Not Seek(Padr(This.Value, 14), lcArq, [CPros])
					Select &lcArq.
					lStrQuery = [Select * ] + ;
								[From SigCdPro ] + ;
					If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrListaRemota') < 1
						Select &lcArq.
						Select CrSigSubCp
				Select &lcArq.
	Select &lcArq.
	Select crSigSubCp
		Select &lcArq.
		Select crSigCdPro
			Select &lcArq.
			If Not Seek(Padr(This.Value, 40), lcArq, [DPros])
					Select &lcArq.
					lStrQuery = [Select * ] + ;
								  [From SigCdPro ] + ;
					If ThisForm.poDataMgr.SqlExecute(lStrQuery, [crListaRemota]) < 1
						Select &lcArq.
						Select CrSigSubCp
				Select &lcArq.
	Select &lcArq.
	Select crSigSubCp
	lcQuery = [Select b.pCustVens ] + ;
			    [From SigCdPro a, SigCdGrp b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
	Select crSigSubCp	
	Select crSigSubCp
	lcQuery = [Select b.pCustVens,b.Fators,qtequalps ] + ;
			    [From SigCdPro a, SigCduni b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
	Select CrSigSubCp
	Select crSigSubCp	
	Select crSigSubCp
	lcSql = [Select cEstos From SigCduni Where cunis = ']+crSIGPRCPO.UniCompos+[']
	ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
	lcQuery = [Select b.pCustVens,b.Fators ] + ;
			    [From SigCdPro a, SigCduni b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
	Select CrSigSubCp
	Select crMatrizes
	If Not Seek(Padr(This.Value, 14), [crMatrizes], [CPros])
	Select crSIGPRCPO
	Select crSigSubCp
		Insert Into crSigSubCp (Cpros, DtMovs, cIdChaves, TpCalcCus, matsubs) Values (crSigCdPro.Cpros, DateTime(), fUniqueIds(), 1, crSIGPRCPO.mats)
	Select crSigSubCp
		Delete
	Select TmpTeor
	If Not Seek(This.Value, 'TmpTeor', 'Codigos')
	Select TmpMTal
	If Not Seek(This.Value, 'TmpMTal', 'Codigos')
Select crSigCdPrf
			Delete File (lcFigura)
=Seek(CrSigCdPrf.Grupos,'CrSigCdGcr')
	Select crSigCdPrf
	Select crSigCdPrf
Select crSigCdPrf
	lcSql = [Select UniPrdts From SigCdUpd Where Codigos = ']+crSigCdPrf.Grupos+[']
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigCdUpd')
	Select CrSigCdUpd
	If Seek(This.Value,'crSigCdUpd','UniPrdts')
Select crSigCdPrf
Select crSigCdPrf
	Select CrSigCdPrf
	Select CrSigPrCpo
	Select CrSigCdPrf
Select CrSigCdPrf
Insert Into crSigCdPrf (Produtos, Ordems, Ordem2, cIdChaves) ;
Select crSigCdPrf
Delete
		Select CrSigCdPrf
		Select CrSigPrCpo
		Select CrSigCdPrf
Select crSigCdPrf
Select crSigCdPrf
Select crSigCdPrf
Insert Into crSigCdPrf (Produtos, Ordems, Ordem2, cIdChaves) ;
Insert Into csCabecalho From Memvar
Select crSigCdPrf
	Select f.produtos, f.ordems, f.grupos, f.figProcs, f.Descrs, f.Ordem2, ;
	  From crSigCdPrf f ;
	Select f.produtos, f.ordems, f.grupos, f.figProcs, f.Descrs, f.Ordem2, ;
	From crSigCdPrf f ;
Select CsDetalhes
Update CsDetalhes Set Ordem2 = Recno()
Update CsDetalhes Set Ident  = 'TP'+PADL(allt(str(Ordem2)),3,'0') 
Select CrBranco
Append Memo Branco From (lcFigJpg) Overwrite
Select CsDetalhes
lcQuery = [Select conquilhas From SigCdCnq group by conquilhas]
IF (ThisForm.poDataMgr.SqlExecute(lcQuery, [crLocal])) >0
		Select crLocal
		If Not Seek(Padr(This.Value, 10), [crLocal], [con])
Select crSigPrMtz
	Insert Into crSigPrMtz (CPros, cIdChaves) Values (crSigCdPro.CPros, fUniqueIds())
Select crSigPrMtz
	Delete In crSigPrMtz
	Insert Into crSigPrMtz (CPros, cIdChaves) Values (crSigCdPro.CPros, fUniqueIds())
	lcQuery = [Select * ] + ;
			    [From SigCdPro ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalImgPro]) < 1)
	Select crMatrizes
	If Not Seek(Padr(This.Value, 14), [crMatrizes], [CPros])
Select crSigCdPrf
			Delete File (lcFigura)
			lcQuery = [Select * ] + ;
					    [From SigCdPro ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrListaRemota') < 1)
			lcQuery = [Select * ] + ;
					    [From SigCdPro ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrListaRemota') < 1)
Select CrSigCdPrf
	Select crSigCdPrf
	Select crSigPrCpo
	Select crSigCdPrf
	Select crSigPrCpo
Select crSigPrCpo
		Select &lcArq.
		Select crSigCdPro
			If Not Seek(Padr(This.Value, 14), lcArq, [CPros])
					Select &lcArq.
					lStrQuery = [Select * ] + ;
								[From SigCdPro ] + ;
					If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrListaRemota') < 1
						Select &lcArq.
						Select CrSigPrCpo
				Select &lcArq.
	Select &lcArq.
	Select crSigPrCpo
		Select &lcArq.
		Select crSigCdPro
			Select &lcArq.
			If Not Seek(Padr(This.Value, 40), lcArq, [DPros])
					Select &lcArq.
					lStrQuery = [Select * ] + ;
								  [From SigCdPro ] + ;
					If ThisForm.poDataMgr.SqlExecute(lStrQuery, [crListaRemota]) < 1
						Select &lcArq.
						Select CrSigPrCpo
				Select &lcArq.
	Select &lcArq.
	Select crSigPrCpo
	Select crSigPrCpo
	Select crSigPrCpo
	lcSql = [Select cEstos From SigCdUni Where cunis = ']+CrSigPrCpo.UniCompos+[']
	ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
	Select crSigPrCpo
		Insert Into crSigPrCpo (Cpros, DtMovs, cIdChaves, Tipos) Values (crSigCdPro.Cpros, DateTime(), fUniqueIds(), lcTip)
	Select crSigPrCpo
		Delete
	Select crTarefas
Select crSigPrTar
Select crSigPrTar
Insert Into crSigPrTar (CPros, pkChaves, DtInis, Usuars) ;
	Insert Into crSigPrArq (CPros, pkChaves, Arquivos) Values (crSigCdPro.CPros, fUniqueIds(), Upper(lcArq))
	Delete In crSigPrArq

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (12507 linhas total):

*-- Linhas 331 a 349:
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

*-- Linhas 911 a 945:
911:             par_oPage.grd_4c_Lista.HighlightBackColor = RGB(255,255,255)
912:             par_oPage.grd_4c_Lista.HighlightForeColor = RGB(15,41,104)
913:             par_oPage.grd_4c_Lista.HighlightStyle   = 2
914:             par_oPage.grd_4c_Lista.DeleteMark        = .F.
915:             par_oPage.grd_4c_Lista.RecordMark        = .F.
916:             par_oPage.grd_4c_Lista.RowHeight         = 16
917:             par_oPage.grd_4c_Lista.ScrollBars        = 2
918:             par_oPage.grd_4c_Lista.Themes            = .F.
919:             par_oPage.grd_4c_Lista.Visible           = .T.
920: 
921:             *-- CheckBox na Column7 ANTES de RecordSource
922:             par_oPage.grd_4c_Lista.Column7.AddObject("Check1", "CheckBox")
923:             par_oPage.grd_4c_Lista.Column7.CurrentControl = "Check1"
924:             par_oPage.grd_4c_Lista.Column7.Check1.Themes  = .F.
925:             par_oPage.grd_4c_Lista.Column7.Check1.Value   = 0
926: 
927:             *-- RecordSource FORA de WITH (critico: evita "Unknown member COLUMN1")
928:             par_oPage.grd_4c_Lista.RecordSource = "cursor_4c_Lista"
929: 
930:             *-- Configurar colunas APOS RecordSource (evita reset de headers/ControlSource)
931:             THIS.FormatarGridLista(par_oPage.grd_4c_Lista)
932: 
933:         CATCH TO loc_oErro
934:             MsgErro(loc_oErro.Message, "Erro ao configurar Page1")
935:         ENDTRY
936:     ENDPROC
937: 
938:     *--------------------------------------------------------------------------
939:     PROTECTED PROCEDURE ConfigurarPage2(par_oPage)
940:         LOCAL loc_oContainer
941:         TRY
942:             *-- Botoes de acao (Grupo_Salva no legado) - Top = 9+29 = 38
943:             par_oPage.AddObject("cnt_4c_BotoesAcao", "Container")
944:             WITH par_oPage.cnt_4c_BotoesAcao
945:                 .Top         = 38

*-- Linhas 1046 a 1107:
1046: 
1047:             *-- Column1: Produto (CPros)
1048:             loc_oGrid.Column1.Header1.Caption  = "Produto"
1049:             loc_oGrid.Column1.ControlSource    = "cursor_4c_Lista.CPros"
1050:             loc_oGrid.Column1.Width            = 80
1051:             loc_oGrid.Column1.ReadOnly         = .T.
1052:             loc_oGrid.Column1.Header1.FontBold = .T.
1053: 
1054:             *-- Column2: Descricao (DPros)
1055:             loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
1056:             loc_oGrid.Column2.ControlSource    = "cursor_4c_Lista.DPros"
1057:             loc_oGrid.Column2.Width            = 250
1058:             loc_oGrid.Column2.ReadOnly         = .T.
1059:             loc_oGrid.Column2.Header1.FontBold = .T.
1060: 
1061:             *-- Column3: Grupo (DGrus - descricao do grupo via JOIN)
1062:             loc_oGrid.Column3.Header1.Caption  = "Grupo"
1063:             loc_oGrid.Column3.ControlSource    = "cursor_4c_Lista.DGrus"
1064:             loc_oGrid.Column3.Width            = 100
1065:             loc_oGrid.Column3.ReadOnly         = .T.
1066:             loc_oGrid.Column3.Header1.FontBold = .T.
1067: 
1068:             *-- Column4: Subgrupo (SGrus)
1069:             loc_oGrid.Column4.Header1.Caption  = "Subgrp."
1070:             loc_oGrid.Column4.ControlSource    = "cursor_4c_Lista.SGrus"
1071:             loc_oGrid.Column4.Width            = 70
1072:             loc_oGrid.Column4.ReadOnly         = .T.
1073:             loc_oGrid.Column4.Header1.FontBold = .T.
1074: 
1075:             *-- Column5: Ref. Fornecedor (Reffs)
1076:             loc_oGrid.Column5.Header1.Caption  = "Ref. Fornecedor"
1077:             loc_oGrid.Column5.ControlSource    = "cursor_4c_Lista.Reffs"
1078:             loc_oGrid.Column5.Width            = 180
1079:             loc_oGrid.Column5.ReadOnly         = .T.
1080:             loc_oGrid.Column5.Header1.FontBold = .T.
1081: 
1082:             *-- Column6: Usuario (UsuaAlts)
1083:             loc_oGrid.Column6.Header1.Caption  = "Usu" + CHR(225) + "rio"
1084:             loc_oGrid.Column6.ControlSource    = "cursor_4c_Lista.UsuaAlts"
1085:             loc_oGrid.Column6.Width            = 100
1086:             loc_oGrid.Column6.ReadOnly         = .T.
1087:             loc_oGrid.Column6.Header1.FontBold = .T.
1088: 
1089:             *-- Column7: Instalacao - CheckBox (Instalas)
1090:             *-- ControlSource definido na Column (NAO no Check1) - evita Error 1767
1091:             loc_oGrid.Column7.Header1.Caption  = "I"
1092:             loc_oGrid.Column7.ControlSource    = "cursor_4c_Lista.Instalas"
1093:             loc_oGrid.Column7.Width            = 30
1094:             loc_oGrid.Column7.ReadOnly         = .T.
1095:             loc_oGrid.Column7.Header1.FontBold = .T.
1096:             loc_oGrid.Column7.Alignment        = 2
1097: 
1098:         CATCH TO loc_oErro
1099:             MsgErro(loc_oErro.Message, "Erro ao formatar grid lista")
1100:         ENDTRY
1101:     ENDPROC
1102: 
1103:     *--------------------------------------------------------------------------
1104:     * AlternarPagina - Troca entre Page1 (Lista) e Page2 (Dados)
1105:     *--------------------------------------------------------------------------
1106:     PROCEDURE AlternarPagina(par_nPagina)
1107:         LOCAL loc_oErro

*-- Linhas 1173 a 1238:
1173:             loc_cWhere = " WHERE (1=1)"
1174:             IF !EMPTY(loc_cCodGrupo)
1175:                 loc_cWhere = loc_cWhere + ;
1176:                     " AND p.CGrus = " + EscaparSQL(PADR(loc_cCodGrupo, 10))
1177:             ENDIF
1178:             IF !EMPTY(loc_dDtIni)
1179:                 loc_cWhere = loc_cWhere + ;
1180:                     " AND p.DataAlts >= " + FormatarDataSQL(loc_dDtIni)
1181:             ENDIF
1182:             IF !EMPTY(loc_dDtFim)
1183:                 loc_cWhere = loc_cWhere + ;
1184:                     " AND p.DataAlts <= " + FormatarDataSQL(loc_dDtFim)
1185:             ENDIF
1186:             DO CASE
1187:                 CASE loc_nSituacao = 2
1188:                     loc_cWhere = loc_cWhere + " AND ISNULL(p.Instalas, 0) = 1"
1189:                 CASE loc_nSituacao = 3
1190:                     loc_cWhere = loc_cWhere + " AND ISNULL(p.Instalas, 0) = 0"
1191:             ENDCASE
1192: 
1193:             *-- SQL completo com JOIN para descricao do grupo
1194:             loc_cSQL = "SELECT p.CPros, p.DPros, p.DPro2s, " + ;
1195:                        "       p.CGrus, ISNULL(g.DGrus, '') AS DGrus, " + ;
1196:                        "       p.SGrus, p.Reffs, p.UsuaAlts, " + ;
1197:                        "       CAST(ISNULL(p.Instalas, 0) AS INT) AS Instalas " + ;
1198:                        "FROM SigCdPro p " + ;
1199:                        "LEFT JOIN SigCdGrp g ON g.CGrus = p.CGrus " + ;
1200:                        loc_cWhere + ;
1201:                        " ORDER BY p.CPros"
1202: 
1203:             *-- Executar em cursor temporario
1204:             IF USED("cursor_4c_ListaTemp")
1205:                 USE IN cursor_4c_ListaTemp
1206:             ENDIF
1207:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaTemp")
1208:             IF loc_nRet < 1
1209:                 MsgErro("Erro ao carregar lista de produtos.", "Erro")
1210:                 loc_lContinuar = .F.
1211:             ENDIF
1212: 
1213:             IF loc_lContinuar
1214:                 *-- Atualizar cursor principal (preserva estrutura de colunas do grid)
1215:                 SELECT cursor_4c_Lista
1216:                 ZAP
1217:                 APPEND FROM DBF("cursor_4c_ListaTemp")
1218:                 IF USED("cursor_4c_ListaTemp")
1219:                     USE IN cursor_4c_ListaTemp
1220:                 ENDIF
1221: 
1222:                 *-- Posicionar no inicio e atualizar contador
1223:                 SELECT cursor_4c_Lista
1224:                 GO TOP
1225:                 loc_oPage1.grd_4c_Lista.Refresh()
1226:                 loc_nCount = RECCOUNT("cursor_4c_Lista")
1227:                 loc_oPage1.lbl_4c_Produtos.Caption = ;
1228:                     "Produtos Selecionados : " + LTRIM(STR(loc_nCount))
1229:             ENDIF
1230: 
1231:         CATCH TO loc_oErro
1232:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de produtos")
1233:         ENDTRY
1234:     ENDPROC
1235: 
1236:     *--------------------------------------------------------------------------
1237:     * ConfigurarEventos - BINDEVENT para botoes e filtros
1238:     * IMPORTANTE: todos os handlers devem ser PUBLIC

*-- Linhas 1432 a 1450:
1432:                 loc_lContinuar = .F.
1433:             ENDIF
1434:             IF loc_lContinuar
1435:                 SELECT cursor_4c_Lista
1436:                 loc_cCodigo = ALLTRIM(CPros)
1437:                 IF EMPTY(loc_cCodigo)
1438:                     MsgAviso("Nenhum produto selecionado.", "Aviso")
1439:                     loc_lContinuar = .F.
1440:                 ENDIF
1441:             ENDIF
1442:             IF loc_lContinuar
1443:                 THIS.AlternarPagina(2)
1444:                 this_lNovoRegistro = .F.
1445:                 this_lEmEdicao     = .F.
1446:                 this_cCodigo       = loc_cCodigo
1447:                 this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1448:                 THIS.BOParaForm()
1449:                 THIS.HabilitarCampos(.F.)
1450:             ENDIF

*-- Linhas 1462 a 1480:
1462:                 loc_lContinuar = .F.
1463:             ENDIF
1464:             IF loc_lContinuar
1465:                 SELECT cursor_4c_Lista
1466:                 loc_cCodigo = ALLTRIM(CPros)
1467:                 IF EMPTY(loc_cCodigo)
1468:                     MsgAviso("Nenhum produto selecionado.", "Aviso")
1469:                     loc_lContinuar = .F.
1470:                 ENDIF
1471:             ENDIF
1472:             IF loc_lContinuar
1473:                 THIS.AlternarPagina(2)
1474:                 this_lNovoRegistro = .F.
1475:                 this_lEmEdicao     = .T.
1476:                 this_cCodigo       = loc_cCodigo
1477:                 this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1478:                 this_oBusinessObject.EditarRegistro()
1479:                 THIS.BOParaForm()
1480:                 THIS.HabilitarCampos(.T.)

*-- Linhas 1493 a 1511:
1493:                 loc_lContinuar = .F.
1494:             ENDIF
1495:             IF loc_lContinuar
1496:                 SELECT cursor_4c_Lista
1497:                 loc_cCodigo = ALLTRIM(CPros)
1498:                 IF EMPTY(loc_cCodigo)
1499:                     MsgAviso("Nenhum produto selecionado.", "Aviso")
1500:                     loc_lContinuar = .F.
1501:                 ENDIF
1502:             ENDIF
1503:             IF loc_lContinuar
1504:                 loc_lConfirmou = MsgConfirma("Deseja excluir o produto [" + ;
1505:                     loc_cCodigo + "]?", ;
1506:                     "Confirmar Exclus" + CHR(227) + "o")
1507:                 IF loc_lConfirmou
1508:                     this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1509:                     IF this_oBusinessObject.Excluir()
1510:                         MsgInfo("Produto exclu" + CHR(237) + "do com sucesso.", "Sucesso")
1511:                         THIS.CarregarLista()

*-- Linhas 1723 a 1745:
1723:             loc_oPgFaseP.img_4c_ImgBorracha.Picture = ""
1724:             loc_oPgFaseP.img_4c_ImgBorracha.Visible = .F.
1725:             IF USED("cursor_4c_PrfFase")
1726:                 SELECT cursor_4c_PrfFase
1727:                 ZAP
1728:             ENDIF
1729:             IF USED("cursor_4c_Mtz")
1730:                 SELECT cursor_4c_Mtz
1731:                 ZAP
1732:             ENDIF
1733:         CATCH TO loc_oErro
1734:             MsgErro(loc_oErro.Message, "Erro ao limpar campos")
1735:         ENDTRY
1736:     ENDPROC
1737: 
1738:     *--------------------------------------------------------------------------
1739:     * HabilitarCampos - Habilita/desabilita campos de edicao
1740:     *--------------------------------------------------------------------------
1741:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1742:         LOCAL loc_oPgDados, loc_oErro
1743:         TRY
1744:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
1745:             *-- Codigo: somente editavel em novo registro

*-- Linhas 1856 a 1950:
1856:             *-- Descricoes de grupo e subgrupo (lookup)
1857:             IF gnConnHandle > 0 AND !gb_4c_ValidandoUI
1858:                 IF !EMPTY(loc_oBO.this_cCgrus)
1859:                     loc_nRet = SQLEXEC(gnConnHandle, ;
1860:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
1861:                         EscaparSQL(PADR(ALLTRIM(loc_oBO.this_cCgrus), 10)), ;
1862:                         "cursor_4c_BODGru")
1863:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BODGru") > 0
1864:                         SELECT cursor_4c_BODGru
1865:                         loc_oPgDados.txt_4c_Dgru.Value = ALLTRIM(DGrus)
1866:                     ENDIF
1867:                     IF USED("cursor_4c_BODGru")
1868:                         USE IN cursor_4c_BODGru
1869:                     ENDIF
1870:                 ELSE
1871:                     loc_oPgDados.txt_4c_Dgru.Value = ""
1872:                 ENDIF
1873:                 IF !EMPTY(loc_oBO.this_cSGrus)
1874:                     loc_nRet = SQLEXEC(gnConnHandle, ;
1875:                         "SELECT DSGrus FROM SigCdSGr WHERE CSGrus = " + ;
1876:                         EscaparSQL(PADR(ALLTRIM(loc_oBO.this_cSGrus), 10)), ;
1877:                         "cursor_4c_BODSGru")
1878:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BODSGru") > 0
1879:                         SELECT cursor_4c_BODSGru
1880:                         loc_oPgDados.txt_4c_DsGru.Value = ALLTRIM(DSGrus)
1881:                     ENDIF
1882:                     IF USED("cursor_4c_BODSGru")
1883:                         USE IN cursor_4c_BODSGru
1884:                     ENDIF
1885:                 ELSE
1886:                     loc_oPgDados.txt_4c_DsGru.Value = ""
1887:                 ENDIF
1888:             ENDIF
1889: 
1890:             *-- === Linha / Colecao ===
1891:             loc_oPgDados.txt_4c_Lin.Value = ALLTRIM(loc_oBO.this_cLins)
1892:             loc_oPgDados.txt_4c_Col.Value = ALLTRIM(loc_oBO.this_cCols)
1893:             *-- Descricoes de linha e colecao (lookup)
1894:             IF gnConnHandle > 0 AND !gb_4c_ValidandoUI
1895:                 IF !EMPTY(loc_oBO.this_cLins)
1896:                     loc_nRet = SQLEXEC(gnConnHandle, ;
1897:                         "SELECT DLins FROM SigCdLin WHERE CLins = " + ;
1898:                         EscaparSQL(PADR(ALLTRIM(loc_oBO.this_cLins), 5)), ;
1899:                         "cursor_4c_BODLin")
1900:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BODLin") > 0
1901:                         SELECT cursor_4c_BODLin
1902:                         loc_oPgDados.txt_4c_DLin.Value = ALLTRIM(DLins)
1903:                     ENDIF
1904:                     IF USED("cursor_4c_BODLin")
1905:                         USE IN cursor_4c_BODLin
1906:                     ENDIF
1907:                 ELSE
1908:                     loc_oPgDados.txt_4c_DLin.Value = ""
1909:                 ENDIF
1910:                 IF !EMPTY(loc_oBO.this_cCols)
1911:                     loc_nRet = SQLEXEC(gnConnHandle, ;
1912:                         "SELECT DCols FROM SigCdCol WHERE CCols = " + ;
1913:                         EscaparSQL(PADR(ALLTRIM(loc_oBO.this_cCols), 5)), ;
1914:                         "cursor_4c_BODCol")
1915:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BODCol") > 0
1916:                         SELECT cursor_4c_BODCol
1917:                         loc_oPgDados.txt_4c_DCol.Value = ALLTRIM(DCols)
1918:                     ENDIF
1919:                     IF USED("cursor_4c_BODCol")
1920:                         USE IN cursor_4c_BODCol
1921:                     ENDIF
1922:                 ELSE
1923:                     loc_oPgDados.txt_4c_DCol.Value = ""
1924:                 ENDIF
1925:             ENDIF
1926: 
1927:             *-- === Fornecedor ===
1928:             loc_oPgDados.txt_4c_Ifor.Value = ALLTRIM(loc_oBO.this_cIFors)
1929:             IF gnConnHandle > 0 AND !gb_4c_ValidandoUI AND !EMPTY(loc_oBO.this_cIFors)
1930:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1931:                     "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
1932:                     EscaparSQL(ALLTRIM(loc_oBO.this_cIFors)), ;
1933:                     "cursor_4c_BODfor")
1934:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BODfor") > 0
1935:                     SELECT cursor_4c_BODfor
1936:                     loc_oPgDados.txt_4c_Dfor.Value = ALLTRIM(RClis)
1937:                 ENDIF
1938:                 IF USED("cursor_4c_BODfor")
1939:                     USE IN cursor_4c_BODfor
1940:                 ENDIF
1941:             ELSE
1942:                 loc_oPgDados.txt_4c_Dfor.Value = ""
1943:             ENDIF
1944: 
1945:             *-- === Quantidades / Lote ===
1946:             loc_oPgDados.txt_4c_Qmin.Value      = loc_oBO.this_nQmins
1947:             loc_oPgDados.txt_4c_LtMinsV.Value   = loc_oBO.this_nLtMinsVs
1948:             loc_oPgDados.txt_4c_Conjunto.Value  = loc_oBO.this_nConjuntos
1949:             loc_oPgDados.txt_4c_QtPed.Value     = loc_oBO.this_nQtPeds
1950:             loc_oPgDados.txt_4c_DiasGar.Value   = loc_oBO.this_nDiasGars

*-- Linhas 2053 a 2076:
2053:                 IF USED(loc_cAlias)
2054:                     USE IN (loc_cAlias)
2055:                 ENDIF
2056:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2057:                     "SELECT " + par_cCampoDes + " FROM " + par_cTabela + ;
2058:                     " WHERE " + par_cCampoPK + " = " + EscaparSQL(par_cCodigo), ;
2059:                     loc_cAlias)
2060:                 IF loc_nRet > 0 AND RECCOUNT(loc_cAlias) > 0
2061:                     SELECT (loc_cAlias)
2062:                     par_oTextBox.Value = ALLTRIM(&par_cCampoDes)
2063:                 ELSE
2064:                     par_oTextBox.Value = ""
2065:                 ENDIF
2066:                 IF USED(loc_cAlias)
2067:                     USE IN (loc_cAlias)
2068:                 ENDIF
2069:             ENDIF
2070:         CATCH TO loc_oErro
2071:             *-- Tolerado: lookup nao critico
2072:         ENDTRY
2073:     ENDPROC
2074: 
2075:     *--------------------------------------------------------------------------
2076:     * FormParaBO - Le campos do form e envia para o BO (COMPLETO)

*-- Linhas 4708 a 4731:
4708:                 loc_oPage1.cnt_4c_Filtros.txt_4c_DesGrupo.Value = ""
4709:                 RETURN
4710:             ENDIF
4711:             loc_nRet = SQLEXEC(gnConnHandle, ;
4712:                 "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
4713:                 EscaparSQL(PADR(loc_cCodGrupo, 10)), ;
4714:                 "cursor_4c_BuscaGrp")
4715:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BuscaGrp") > 0
4716:                 SELECT cursor_4c_BuscaGrp
4717:                 loc_oPage1.cnt_4c_Filtros.txt_4c_DesGrupo.Value = ALLTRIM(DGrus)
4718:             ELSE
4719:                 loc_oPage1.cnt_4c_Filtros.txt_4c_DesGrupo.Value = ""
4720:                 loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo.Value = ""
4721:             ENDIF
4722:             IF USED("cursor_4c_BuscaGrp")
4723:                 USE IN cursor_4c_BuscaGrp
4724:             ENDIF
4725:         CATCH TO loc_oErro
4726:             MsgErro(loc_oErro.Message, "Erro ao validar grupo")
4727:         ENDTRY
4728:     ENDPROC
4729: 
4730:     *-- AbrirLookupGrupo: lookup para o FILTRO da Page1 (txt_4c_CodGrupo)
4731:     PROTECTED PROCEDURE AbrirLookupGrupo()

*-- Linhas 4870 a 4893:
4870:                 loc_oPgDados.txt_4c_Dgru.Value = ""
4871:                 RETURN
4872:             ENDIF
4873:             loc_nRet = SQLEXEC(gnConnHandle, ;
4874:                 "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
4875:                 EscaparSQL(PADR(loc_cCodGru, 10)), ;
4876:                 "cursor_4c_ValGru")
4877:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValGru") > 0
4878:                 SELECT cursor_4c_ValGru
4879:                 loc_oPgDados.txt_4c_Dgru.Value = ALLTRIM(DGrus)
4880:             ELSE
4881:                 loc_oPgDados.txt_4c_Cgru.Value = ""
4882:                 loc_oPgDados.txt_4c_Dgru.Value = ""
4883:             ENDIF
4884:             IF USED("cursor_4c_ValGru")
4885:                 USE IN cursor_4c_ValGru
4886:             ENDIF
4887:         CATCH TO loc_oErro
4888:             MsgErro(loc_oErro.Message, "Erro ao validar grupo")
4889:         ENDTRY
4890:     ENDPROC
4891: 
4892:     *-- SubGrupo (SigCdPsg: Codigos / Descricaos, filtrado por CGrus)
4893:     PROCEDURE CSGruKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 4925 a 4956:
4925:                 USE IN cursor_4c_BuscaCSGru
4926:             ENDIF
4927:             IF EMPTY(loc_cCodGru)
4928:                 loc_cSQL = "SELECT Codigos, Descricaos FROM SigCdPsg ORDER BY Codigos"
4929:             ELSE
4930:                 loc_cSQL = "SELECT Codigos, Descricaos FROM SigCdPsg " + ;
4931:                            "WHERE CGrus = " + EscaparSQL(PADR(loc_cCodGru, 10)) + ;
4932:                            " ORDER BY Codigos"
4933:             ENDIF
4934:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCSGru")
4935:             IF loc_nRet < 1 OR RECCOUNT("cursor_4c_BuscaCSGru") = 0
4936:                 IF USED("cursor_4c_BuscaCSGru")
4937:                     USE IN cursor_4c_BuscaCSGru
4938:                 ENDIF
4939:                 *-- Sem filtro de grupo
4940:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4941:                     "SELECT Codigos, Descricaos FROM SigCdPsg ORDER BY Codigos", ;
4942:                     "cursor_4c_BuscaCSGru")
4943:             ENDIF
4944:             IF loc_nRet < 1
4945:                 MsgErro("Erro ao carregar subgrupos.", "Erro")
4946:                 RETURN
4947:             ENDIF
4948:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPsg", ;
4949:                 "cursor_4c_BuscaCSGru2", "Codigos", ;
4950:                 ALLTRIM(loc_oPgDados.txt_4c_CSGru.Value), ;
4951:                 "Subgrupo")
4952:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
4953:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
4954:             loc_oBusca.Show()
4955:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCSGru2")
4956:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCSGru2.Codigos)

*-- Linhas 4982 a 5005:
4982:                 loc_oPgDados.txt_4c_DsGru.Value = ""
4983:                 RETURN
4984:             ENDIF
4985:             loc_nRet = SQLEXEC(gnConnHandle, ;
4986:                 "SELECT Descricaos FROM SigCdPsg WHERE Codigos = " + ;
4987:                 EscaparSQL(PADR(loc_cCod, 10)), ;
4988:                 "cursor_4c_ValCSGru")
4989:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValCSGru") > 0
4990:                 SELECT cursor_4c_ValCSGru
4991:                 loc_oPgDados.txt_4c_DsGru.Value = ALLTRIM(Descricaos)
4992:             ELSE
4993:                 loc_oPgDados.txt_4c_CSGru.Value = ""
4994:                 loc_oPgDados.txt_4c_DsGru.Value = ""
4995:             ENDIF
4996:             IF USED("cursor_4c_ValCSGru")
4997:                 USE IN cursor_4c_ValCSGru
4998:             ENDIF
4999:         CATCH TO loc_oErro
5000:             MsgErro(loc_oErro.Message, "Erro ao validar subgrupo")
5001:         ENDTRY
5002:     ENDPROC
5003: 
5004:     *-- Linha (SigCdLin: Linhas / Descs)
5005:     PROCEDURE LinKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 5064 a 5087:
5064:                 loc_oPgDados.txt_4c_DLin.Value = ""
5065:                 RETURN
5066:             ENDIF
5067:             loc_nRet = SQLEXEC(gnConnHandle, ;
5068:                 "SELECT Descs FROM SigCdLin WHERE Linhas = " + ;
5069:                 EscaparSQL(PADR(loc_cCod, 10)), ;
5070:                 "cursor_4c_ValLin")
5071:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValLin") > 0
5072:                 SELECT cursor_4c_ValLin
5073:                 loc_oPgDados.txt_4c_DLin.Value = ALLTRIM(Descs)
5074:             ELSE
5075:                 loc_oPgDados.txt_4c_Lin.Value  = ""
5076:                 loc_oPgDados.txt_4c_DLin.Value = ""
5077:             ENDIF
5078:             IF USED("cursor_4c_ValLin")
5079:                 USE IN cursor_4c_ValLin
5080:             ENDIF
5081:         CATCH TO loc_oErro
5082:             MsgErro(loc_oErro.Message, "Erro ao validar linha")
5083:         ENDTRY
5084:     ENDPROC
5085: 
5086:     *-- Colecao / Grupo de Venda (SigCdCol: Colecoes / Descs)
5087:     PROCEDURE ColKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 5146 a 5169:
5146:                 loc_oPgDados.txt_4c_DCol.Value = ""
5147:                 RETURN
5148:             ENDIF
5149:             loc_nRet = SQLEXEC(gnConnHandle, ;
5150:                 "SELECT Descs FROM SigCdCol WHERE Colecoes = " + ;
5151:                 EscaparSQL(PADR(loc_cCod, 10)), ;
5152:                 "cursor_4c_ValCol")
5153:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValCol") > 0
5154:                 SELECT cursor_4c_ValCol
5155:                 loc_oPgDados.txt_4c_DCol.Value = ALLTRIM(Descs)
5156:             ELSE
5157:                 loc_oPgDados.txt_4c_Col.Value  = ""
5158:                 loc_oPgDados.txt_4c_DCol.Value = ""
5159:             ENDIF
5160:             IF USED("cursor_4c_ValCol")
5161:                 USE IN cursor_4c_ValCol
5162:             ENDIF
5163:         CATCH TO loc_oErro
5164:             MsgErro(loc_oErro.Message, "Erro ao validar grupo de venda")
5165:         ENDTRY
5166:     ENDPROC
5167: 
5168:     *-- Fornecedor (SigCdCli: IClis / RClis)
5169:     PROCEDURE IforKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 5228 a 5251:
5228:                 loc_oPgDados.txt_4c_Dfor.Value = ""
5229:                 RETURN
5230:             ENDIF
5231:             loc_nRet = SQLEXEC(gnConnHandle, ;
5232:                 "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
5233:                 EscaparSQL(PADR(loc_cCod, 10)), ;
5234:                 "cursor_4c_ValIfor")
5235:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValIfor") > 0
5236:                 SELECT cursor_4c_ValIfor
5237:                 loc_oPgDados.txt_4c_Dfor.Value = ALLTRIM(RClis)
5238:             ELSE
5239:                 loc_oPgDados.txt_4c_Ifor.Value = ""
5240:                 loc_oPgDados.txt_4c_Dfor.Value = ""
5241:             ENDIF
5242:             IF USED("cursor_4c_ValIfor")
5243:                 USE IN cursor_4c_ValIfor
5244:             ENDIF
5245:         CATCH TO loc_oErro
5246:             MsgErro(loc_oErro.Message, "Erro ao validar fornecedor")
5247:         ENDTRY
5248:     ENDPROC
5249: 
5250:     *-- Cor (SigCdCor: Cods / Descs)
5251:     PROCEDURE CorProKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 5398 a 5421:
5398:                 loc_oPgDados.txt_4c_DesFinP.Value = ""
5399:                 RETURN
5400:             ENDIF
5401:             loc_nRet = SQLEXEC(gnConnHandle, ;
5402:                 "SELECT Descs FROM SigCdFip WHERE Cods = " + ;
5403:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5404:                 "cursor_4c_ValFinP")
5405:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValFinP") > 0
5406:                 SELECT cursor_4c_ValFinP
5407:                 loc_oPgDados.txt_4c_DesFinP.Value = ALLTRIM(Descs)
5408:             ELSE
5409:                 loc_oPgDados.txt_4c_CodFinP.Value = ""
5410:                 loc_oPgDados.txt_4c_DesFinP.Value = ""
5411:             ENDIF
5412:             IF USED("cursor_4c_ValFinP")
5413:                 USE IN cursor_4c_ValFinP
5414:             ENDIF
5415:         CATCH TO loc_oErro
5416:             MsgErro(loc_oErro.Message, "Erro ao validar finalidade")
5417:         ENDTRY
5418:     ENDPROC
5419: 
5420:     *-- Acabamento (SigCdAca: Cods / Descrs)
5421:     PROCEDURE CodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 5480 a 5503:
5480:                 loc_oPgDados.txt_4c_DesAcb.Value = ""
5481:                 RETURN
5482:             ENDIF
5483:             loc_nRet = SQLEXEC(gnConnHandle, ;
5484:                 "SELECT Descrs FROM SigCdAca WHERE Cods = " + ;
5485:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5486:                 "cursor_4c_ValAcb")
5487:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValAcb") > 0
5488:                 SELECT cursor_4c_ValAcb
5489:                 loc_oPgDados.txt_4c_DesAcb.Value = ALLTRIM(Descrs)
5490:             ELSE
5491:                 loc_oPgDados.txt_4c_CodAcb.Value = ""
5492:                 loc_oPgDados.txt_4c_DesAcb.Value = ""
5493:             ENDIF
5494:             IF USED("cursor_4c_ValAcb")
5495:                 USE IN cursor_4c_ValAcb
5496:             ENDIF
5497:         CATCH TO loc_oErro
5498:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
5499:         ENDTRY
5500:     ENDPROC
5501: 
5502:     *-- Classificacao (SigCdCls: Cods / Descs, filtrado por CGrus)
5503:     PROCEDURE ClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 5531 a 5553:
5531:             ENDIF
5532:             loc_cCodGru = ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value)
5533:             IF !EMPTY(loc_cCodGru)
5534:                 loc_cSQL = "SELECT Cods, Descs FROM SigCdCls " + ;
5535:                            "WHERE CGrus IN (" + EscaparSQL(PADR(loc_cCodGru, 10)) + ;
5536:                            ", '          ') ORDER BY Cods"
5537:             ELSE
5538:                 loc_cSQL = "SELECT Cods, Descs FROM SigCdCls ORDER BY Cods"
5539:             ENDIF
5540:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCls", ;
5541:                 "cursor_4c_BuscaClass", "Cods", ;
5542:                 ALLTRIM(loc_oPgDados.txt_4c_Class.Value), ;
5543:                 "Classifica" + CHR(231) + CHR(227) + "o")
5544:             loc_oBusca.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
5545:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
5546:             loc_oBusca.Show()
5547:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
5548:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaClass.Cods)
5549:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaClass.Descs)
5550:                 loc_oPgDados.txt_4c_Class.Value  = loc_cCodigo
5551:                 loc_oPgDados.txt_4c_DClass.Value = loc_cDescricao
5552:             ENDIF
5553:             IF USED("cursor_4c_BuscaClass")

*-- Linhas 5571 a 5594:
5571:                 loc_oPgDados.txt_4c_DClass.Value = ""
5572:                 RETURN
5573:             ENDIF
5574:             loc_nRet = SQLEXEC(gnConnHandle, ;
5575:                 "SELECT Descs FROM SigCdCls WHERE Cods = " + ;
5576:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5577:                 "cursor_4c_ValClass")
5578:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValClass") > 0
5579:                 SELECT cursor_4c_ValClass
5580:                 loc_oPgDados.txt_4c_DClass.Value = ALLTRIM(Descs)
5581:             ELSE
5582:                 loc_oPgDados.txt_4c_Class.Value  = ""
5583:                 loc_oPgDados.txt_4c_DClass.Value = ""
5584:             ENDIF
5585:             IF USED("cursor_4c_ValClass")
5586:                 USE IN cursor_4c_ValClass
5587:             ENDIF
5588:         CATCH TO loc_oErro
5589:             MsgErro(loc_oErro.Message, "Erro ao validar classifica" + CHR(231) + CHR(227) + "o")
5590:         ENDTRY
5591:     ENDPROC
5592: 
5593:     *-- Local (SigPrLcl: Codigos / Descricaos)
5594:     PROCEDURE LocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 5697 a 5720:
5697:                 loc_oPgDados.txt_4c_Duni.Value = ""
5698:                 RETURN
5699:             ENDIF
5700:             loc_nRet = SQLEXEC(gnConnHandle, ;
5701:                 "SELECT DUnis FROM SigCdUni WHERE CUnis = " + ;
5702:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5703:                 "cursor_4c_ValCuni")
5704:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValCuni") > 0
5705:                 SELECT cursor_4c_ValCuni
5706:                 loc_oPgDados.txt_4c_Duni.Value = ALLTRIM(DUnis)
5707:             ELSE
5708:                 loc_oPgDados.txt_4c_Cuni.Value = ""
5709:                 loc_oPgDados.txt_4c_Duni.Value = ""
5710:             ENDIF
5711:             IF USED("cursor_4c_ValCuni")
5712:                 USE IN cursor_4c_ValCuni
5713:             ENDIF
5714:         CATCH TO loc_oErro
5715:             MsgErro(loc_oErro.Message, "Erro ao validar unidade 1")
5716:         ENDTRY
5717:     ENDPROC
5718: 
5719:     *-- Unidade 2 (SigCdUni: CUnis / DUnis)
5720:     PROCEDURE CunipKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 5779 a 5802:
5779:                 loc_oPgDados.txt_4c_Dunip.Value = ""
5780:                 RETURN
5781:             ENDIF
5782:             loc_nRet = SQLEXEC(gnConnHandle, ;
5783:                 "SELECT DUnis FROM SigCdUni WHERE CUnis = " + ;
5784:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5785:                 "cursor_4c_ValCunip")
5786:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValCunip") > 0
5787:                 SELECT cursor_4c_ValCunip
5788:                 loc_oPgDados.txt_4c_Dunip.Value = ALLTRIM(DUnis)
5789:             ELSE
5790:                 loc_oPgDados.txt_4c_Cunip.Value = ""
5791:                 loc_oPgDados.txt_4c_Dunip.Value = ""
5792:             ENDIF
5793:             IF USED("cursor_4c_ValCunip")
5794:                 USE IN cursor_4c_ValCunip
5795:             ENDIF
5796:         CATCH TO loc_oErro
5797:             MsgErro(loc_oErro.Message, "Erro ao validar unidade 2")
5798:         ENDTRY
5799:     ENDPROC
5800: 
5801:     *==========================================================================
5802:     * ConfigurarPgpgComposicao - Aba Composicao (Page2 do inner PageFrame)

*-- Linhas 5810 a 5867:
5810:             IF USED("cursor_4c_Compo")
5811:                 USE IN cursor_4c_Compo
5812:             ENDIF
5813:             CREATE CURSOR cursor_4c_Compo (;
5814:                 Mats     C(14)    NULL, ;
5815:                 DPros    C(40)    NULL, ;
5816:                 Unisp    C(5)     NULL, ;
5817:                 Vals     N(15,6)  NULL, ;
5818:                 Qtds     N(15,6)  NULL, ;
5819:                 Totals   N(15,6)  NULL, ;
5820:                 Moedas   C(10)    NULL, ;
5821:                 Obss     C(50)    NULL, ;
5822:                 Es       C(10)    NULL, ;
5823:                 Conss    N(15,6)  NULL, ;
5824:                 Qtdss    N(15,6)  NULL, ;
5825:                 Unis     C(5)     NULL, ;
5826:                 Ords     N(5,0)   NULL, ;
5827:                 Bloqueio C(14)    NULL  ;
5828:             )
5829:             IF USED("cursor_4c_SubCp")
5830:                 USE IN cursor_4c_SubCp
5831:             ENDIF
5832:             CREATE CURSOR cursor_4c_SubCp (;
5833:                 Mats     C(14)    NULL, ;
5834:                 DPros    C(40)    NULL, ;
5835:                 Unisp    C(5)     NULL, ;
5836:                 Vals     N(15,6)  NULL, ;
5837:                 Qtds     N(15,6)  NULL, ;
5838:                 Totals   N(15,6)  NULL, ;
5839:                 Moedas   C(10)    NULL, ;
5840:                 Obss     C(50)    NULL, ;
5841:                 Es       C(10)    NULL, ;
5842:                 Conss    N(15,6)  NULL, ;
5843:                 Qtdss    N(15,6)  NULL, ;
5844:                 Unis     C(5)     NULL, ;
5845:                 Ords     N(5,0)   NULL, ;
5846:                 Bloqueio C(14)    NULL, ;
5847:                 Tams     C(10)    NULL  ;
5848:             )
5849:             IF USED("cursor_4c_GrupoCompo")
5850:                 USE IN cursor_4c_GrupoCompo
5851:             ENDIF
5852:             CREATE CURSOR cursor_4c_GrupoCompo (;
5853:                 CGrus  C(10)   NULL, ;
5854:                 Totals N(15,6) NULL, ;
5855:                 Moedas C(10)   NULL  ;
5856:             )
5857:             SET NULL OFF
5858: 
5859:             *-- === Obs. da OF (getObsOFs) - top=297+29=326 ===
5860:             par_oPage.AddObject("lbl_4c_LblObsOF", "Label")
5861:             WITH par_oPage.lbl_4c_LblObsOF
5862:                 .Top       = 329
5863:                 .Left      = 36
5864:                 .Width     = 64
5865:                 .Height    = 15
5866:                 .FontName  = "Tahoma"
5867:                 .FontSize  = 8

*-- Linhas 5945 a 6072:
5945:             par_oPage.grd_4c_Grupo.FontName    = "Tahoma"
5946:             par_oPage.grd_4c_Grupo.FontSize    = 8
5947:             par_oPage.grd_4c_Grupo.GridLines   = 3
5948:             par_oPage.grd_4c_Grupo.DeleteMark  = .F.
5949:             par_oPage.grd_4c_Grupo.RecordMark  = .F.
5950:             par_oPage.grd_4c_Grupo.ReadOnly    = .T.
5951:             par_oPage.grd_4c_Grupo.ScrollBars  = 2
5952:             par_oPage.grd_4c_Grupo.Themes      = .F.
5953:             par_oPage.grd_4c_Grupo.Visible     = .T.
5954: 
5955:             par_oPage.grd_4c_Grupo.RecordSource = "cursor_4c_GrupoCompo"
5956: 
5957:             par_oPage.grd_4c_Grupo.Column1.Header1.Caption  = "Grupo"
5958:             par_oPage.grd_4c_Grupo.Column1.ControlSource    = "cursor_4c_GrupoCompo.CGrus"
5959:             par_oPage.grd_4c_Grupo.Column1.Width            = 60
5960:             par_oPage.grd_4c_Grupo.Column1.Header1.FontBold = .T.
5961: 
5962:             par_oPage.grd_4c_Grupo.Column2.Header1.Caption  = "Total"
5963:             par_oPage.grd_4c_Grupo.Column2.ControlSource    = "cursor_4c_GrupoCompo.Totals"
5964:             par_oPage.grd_4c_Grupo.Column2.Width            = 90
5965:             par_oPage.grd_4c_Grupo.Column2.Header1.FontBold = .T.
5966: 
5967:             par_oPage.grd_4c_Grupo.Column3.Header1.Caption  = "Moeda"
5968:             par_oPage.grd_4c_Grupo.Column3.ControlSource    = "cursor_4c_GrupoCompo.Moedas"
5969:             par_oPage.grd_4c_Grupo.Column3.Width            = 65
5970:             par_oPage.grd_4c_Grupo.Column3.Header1.FontBold = .T.
5971: 
5972:             *-- === grdCompo (composicao principal) - top=148+29=177 ===
5973:             par_oPage.AddObject("grd_4c_Compo", "Grid")
5974:             par_oPage.grd_4c_Compo.Top         = 177
5975:             par_oPage.grd_4c_Compo.Left        = 6
5976:             par_oPage.grd_4c_Compo.Width       = 943
5977:             par_oPage.grd_4c_Compo.Height      = 147
5978:             par_oPage.grd_4c_Compo.ColumnCount = 14
5979:             par_oPage.grd_4c_Compo.FontName    = "Tahoma"
5980:             par_oPage.grd_4c_Compo.FontSize    = 8
5981:             par_oPage.grd_4c_Compo.GridLines   = 3
5982:             par_oPage.grd_4c_Compo.DeleteMark  = .F.
5983:             par_oPage.grd_4c_Compo.RecordMark  = .F.
5984:             par_oPage.grd_4c_Compo.RowHeight   = 16
5985:             par_oPage.grd_4c_Compo.ScrollBars  = 3
5986:             par_oPage.grd_4c_Compo.Themes      = .F.
5987:             par_oPage.grd_4c_Compo.Visible     = .T.
5988: 
5989:             par_oPage.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
5990: 
5991:             par_oPage.grd_4c_Compo.Column1.Header1.Caption  = "Material"
5992:             par_oPage.grd_4c_Compo.Column1.ControlSource    = "cursor_4c_Compo.Mats"
5993:             par_oPage.grd_4c_Compo.Column1.Width            = 80
5994:             par_oPage.grd_4c_Compo.Column1.Header1.FontBold = .T.
5995: 
5996:             par_oPage.grd_4c_Compo.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
5997:             par_oPage.grd_4c_Compo.Column2.ControlSource    = "cursor_4c_Compo.DPros"
5998:             par_oPage.grd_4c_Compo.Column2.Width            = 155
5999:             par_oPage.grd_4c_Compo.Column2.Header1.FontBold = .T.
6000: 
6001:             par_oPage.grd_4c_Compo.Column3.Header1.Caption  = "Un"
6002:             par_oPage.grd_4c_Compo.Column3.ControlSource    = "cursor_4c_Compo.Unisp"
6003:             par_oPage.grd_4c_Compo.Column3.Width            = 35
6004:             par_oPage.grd_4c_Compo.Column3.Header1.FontBold = .T.
6005: 
6006:             par_oPage.grd_4c_Compo.Column4.Header1.Caption  = "Valor"
6007:             par_oPage.grd_4c_Compo.Column4.ControlSource    = "cursor_4c_Compo.Vals"
6008:             par_oPage.grd_4c_Compo.Column4.Width            = 75
6009:             par_oPage.grd_4c_Compo.Column4.Header1.FontBold = .T.
6010: 
6011:             par_oPage.grd_4c_Compo.Column5.Header1.Caption  = "Qtde."
6012:             par_oPage.grd_4c_Compo.Column5.ControlSource    = "cursor_4c_Compo.Qtds"
6013:             par_oPage.grd_4c_Compo.Column5.Width            = 65
6014:             par_oPage.grd_4c_Compo.Column5.Header1.FontBold = .T.
6015: 
6016:             par_oPage.grd_4c_Compo.Column6.Header1.Caption  = "Total"
6017:             par_oPage.grd_4c_Compo.Column6.ControlSource    = "cursor_4c_Compo.Totals"
6018:             par_oPage.grd_4c_Compo.Column6.Width            = 75
6019:             par_oPage.grd_4c_Compo.Column6.Header1.FontBold = .T.
6020: 
6021:             par_oPage.grd_4c_Compo.Column7.Header1.Caption  = "Moe"
6022:             par_oPage.grd_4c_Compo.Column7.ControlSource    = "cursor_4c_Compo.Moedas"
6023:             par_oPage.grd_4c_Compo.Column7.Width            = 35
6024:             par_oPage.grd_4c_Compo.Column7.Header1.FontBold = .T.
6025: 
6026:             par_oPage.grd_4c_Compo.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
6027:             par_oPage.grd_4c_Compo.Column8.ControlSource    = "cursor_4c_Compo.Obss"
6028:             par_oPage.grd_4c_Compo.Column8.Width            = 100
6029:             par_oPage.grd_4c_Compo.Column8.Header1.FontBold = .T.
6030: 
6031:             par_oPage.grd_4c_Compo.Column9.Header1.Caption  = "E"
6032:             par_oPage.grd_4c_Compo.Column9.ControlSource    = "cursor_4c_Compo.Es"
6033:             par_oPage.grd_4c_Compo.Column9.Width            = 25
6034:             par_oPage.grd_4c_Compo.Column9.Header1.FontBold = .T.
6035: 
6036:             par_oPage.grd_4c_Compo.Column10.Header1.Caption  = "Consumo"
6037:             par_oPage.grd_4c_Compo.Column10.ControlSource    = "cursor_4c_Compo.Conss"
6038:             par_oPage.grd_4c_Compo.Column10.Width            = 65
6039:             par_oPage.grd_4c_Compo.Column10.Header1.FontBold = .T.
6040: 
6041:             par_oPage.grd_4c_Compo.Column11.Header1.Caption  = "Qtde."
6042:             par_oPage.grd_4c_Compo.Column11.ControlSource    = "cursor_4c_Compo.Qtdss"
6043:             par_oPage.grd_4c_Compo.Column11.Width            = 65
6044:             par_oPage.grd_4c_Compo.Column11.Header1.FontBold = .T.
6045: 
6046:             par_oPage.grd_4c_Compo.Column12.Header1.Caption  = "Un"
6047:             par_oPage.grd_4c_Compo.Column12.ControlSource    = "cursor_4c_Compo.Unis"
6048:             par_oPage.grd_4c_Compo.Column12.Width            = 35
6049:             par_oPage.grd_4c_Compo.Column12.Header1.FontBold = .T.
6050: 
6051:             par_oPage.grd_4c_Compo.Column13.Header1.Caption  = "Ord"
6052:             par_oPage.grd_4c_Compo.Column13.ControlSource    = "cursor_4c_Compo.Ords"
6053:             par_oPage.grd_4c_Compo.Column13.Width            = 35
6054:             par_oPage.grd_4c_Compo.Column13.Header1.FontBold = .T.
6055: 
6056:             par_oPage.grd_4c_Compo.Column14.Header1.Caption  = "Bloqueio"
6057:             par_oPage.grd_4c_Compo.Column14.ControlSource    = "cursor_4c_Compo.Bloqueio"
6058:             par_oPage.grd_4c_Compo.Column14.Width            = 90
6059:             par_oPage.grd_4c_Compo.Column14.Header1.FontBold = .T.
6060: 
6061:             *-- === cmdgCompo (CommandGroup 5 botoes) - top=145+29=174 ===
6062:             par_oPage.AddObject("cmdg_4c_Compo", "CommandGroup")
6063:             WITH par_oPage.cmdg_4c_Compo
6064:                 .Top         = 174
6065:                 .Left        = 947
6066:                 .Width       = 50
6067:                 .Height      = 210
6068:                 .ButtonCount = 5
6069:                 .Themes      = .F.
6070:                 .Visible     = .T.
6071:             ENDWITH
6072: 

*-- Linhas 6190 a 6288:
6190:             par_oPage.grd_4c_SubCp.FontName    = "Tahoma"
6191:             par_oPage.grd_4c_SubCp.FontSize    = 8
6192:             par_oPage.grd_4c_SubCp.GridLines   = 3
6193:             par_oPage.grd_4c_SubCp.DeleteMark  = .F.
6194:             par_oPage.grd_4c_SubCp.RecordMark  = .F.
6195:             par_oPage.grd_4c_SubCp.RowHeight   = 16
6196:             par_oPage.grd_4c_SubCp.ScrollBars  = 3
6197:             par_oPage.grd_4c_SubCp.Themes      = .F.
6198:             par_oPage.grd_4c_SubCp.Visible     = .T.
6199: 
6200:             par_oPage.grd_4c_SubCp.RecordSource = "cursor_4c_SubCp"
6201: 
6202:             par_oPage.grd_4c_SubCp.Column1.Header1.Caption  = "Material"
6203:             par_oPage.grd_4c_SubCp.Column1.ControlSource    = "cursor_4c_SubCp.Mats"
6204:             par_oPage.grd_4c_SubCp.Column1.Width            = 80
6205:             par_oPage.grd_4c_SubCp.Column1.Header1.FontBold = .T.
6206: 
6207:             par_oPage.grd_4c_SubCp.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
6208:             par_oPage.grd_4c_SubCp.Column2.ControlSource    = "cursor_4c_SubCp.DPros"
6209:             par_oPage.grd_4c_SubCp.Column2.Width            = 140
6210:             par_oPage.grd_4c_SubCp.Column2.Header1.FontBold = .T.
6211: 
6212:             par_oPage.grd_4c_SubCp.Column3.Header1.Caption  = "Un"
6213:             par_oPage.grd_4c_SubCp.Column3.ControlSource    = "cursor_4c_SubCp.Unisp"
6214:             par_oPage.grd_4c_SubCp.Column3.Width            = 30
6215:             par_oPage.grd_4c_SubCp.Column3.Header1.FontBold = .T.
6216: 
6217:             par_oPage.grd_4c_SubCp.Column4.Header1.Caption  = "Valor"
6218:             par_oPage.grd_4c_SubCp.Column4.ControlSource    = "cursor_4c_SubCp.Vals"
6219:             par_oPage.grd_4c_SubCp.Column4.Width            = 65
6220:             par_oPage.grd_4c_SubCp.Column4.Header1.FontBold = .T.
6221: 
6222:             par_oPage.grd_4c_SubCp.Column5.Header1.Caption  = "Qtde."
6223:             par_oPage.grd_4c_SubCp.Column5.ControlSource    = "cursor_4c_SubCp.Qtds"
6224:             par_oPage.grd_4c_SubCp.Column5.Width            = 60
6225:             par_oPage.grd_4c_SubCp.Column5.Header1.FontBold = .T.
6226: 
6227:             par_oPage.grd_4c_SubCp.Column6.Header1.Caption  = "Total"
6228:             par_oPage.grd_4c_SubCp.Column6.ControlSource    = "cursor_4c_SubCp.Totals"
6229:             par_oPage.grd_4c_SubCp.Column6.Width            = 65
6230:             par_oPage.grd_4c_SubCp.Column6.Header1.FontBold = .T.
6231: 
6232:             par_oPage.grd_4c_SubCp.Column7.Header1.Caption  = "Moe"
6233:             par_oPage.grd_4c_SubCp.Column7.ControlSource    = "cursor_4c_SubCp.Moedas"
6234:             par_oPage.grd_4c_SubCp.Column7.Width            = 30
6235:             par_oPage.grd_4c_SubCp.Column7.Header1.FontBold = .T.
6236: 
6237:             par_oPage.grd_4c_SubCp.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
6238:             par_oPage.grd_4c_SubCp.Column8.ControlSource    = "cursor_4c_SubCp.Obss"
6239:             par_oPage.grd_4c_SubCp.Column8.Width            = 90
6240:             par_oPage.grd_4c_SubCp.Column8.Header1.FontBold = .T.
6241: 
6242:             par_oPage.grd_4c_SubCp.Column9.Header1.Caption  = "E"
6243:             par_oPage.grd_4c_SubCp.Column9.ControlSource    = "cursor_4c_SubCp.Es"
6244:             par_oPage.grd_4c_SubCp.Column9.Width            = 20
6245:             par_oPage.grd_4c_SubCp.Column9.Header1.FontBold = .T.
6246: 
6247:             par_oPage.grd_4c_SubCp.Column10.Header1.Caption  = "Consumo"
6248:             par_oPage.grd_4c_SubCp.Column10.ControlSource    = "cursor_4c_SubCp.Conss"
6249:             par_oPage.grd_4c_SubCp.Column10.Width            = 60
6250:             par_oPage.grd_4c_SubCp.Column10.Header1.FontBold = .T.
6251: 
6252:             par_oPage.grd_4c_SubCp.Column11.Header1.Caption  = "Qtde."
6253:             par_oPage.grd_4c_SubCp.Column11.ControlSource    = "cursor_4c_SubCp.Qtdss"
6254:             par_oPage.grd_4c_SubCp.Column11.Width            = 60
6255:             par_oPage.grd_4c_SubCp.Column11.Header1.FontBold = .T.
6256: 
6257:             par_oPage.grd_4c_SubCp.Column12.Header1.Caption  = "Un"
6258:             par_oPage.grd_4c_SubCp.Column12.ControlSource    = "cursor_4c_SubCp.Unis"
6259:             par_oPage.grd_4c_SubCp.Column12.Width            = 30
6260:             par_oPage.grd_4c_SubCp.Column12.Header1.FontBold = .T.
6261: 
6262:             par_oPage.grd_4c_SubCp.Column13.Header1.Caption  = "Ord"
6263:             par_oPage.grd_4c_SubCp.Column13.ControlSource    = "cursor_4c_SubCp.Ords"
6264:             par_oPage.grd_4c_SubCp.Column13.Width            = 30
6265:             par_oPage.grd_4c_SubCp.Column13.Header1.FontBold = .T.
6266: 
6267:             par_oPage.grd_4c_SubCp.Column14.Header1.Caption  = "Bloqueio"
6268:             par_oPage.grd_4c_SubCp.Column14.ControlSource    = "cursor_4c_SubCp.Bloqueio"
6269:             par_oPage.grd_4c_SubCp.Column14.Width            = 75
6270:             par_oPage.grd_4c_SubCp.Column14.Header1.FontBold = .T.
6271: 
6272:             par_oPage.grd_4c_SubCp.Column15.Header1.Caption  = "Tam"
6273:             par_oPage.grd_4c_SubCp.Column15.ControlSource    = "cursor_4c_SubCp.Tams"
6274:             par_oPage.grd_4c_SubCp.Column15.Width            = 55
6275:             par_oPage.grd_4c_SubCp.Column15.Header1.FontBold = .T.
6276: 
6277:             *-- === cmdgSubCp (CommandGroup 2 botoes) - top=345+29=374 ===
6278:             par_oPage.AddObject("cmdg_4c_SubCp", "CommandGroup")
6279:             WITH par_oPage.cmdg_4c_SubCp
6280:                 .Top         = 374
6281:                 .Left        = 947
6282:                 .Width       = 50
6283:                 .Height      = 90
6284:                 .ButtonCount = 2
6285:                 .Themes      = .F.
6286:                 .Visible     = .T.
6287:             ENDWITH
6288: 

*-- Linhas 7198 a 7235:
7198:             IF USED("cursor_4c_CustoCompo")
7199:                 USE IN cursor_4c_CustoCompo
7200:             ENDIF
7201:             CREATE CURSOR cursor_4c_CustoCompo (;
7202:                 Mats     C(14)    NULL, ;
7203:                 DPros    C(40)    NULL, ;
7204:                 Unisp    C(5)     NULL, ;
7205:                 Vals     N(15,6)  NULL, ;
7206:                 Qtds     N(15,6)  NULL, ;
7207:                 Totals   N(15,6)  NULL, ;
7208:                 Moedas   C(10)    NULL, ;
7209:                 Obss     C(50)    NULL, ;
7210:                 Es       C(10)    NULL, ;
7211:                 Conss    N(15,6)  NULL, ;
7212:                 Qtdss    N(15,6)  NULL, ;
7213:                 Unis     C(5)     NULL, ;
7214:                 CGrus    C(10)    NULL, ;
7215:                 Bloqueio C(14)    NULL  ;
7216:             )
7217:             IF USED("cursor_4c_GrupoCompo2")
7218:                 USE IN cursor_4c_GrupoCompo2
7219:             ENDIF
7220:             CREATE CURSOR cursor_4c_GrupoCompo2 (;
7221:                 CGrus  C(10)   NULL, ;
7222:                 Totals N(15,6) NULL, ;
7223:                 Moedas C(10)   NULL  ;
7224:             )
7225:             SET NULL OFF
7226: 
7227:             *-- === Say1: label "Tipo:" - top=159+29=188, left=112 ===
7228:             par_oPage.AddObject("lbl_4c_LblTipo", "Label")
7229:             WITH par_oPage.lbl_4c_LblTipo
7230:                 .Top       = 188
7231:                 .Left      = 112
7232:                 .Width     = 29
7233:                 .Height    = 15
7234:                 .FontName  = "Tahoma"
7235:                 .FontSize  = 8

*-- Linhas 7264 a 7349:
7264:             par_oPage.grd_4c_GrdCustoCompo.FontName    = "Tahoma"
7265:             par_oPage.grd_4c_GrdCustoCompo.FontSize    = 8
7266:             par_oPage.grd_4c_GrdCustoCompo.GridLines   = 3
7267:             par_oPage.grd_4c_GrdCustoCompo.DeleteMark  = .F.
7268:             par_oPage.grd_4c_GrdCustoCompo.RecordMark  = .F.
7269:             par_oPage.grd_4c_GrdCustoCompo.RowHeight   = 16
7270:             par_oPage.grd_4c_GrdCustoCompo.ScrollBars  = 3
7271:             par_oPage.grd_4c_GrdCustoCompo.Themes      = .F.
7272:             par_oPage.grd_4c_GrdCustoCompo.Visible     = .T.
7273: 
7274:             par_oPage.grd_4c_GrdCustoCompo.RecordSource = "cursor_4c_CustoCompo"
7275: 
7276:             par_oPage.grd_4c_GrdCustoCompo.Column1.Header1.Caption  = "Item"
7277:             par_oPage.grd_4c_GrdCustoCompo.Column1.ControlSource    = "cursor_4c_CustoCompo.Mats"
7278:             par_oPage.grd_4c_GrdCustoCompo.Column1.Width            = 80
7279:             par_oPage.grd_4c_GrdCustoCompo.Column1.Header1.FontBold = .T.
7280: 
7281:             par_oPage.grd_4c_GrdCustoCompo.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
7282:             par_oPage.grd_4c_GrdCustoCompo.Column2.ControlSource    = "cursor_4c_CustoCompo.DPros"
7283:             par_oPage.grd_4c_GrdCustoCompo.Column2.Width            = 160
7284:             par_oPage.grd_4c_GrdCustoCompo.Column2.Header1.FontBold = .T.
7285: 
7286:             par_oPage.grd_4c_GrdCustoCompo.Column3.Header1.Caption  = "Un"
7287:             par_oPage.grd_4c_GrdCustoCompo.Column3.ControlSource    = "cursor_4c_CustoCompo.Unisp"
7288:             par_oPage.grd_4c_GrdCustoCompo.Column3.Width            = 35
7289:             par_oPage.grd_4c_GrdCustoCompo.Column3.ReadOnly         = .T.
7290:             par_oPage.grd_4c_GrdCustoCompo.Column3.Header1.FontBold = .T.
7291: 
7292:             par_oPage.grd_4c_GrdCustoCompo.Column4.Header1.Caption  = "Valor"
7293:             par_oPage.grd_4c_GrdCustoCompo.Column4.ControlSource    = "cursor_4c_CustoCompo.Vals"
7294:             par_oPage.grd_4c_GrdCustoCompo.Column4.Width            = 80
7295:             par_oPage.grd_4c_GrdCustoCompo.Column4.Header1.FontBold = .T.
7296: 
7297:             par_oPage.grd_4c_GrdCustoCompo.Column5.Header1.Caption  = "Qtde."
7298:             par_oPage.grd_4c_GrdCustoCompo.Column5.ControlSource    = "cursor_4c_CustoCompo.Qtds"
7299:             par_oPage.grd_4c_GrdCustoCompo.Column5.Width            = 65
7300:             par_oPage.grd_4c_GrdCustoCompo.Column5.Header1.FontBold = .T.
7301: 
7302:             par_oPage.grd_4c_GrdCustoCompo.Column6.Header1.Caption  = "Total"
7303:             par_oPage.grd_4c_GrdCustoCompo.Column6.ControlSource    = "cursor_4c_CustoCompo.Totals"
7304:             par_oPage.grd_4c_GrdCustoCompo.Column6.Width            = 80
7305:             par_oPage.grd_4c_GrdCustoCompo.Column6.ReadOnly         = .T.
7306:             par_oPage.grd_4c_GrdCustoCompo.Column6.Header1.FontBold = .T.
7307: 
7308:             par_oPage.grd_4c_GrdCustoCompo.Column7.Header1.Caption  = "Moe"
7309:             par_oPage.grd_4c_GrdCustoCompo.Column7.ControlSource    = "cursor_4c_CustoCompo.Moedas"
7310:             par_oPage.grd_4c_GrdCustoCompo.Column7.Width            = 40
7311:             par_oPage.grd_4c_GrdCustoCompo.Column7.Header1.FontBold = .T.
7312: 
7313:             par_oPage.grd_4c_GrdCustoCompo.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
7314:             par_oPage.grd_4c_GrdCustoCompo.Column8.ControlSource    = "cursor_4c_CustoCompo.Obss"
7315:             par_oPage.grd_4c_GrdCustoCompo.Column8.Width            = 100
7316:             par_oPage.grd_4c_GrdCustoCompo.Column8.Header1.FontBold = .T.
7317: 
7318:             par_oPage.grd_4c_GrdCustoCompo.Column9.Header1.Caption  = "E"
7319:             par_oPage.grd_4c_GrdCustoCompo.Column9.ControlSource    = "cursor_4c_CustoCompo.Es"
7320:             par_oPage.grd_4c_GrdCustoCompo.Column9.Width            = 30
7321:             par_oPage.grd_4c_GrdCustoCompo.Column9.Header1.FontBold = .T.
7322: 
7323:             par_oPage.grd_4c_GrdCustoCompo.Column10.Header1.Caption  = "Consumo"
7324:             par_oPage.grd_4c_GrdCustoCompo.Column10.ControlSource    = "cursor_4c_CustoCompo.Conss"
7325:             par_oPage.grd_4c_GrdCustoCompo.Column10.Width            = 65
7326:             par_oPage.grd_4c_GrdCustoCompo.Column10.Header1.FontBold = .T.
7327: 
7328:             par_oPage.grd_4c_GrdCustoCompo.Column11.Header1.Caption  = "Qtde."
7329:             par_oPage.grd_4c_GrdCustoCompo.Column11.ControlSource    = "cursor_4c_CustoCompo.Qtdss"
7330:             par_oPage.grd_4c_GrdCustoCompo.Column11.Width            = 65
7331:             par_oPage.grd_4c_GrdCustoCompo.Column11.Header1.FontBold = .T.
7332: 
7333:             par_oPage.grd_4c_GrdCustoCompo.Column12.Header1.Caption  = "Un"
7334:             par_oPage.grd_4c_GrdCustoCompo.Column12.ControlSource    = "cursor_4c_CustoCompo.Unis"
7335:             par_oPage.grd_4c_GrdCustoCompo.Column12.Width            = 35
7336:             par_oPage.grd_4c_GrdCustoCompo.Column12.ReadOnly         = .T.
7337:             par_oPage.grd_4c_GrdCustoCompo.Column12.Header1.FontBold = .T.
7338: 
7339:             *-- === cmdgCompo (2 botoes +/-) - top=240+29=269, left=851, w=50, h=90 ===
7340:             par_oPage.AddObject("cmdg_4c_CustoCompo", "CommandGroup")
7341:             WITH par_oPage.cmdg_4c_CustoCompo
7342:                 .Top         = 269
7343:                 .Left        = 851
7344:                 .Width       = 50
7345:                 .Height      = 90
7346:                 .ButtonCount = 2
7347:                 .Themes      = .F.
7348:                 .Visible     = .T.
7349:             ENDWITH

*-- Linhas 7464 a 7502:
7464:             par_oPage.grd_4c_GrupoCompo2.FontName    = "Tahoma"
7465:             par_oPage.grd_4c_GrupoCompo2.FontSize    = 8
7466:             par_oPage.grd_4c_GrupoCompo2.GridLines   = 3
7467:             par_oPage.grd_4c_GrupoCompo2.DeleteMark  = .F.
7468:             par_oPage.grd_4c_GrupoCompo2.RecordMark  = .F.
7469:             par_oPage.grd_4c_GrupoCompo2.ReadOnly    = .T.
7470:             par_oPage.grd_4c_GrupoCompo2.ScrollBars  = 2
7471:             par_oPage.grd_4c_GrupoCompo2.Themes      = .F.
7472:             par_oPage.grd_4c_GrupoCompo2.Visible     = .T.
7473: 
7474:             par_oPage.grd_4c_GrupoCompo2.RecordSource = "cursor_4c_GrupoCompo2"
7475: 
7476:             par_oPage.grd_4c_GrupoCompo2.Column1.Header1.Caption  = "Grp"
7477:             par_oPage.grd_4c_GrupoCompo2.Column1.ControlSource    = "cursor_4c_GrupoCompo2.CGrus"
7478:             par_oPage.grd_4c_GrupoCompo2.Column1.Width            = 60
7479:             par_oPage.grd_4c_GrupoCompo2.Column1.Header1.FontBold = .T.
7480: 
7481:             par_oPage.grd_4c_GrupoCompo2.Column2.Header1.Caption  = "Total"
7482:             par_oPage.grd_4c_GrupoCompo2.Column2.ControlSource    = "cursor_4c_GrupoCompo2.Totals"
7483:             par_oPage.grd_4c_GrupoCompo2.Column2.Width            = 90
7484:             par_oPage.grd_4c_GrupoCompo2.Column2.Header1.FontBold = .T.
7485: 
7486:             par_oPage.grd_4c_GrupoCompo2.Column3.Header1.Caption  = "Moe"
7487:             par_oPage.grd_4c_GrupoCompo2.Column3.ControlSource    = "cursor_4c_GrupoCompo2.Moedas"
7488:             par_oPage.grd_4c_GrupoCompo2.Column3.Width            = 40
7489:             par_oPage.grd_4c_GrupoCompo2.Column3.Header1.FontBold = .T.
7490: 
7491:         CATCH TO loc_oErro
7492:             MsgErro(loc_oErro.Message, "Erro ao configurar p" + CHR(225) + "gina Custo")
7493:         ENDTRY
7494:     ENDPROC
7495: 
7496:     *==========================================================================
7497:     * CarregarComposicao - Carrega SigPrCpo e SigPrScp para o produto atual
7498:     *==========================================================================
7499:     PROCEDURE CarregarComposicao()
7500:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgComp, loc_oErro
7501:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
7502:             RETURN

*-- Linhas 7511 a 7610:
7511:             IF USED("cursor_4c_CompoTemp")
7512:                 USE IN cursor_4c_CompoTemp
7513:             ENDIF
7514:             loc_cSQL = "SELECT c.Mats, ISNULL(p.DPros,'') AS DPros, " + ;
7515:                        "       c.Unisp, c.Vals, c.Qtds, c.Totals, c.Moedas, " + ;
7516:                        "       ISNULL(c.Obss,'') AS Obss, ISNULL(c.Es,'') AS Es, " + ;
7517:                        "       c.Conss, c.Qtdss, ISNULL(c.Unis,'') AS Unis, " + ;
7518:                        "       c.Ords, ISNULL(c.Bloqueio,'') AS Bloqueio " + ;
7519:                        "FROM SigPrCpo c " + ;
7520:                        "LEFT JOIN SigCdPro p ON p.CPros = c.Mats " + ;
7521:                        "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7522:                        " ORDER BY c.Ords"
7523:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoTemp")
7524:             IF loc_nRet > 0
7525:                 SELECT cursor_4c_Compo
7526:                 ZAP
7527:                 APPEND FROM DBF("cursor_4c_CompoTemp")
7528:                 IF USED("cursor_4c_CompoTemp")
7529:                     USE IN cursor_4c_CompoTemp
7530:                 ENDIF
7531:                 SELECT cursor_4c_Compo
7532:                 GO TOP
7533:             ENDIF
7534: 
7535:             *-- Carregar subcomposicao (SigPrScp)
7536:             IF USED("cursor_4c_SubCpTemp")
7537:                 USE IN cursor_4c_SubCpTemp
7538:             ENDIF
7539:             loc_cSQL = "SELECT s.Mats, ISNULL(p.DPros,'') AS DPros, " + ;
7540:                        "       s.Unisp, s.Vals, s.Qtds, s.Totals, s.Moedas, " + ;
7541:                        "       ISNULL(s.Obss,'') AS Obss, ISNULL(s.Es,'') AS Es, " + ;
7542:                        "       s.Conss, s.Qtdss, ISNULL(s.Unis,'') AS Unis, " + ;
7543:                        "       s.Ords, ISNULL(s.Bloqueio,'') AS Bloqueio, " + ;
7544:                        "       ISNULL(s.Tams,'') AS Tams " + ;
7545:                        "FROM SigPrScp s " + ;
7546:                        "LEFT JOIN SigCdPro p ON p.CPros = s.Mats " + ;
7547:                        "WHERE s.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7548:                        " ORDER BY s.Ords"
7549:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubCpTemp")
7550:             IF loc_nRet > 0
7551:                 SELECT cursor_4c_SubCp
7552:                 ZAP
7553:                 APPEND FROM DBF("cursor_4c_SubCpTemp")
7554:                 IF USED("cursor_4c_SubCpTemp")
7555:                     USE IN cursor_4c_SubCpTemp
7556:                 ENDIF
7557:                 SELECT cursor_4c_SubCp
7558:                 GO TOP
7559:             ENDIF
7560: 
7561:             *-- Refresh grids
7562:             loc_oPgComp = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7563:             loc_oPgComp.grd_4c_Compo.Refresh()
7564:             loc_oPgComp.grd_4c_SubCp.Refresh()
7565:             loc_oPgComp.grd_4c_Grupo.Refresh()
7566: 
7567:         CATCH TO loc_oErro
7568:             MsgErro(loc_oErro.Message, "Erro ao carregar composi" + CHR(231) + CHR(227) + "o")
7569:         ENDTRY
7570:     ENDPROC
7571: 
7572:     *==========================================================================
7573:     * Handlers de composicao (PUBLIC - obrigatorio para BINDEVENT)
7574:     *==========================================================================
7575:     PROCEDURE CompoAfterRowColChange(par_nColIndex)
7576:         LOCAL loc_oPg, loc_oErro
7577:         TRY
7578:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7579:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
7580:                 SELECT cursor_4c_Compo
7581:                 loc_oPg.txt_4c_Desc.Value    = ALLTRIM(DPros)
7582:                 loc_oPg.txt_4c_MatP.Value    = ALLTRIM(Mats)
7583:                 loc_oPg.txt_4c_ObsOFs.Value  = ALLTRIM(Obss)
7584:             ENDIF
7585:         CATCH TO loc_oErro
7586:             *-- Tolerado
7587:         ENDTRY
7588:     ENDPROC
7589: 
7590:     PROCEDURE SubCpAfterRowColChange(par_nColIndex)
7591:         LOCAL loc_oPg, loc_oErro
7592:         TRY
7593:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7594:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
7595:                 SELECT cursor_4c_SubCp
7596:                 loc_oPg.txt_4c_Desccp.Value = ALLTRIM(DPros)
7597:                 loc_oPg.txt_4c_Matsub.Value = ALLTRIM(Mats)
7598:             ENDIF
7599:         CATCH TO loc_oErro
7600:             *-- Tolerado
7601:         ENDTRY
7602:     ENDPROC
7603: 
7604:     PROCEDURE LiberaCustoChange()
7605:         LOCAL loc_oPg, loc_lLibera, loc_oErro
7606:         TRY
7607:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7608:             loc_lLibera = (loc_oPg.chk_4c_ChkLiberaCusto.Value = 1) AND this_lEmEdicao
7609:             loc_oPg.txt_4c_Pcus.ReadOnly    = !loc_lLibera
7610:             loc_oPg.txt_4c_Moec.ReadOnly    = !loc_lLibera

*-- Linhas 7776 a 7796:
7776:                 ENDIF
7777:             ENDIF
7778:             IF loc_lContinuar AND gnConnHandle > 0
7779:                 loc_nRet = SQLEXEC(gnConnHandle, ;
7780:                     "INSERT INTO SigPrCpo (CPros, DtMovs, cIdChaves, TpCalcCus) " + ;
7781:                     "VALUES (" + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7782:                     ", GETDATE(), NEWID(), 1)")
7783:                 IF loc_nRet < 1
7784:                     MsgErro("Erro ao incluir linha de composi" + CHR(231) + CHR(227) + "o.", "Erro")
7785:                 ELSE
7786:                     THIS.CarregarComposicao()
7787:                 ENDIF
7788:             ENDIF
7789:         CATCH TO loc_oErro
7790:             MsgErro(loc_oErro.Message, "Erro ao incluir linha de composi" + CHR(231) + CHR(227) + "o")
7791:         ENDTRY
7792:     ENDPROC
7793: 
7794:     *-- Excluir linha da composicao principal
7795:     PROCEDURE CompoExcluirClick()
7796:         LOCAL loc_nRet, loc_cMats, loc_lConfirmou, loc_oErro, loc_lContinuar

*-- Linhas 7809 a 7831:
7809:             IF loc_lContinuar
7810:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta linha de composi" + CHR(231) + CHR(227) + "o?", "Confirmar")
7811:                 IF loc_lConfirmou AND gnConnHandle > 0
7812:                     SELECT cursor_4c_Compo
7813:                     loc_cMats = ALLTRIM(Mats)
7814:                     loc_nRet  = SQLEXEC(gnConnHandle, ;
7815:                         "DELETE FROM SigPrCpo WHERE CPros = " + EscaparSQL(PADR(ALLTRIM(this_cCodigo), 14)) + ;
7816:                         " AND Mats = " + EscaparSQL(PADR(loc_cMats, 14)))
7817:                     THIS.CarregarComposicao()
7818:                 ENDIF
7819:             ENDIF
7820:         CATCH TO loc_oErro
7821:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de composi" + CHR(231) + CHR(227) + "o")
7822:         ENDTRY
7823:     ENDPROC
7824: 
7825:     PROCEDURE CompoAtualizaClick()
7826:         LOCAL loc_oErro
7827:         TRY
7828:             THIS.CarregarComposicao()
7829:         CATCH TO loc_oErro
7830:             MsgErro(loc_oErro.Message, "Erro ao atualizar composi" + CHR(231) + CHR(227) + "o")
7831:         ENDTRY

*-- Linhas 7865 a 7885:
7865:                 ENDIF
7866:             ENDIF
7867:             IF loc_lContinuar AND gnConnHandle > 0
7868:                 loc_nRet = SQLEXEC(gnConnHandle, ;
7869:                     "INSERT INTO SigPrScp (CPros, DtMovs, cIdChaves) " + ;
7870:                     "VALUES (" + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7871:                     ", GETDATE(), NEWID())")
7872:                 IF loc_nRet < 1
7873:                     MsgErro("Erro ao incluir linha de subcomposi" + CHR(231) + CHR(227) + "o.", "Erro")
7874:                 ELSE
7875:                     THIS.CarregarComposicao()
7876:                 ENDIF
7877:             ENDIF
7878:         CATCH TO loc_oErro
7879:             MsgErro(loc_oErro.Message, "Erro ao incluir subcomposi" + CHR(231) + CHR(227) + "o")
7880:         ENDTRY
7881:     ENDPROC
7882: 
7883:     *-- Excluir linha da subcomposicao
7884:     PROCEDURE SubCpExcluirClick()
7885:         LOCAL loc_nRet, loc_cMats, loc_lConfirmou, loc_oErro, loc_lContinuar

*-- Linhas 7896 a 7918:
7896:             IF loc_lContinuar
7897:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta linha de subcomposi" + CHR(231) + CHR(227) + "o?", "Confirmar")
7898:                 IF loc_lConfirmou AND gnConnHandle > 0
7899:                     SELECT cursor_4c_SubCp
7900:                     loc_cMats = ALLTRIM(Mats)
7901:                     loc_nRet  = SQLEXEC(gnConnHandle, ;
7902:                         "DELETE FROM SigPrScp WHERE CPros = " + EscaparSQL(PADR(ALLTRIM(this_cCodigo), 14)) + ;
7903:                         " AND Mats = " + EscaparSQL(PADR(loc_cMats, 14)))
7904:                     THIS.CarregarComposicao()
7905:                 ENDIF
7906:             ENDIF
7907:         CATCH TO loc_oErro
7908:             MsgErro(loc_oErro.Message, "Erro ao excluir subcomposi" + CHR(231) + CHR(227) + "o")
7909:         ENDTRY
7910:     ENDPROC
7911: 
7912:     *==========================================================================
7913:     * Helpers de composicao (PROTECTED)
7914:     *==========================================================================
7915:     PROTECTED PROCEDURE AbrirLookupMoedaComp(par_oTextBox)
7916:         LOCAL loc_oBusca, loc_cCodigo, loc_oErro
7917:         TRY
7918:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0

*-- Linhas 7949 a 7969:
7949:             IF EMPTY(loc_cCod)
7950:                 RETURN
7951:             ENDIF
7952:             loc_nRet = SQLEXEC(gnConnHandle, ;
7953:                 "SELECT CodFinPs FROM SigPrFti WHERE CodFinPs = " + ;
7954:                 EscaparSQL(PADR(loc_cCod, 5)), ;
7955:                 "cursor_4c_ValFtio")
7956:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_ValFtio") = 0
7957:                 loc_oPg.txt_4c_Ftio.Value = ""
7958:             ENDIF
7959:             IF USED("cursor_4c_ValFtio")
7960:                 USE IN cursor_4c_ValFtio
7961:             ENDIF
7962:         CATCH TO loc_oErro
7963:             MsgErro(loc_oErro.Message, "Erro ao validar feitio")
7964:         ENDTRY
7965:     ENDPROC
7966: 
7967:     PROTECTED PROCEDURE ValidarCmkpc()
7968:         LOCAL loc_oPg, loc_cCod, loc_nRet, loc_oErro
7969:         TRY

*-- Linhas 7975 a 7995:
7975:             IF EMPTY(loc_cCod)
7976:                 RETURN
7977:             ENDIF
7978:             loc_nRet = SQLEXEC(gnConnHandle, ;
7979:                 "SELECT CodFinPs FROM SigPrFti WHERE CodFinPs = " + ;
7980:                 EscaparSQL(PADR(loc_cCod, 5)), ;
7981:                 "cursor_4c_ValCmkpc")
7982:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_ValCmkpc") = 0
7983:                 loc_oPg.txt_4c_Cmkpc.Value = ""
7984:             ENDIF
7985:             IF USED("cursor_4c_ValCmkpc")
7986:                 USE IN cursor_4c_ValCmkpc
7987:             ENDIF
7988:         CATCH TO loc_oErro
7989:             MsgErro(loc_oErro.Message, "Erro ao validar markup custo")
7990:         ENDTRY
7991:     ENDPROC
7992: 
7993:     *==========================================================================
7994:     * CarregarCusto - Carrega SigPrCpo filtrado por Tipos para pgCusto
7995:     *==========================================================================

*-- Linhas 8016 a 8111:
8016:             IF USED("cursor_4c_CustoCompoTemp")
8017:                 USE IN cursor_4c_CustoCompoTemp
8018:             ENDIF
8019:             loc_cSQL = "SELECT c.Mats, ISNULL(p.DPros,'') AS DPros, " + ;
8020:                        "       c.Unisp, c.Vals, c.Qtds, c.Totals, c.Moedas, " + ;
8021:                        "       ISNULL(c.Obss,'') AS Obss, ISNULL(c.Es,'') AS Es, " + ;
8022:                        "       c.Conss, c.Qtdss, ISNULL(c.Unis,'') AS Unis, " + ;
8023:                        "       ISNULL(p.CGrus,'') AS CGrus, ISNULL(c.Bloqueio,'') AS Bloqueio " + ;
8024:                        "FROM SigPrCpo c " + ;
8025:                        "LEFT JOIN SigCdPro p ON p.CPros = c.Mats " + ;
8026:                        "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
8027:             IF loc_nTipo > 0
8028:                 loc_cSQL = loc_cSQL + " AND ISNULL(c.Tipos, 0) = " + LTRIM(STR(loc_nTipo))
8029:             ENDIF
8030:             loc_cSQL = loc_cSQL + " ORDER BY c.Ords"
8031: 
8032:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CustoCompoTemp")
8033:             IF loc_nRet > 0
8034:                 SELECT cursor_4c_CustoCompo
8035:                 ZAP
8036:                 APPEND FROM DBF("cursor_4c_CustoCompoTemp")
8037:                 IF USED("cursor_4c_CustoCompoTemp")
8038:                     USE IN cursor_4c_CustoCompoTemp
8039:                 ENDIF
8040:                 SELECT cursor_4c_CustoCompo
8041:                 GO TOP
8042:             ENDIF
8043: 
8044:             *-- Carregar resumo por grupo (GradeGRUPO2)
8045:             IF USED("cursor_4c_GrupoCompo2Temp")
8046:                 USE IN cursor_4c_GrupoCompo2Temp
8047:             ENDIF
8048:             loc_cSQL = "SELECT ISNULL(p.CGrus,'') AS CGrus, " + ;
8049:                        "       SUM(c.Totals) AS Totals, MIN(c.Moedas) AS Moedas " + ;
8050:                        "FROM SigPrCpo c " + ;
8051:                        "LEFT JOIN SigCdPro p ON p.CPros = c.Mats " + ;
8052:                        "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
8053:             IF loc_nTipo > 0
8054:                 loc_cSQL = loc_cSQL + " AND ISNULL(c.Tipos, 0) = " + LTRIM(STR(loc_nTipo))
8055:             ENDIF
8056:             loc_cSQL = loc_cSQL + " GROUP BY p.CGrus ORDER BY p.CGrus"
8057: 
8058:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoCompo2Temp")
8059:             IF loc_nRet > 0
8060:                 SELECT cursor_4c_GrupoCompo2
8061:                 ZAP
8062:                 APPEND FROM DBF("cursor_4c_GrupoCompo2Temp")
8063:                 IF USED("cursor_4c_GrupoCompo2Temp")
8064:                     USE IN cursor_4c_GrupoCompo2Temp
8065:                 ENDIF
8066:                 SELECT cursor_4c_GrupoCompo2
8067:                 GO TOP
8068:             ENDIF
8069: 
8070:             *-- Refresh grids
8071:             loc_oPgCusto.grd_4c_GrdCustoCompo.Refresh()
8072:             loc_oPgCusto.grd_4c_GrupoCompo2.Refresh()
8073: 
8074:         CATCH TO loc_oErro
8075:             MsgErro(loc_oErro.Message, "Erro ao carregar custo")
8076:         ENDTRY
8077:     ENDPROC
8078: 
8079:     *==========================================================================
8080:     * Handlers da pagina Custo (PUBLIC - obrigatorio para BINDEVENT)
8081:     *==========================================================================
8082:     PROCEDURE GrdCustoCompoAfterRowColChange(par_nColIndex)
8083:         LOCAL loc_oPg, loc_cSQL, loc_nRet, loc_cGrus, loc_cDGrus, loc_oErro
8084:         TRY
8085:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page6
8086:             IF USED("cursor_4c_CustoCompo") AND !EOF("cursor_4c_CustoCompo")
8087:                 SELECT cursor_4c_CustoCompo
8088:                 loc_oPg.txt_4c_DescCus.Value  = ALLTRIM(DPros)
8089:                 loc_cGrus = ALLTRIM(CGrus)
8090:                 *-- Buscar descricao do grupo
8091:                 IF !EMPTY(loc_cGrus) AND gnConnHandle > 0
8092:                     IF USED("cursor_4c_GruCusto")
8093:                         USE IN cursor_4c_GruCusto
8094:                     ENDIF
8095:                     loc_cSQL = "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(PADR(loc_cGrus, 10))
8096:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruCusto")
8097:                     IF loc_nRet > 0 AND !EOF("cursor_4c_GruCusto")
8098:                         loc_cDGrus = ALLTRIM(cursor_4c_GruCusto.DGrus)
8099:                     ELSE
8100:                         loc_cDGrus = ""
8101:                     ENDIF
8102:                     IF USED("cursor_4c_GruCusto")
8103:                         USE IN cursor_4c_GruCusto
8104:                     ENDIF
8105:                     loc_oPg.txt_4c_DGruCompos.Value = loc_cDGrus
8106:                 ELSE
8107:                     loc_oPg.txt_4c_DGruCompos.Value = ""
8108:                 ENDIF
8109:             ENDIF
8110:         CATCH TO loc_oErro
8111:             *-- Tolerado

*-- Linhas 8142 a 8162:
8142:                 IF VARTYPE(loc_oPgCusto.cbo_4c_CmbTipos.Value) = "N"
8143:                     loc_nTipo = INT(loc_oPgCusto.cbo_4c_CmbTipos.Value)
8144:                 ENDIF
8145:                 loc_nRet = SQLEXEC(gnConnHandle, ;
8146:                     "INSERT INTO SigPrCpo (CPros, DtMovs, cIdChaves, Tipos) " + ;
8147:                     "VALUES (" + EscaparSQL(PADR(loc_cCPros, 14)) + ;
8148:                     ", GETDATE(), NEWID(), " + LTRIM(STR(loc_nTipo)) + ")")
8149:                 IF loc_nRet < 1
8150:                     MsgErro("Erro ao incluir linha de custo.", "Erro")
8151:                 ELSE
8152:                     THIS.CarregarCusto()
8153:                 ENDIF
8154:             ENDIF
8155:         CATCH TO loc_oErro
8156:             MsgErro(loc_oErro.Message, "Erro ao incluir linha de custo")
8157:         ENDTRY
8158:     ENDPROC
8159: 
8160:     PROCEDURE CustoCompoExcluirClick()
8161:         LOCAL loc_nRet, loc_cMats, loc_lConfirmou, loc_oErro, loc_lContinuar
8162:         loc_lContinuar = .T.

*-- Linhas 8174 a 8232:
8174:             IF loc_lContinuar
8175:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta linha de custo?", "Confirmar")
8176:                 IF loc_lConfirmou AND gnConnHandle > 0
8177:                     SELECT cursor_4c_CustoCompo
8178:                     loc_cMats = ALLTRIM(Mats)
8179:                     loc_nRet  = SQLEXEC(gnConnHandle, ;
8180:                         "DELETE FROM SigPrCpo WHERE CPros = " + EscaparSQL(PADR(ALLTRIM(this_cCodigo), 14)) + ;
8181:                         " AND Mats = " + EscaparSQL(PADR(loc_cMats, 14)))
8182:                     THIS.CarregarCusto()
8183:                 ENDIF
8184:             ENDIF
8185:         CATCH TO loc_oErro
8186:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de custo")
8187:         ENDTRY
8188:     ENDPROC
8189: 
8190:     *==========================================================================
8191:     * ConfigurarPgPgDadosConsP - PgDadosConsP (Page5 do pgf_4c_DadosInterno)
8192:     * Cons P: GrdCons (9 colunas), Getqtcpnt, chkFund, grDTEMP (2 colunas)
8193:     * Posicoes: original_top + 29
8194:     *==========================================================================
8195:     PROTECTED PROCEDURE ConfigurarPgPgDadosConsP(par_oPage)
8196:         LOCAL loc_oGrd, loc_oErro
8197:         TRY
8198:             *-- === Cursores placeholder ANTES dos grids ===
8199:             SET NULL ON
8200:             IF USED("cursor_4c_ConsP")
8201:                 USE IN cursor_4c_ConsP
8202:             ENDIF
8203:             CREATE CURSOR cursor_4c_ConsP (;
8204:                 Mats   C(14)   NULL, ;
8205:                 Qtds   N(15,6) NULL, ;
8206:                 Unisp  C(5)    NULL, ;
8207:                 Grupos C(10)   NULL, ;
8208:                 Descrs C(50)   NULL, ;
8209:                 Ordems N(5,0)  NULL, ;
8210:                 Conss  N(15,6) NULL, ;
8211:                 Ccats  C(10)   NULL, ;
8212:                 DCats  C(50)   NULL  ;
8213:             )
8214:             IF USED("cursor_4c_DTemp")
8215:                 USE IN cursor_4c_DTemp
8216:             ENDIF
8217:             CREATE CURSOR cursor_4c_DTemp (;
8218:                 Grupos C(10)   NULL, ;
8219:                 TempoP N(10,2) NULL  ;
8220:             )
8221:             SET NULL OFF
8222: 
8223:             *-- === Say7: label "Qtde Componentes :" - top=523+29=552, left=25 ===
8224:             par_oPage.AddObject("lbl_4c_Label7", "Label")
8225:             WITH par_oPage.lbl_4c_Label7
8226:                 .Top       = 552
8227:                 .Left      = 25
8228:                 .Width     = 105
8229:                 .Height    = 15
8230:                 .FontName  = "Tahoma"
8231:                 .FontSize  = 8
8232:                 .BackStyle = 0

*-- Linhas 8288 a 8398:
8288:             loc_oGrd.FontName    = "Tahoma"
8289:             loc_oGrd.FontSize    = 8
8290:             loc_oGrd.GridLines   = 3
8291:             loc_oGrd.DeleteMark  = .F.
8292:             loc_oGrd.RecordMark  = .F.
8293:             loc_oGrd.RowHeight   = 16
8294:             loc_oGrd.ScrollBars  = 3
8295:             loc_oGrd.Themes      = .F.
8296:             loc_oGrd.Visible     = .T.
8297: 
8298:             loc_oGrd.RecordSource = "cursor_4c_ConsP"
8299: 
8300:             loc_oGrd.Column1.Header1.Caption  = "Componente"
8301:             loc_oGrd.Column1.ControlSource    = "cursor_4c_ConsP.Mats"
8302:             loc_oGrd.Column1.Width            = 100
8303:             loc_oGrd.Column1.ReadOnly         = .T.
8304:             loc_oGrd.Column1.Header1.FontBold = .T.
8305: 
8306:             loc_oGrd.Column2.Header1.Caption  = "Qtde."
8307:             loc_oGrd.Column2.ControlSource    = "cursor_4c_ConsP.Qtds"
8308:             loc_oGrd.Column2.Width            = 65
8309:             loc_oGrd.Column2.ReadOnly         = .T.
8310:             loc_oGrd.Column2.Header1.FontBold = .T.
8311: 
8312:             loc_oGrd.Column3.Header1.Caption  = "Uni"
8313:             loc_oGrd.Column3.ControlSource    = "cursor_4c_ConsP.Unisp"
8314:             loc_oGrd.Column3.Width            = 45
8315:             loc_oGrd.Column3.ReadOnly         = .T.
8316:             loc_oGrd.Column3.Header1.FontBold = .T.
8317: 
8318:             loc_oGrd.Column4.Header1.Caption  = "Fase"
8319:             loc_oGrd.Column4.ControlSource    = "cursor_4c_ConsP.Grupos"
8320:             loc_oGrd.Column4.Width            = 65
8321:             loc_oGrd.Column4.Header1.FontBold = .T.
8322: 
8323:             loc_oGrd.Column5.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
8324:             loc_oGrd.Column5.ControlSource    = "cursor_4c_ConsP.Descrs"
8325:             loc_oGrd.Column5.Width            = 200
8326:             loc_oGrd.Column5.Header1.FontBold = .T.
8327: 
8328:             loc_oGrd.Column6.Header1.Caption  = "Ord."
8329:             loc_oGrd.Column6.ControlSource    = "cursor_4c_ConsP.Ordems"
8330:             loc_oGrd.Column6.Width            = 40
8331:             loc_oGrd.Column6.ReadOnly         = .T.
8332:             loc_oGrd.Column6.Header1.FontBold = .T.
8333: 
8334:             loc_oGrd.Column7.Header1.Caption  = "Consumo"
8335:             loc_oGrd.Column7.ControlSource    = "cursor_4c_ConsP.Conss"
8336:             loc_oGrd.Column7.Width            = 80
8337:             loc_oGrd.Column7.Header1.FontBold = .T.
8338: 
8339:             loc_oGrd.Column8.Header1.Caption  = "Cat."
8340:             loc_oGrd.Column8.ControlSource    = "cursor_4c_ConsP.Ccats"
8341:             loc_oGrd.Column8.Width            = 60
8342:             loc_oGrd.Column8.Header1.FontBold = .T.
8343: 
8344:             loc_oGrd.Column9.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
8345:             loc_oGrd.Column9.ControlSource    = "cursor_4c_ConsP.DCats"
8346:             loc_oGrd.Column9.Width            = 150
8347:             loc_oGrd.Column9.ReadOnly         = .T.
8348:             loc_oGrd.Column9.Header1.FontBold = .T.
8349: 
8350:             *-- BINDEVENT para colunas editaveis (F4=115 dispara lookup)
8351:             BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
8352:             BINDEVENT(loc_oGrd.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
8353:             BINDEVENT(loc_oGrd.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")
8354: 
8355:             *-- === grDTEMP - top=519+29=548, left=821, w=172, h=107, 2 colunas ===
8356:             par_oPage.AddObject("grd_4c_GrDTEMP", "Grid")
8357:             WITH par_oPage.grd_4c_GrDTEMP
8358:                 .Top         = 548
8359:                 .Left        = 821
8360:                 .Width       = 172
8361:                 .Height      = 107
8362:                 .ColumnCount = 2
8363:                 .FontName    = "Tahoma"
8364:                 .FontSize    = 8
8365:                 .GridLines   = 3
8366:                 .DeleteMark  = .F.
8367:                 .RecordMark  = .F.
8368:                 .RowHeight   = 16
8369:                 .ScrollBars  = 3
8370:                 .Themes      = .F.
8371:                 .Visible     = .T.
8372:             ENDWITH
8373: 
8374:             par_oPage.grd_4c_GrDTEMP.RecordSource = "cursor_4c_DTemp"
8375: 
8376:             par_oPage.grd_4c_GrDTEMP.Column1.Header1.Caption  = "Agrupamento"
8377:             par_oPage.grd_4c_GrDTEMP.Column1.ControlSource    = "cursor_4c_DTemp.Grupos"
8378:             par_oPage.grd_4c_GrDTEMP.Column1.Width            = 90
8379:             par_oPage.grd_4c_GrDTEMP.Column1.ReadOnly         = .T.
8380:             par_oPage.grd_4c_GrDTEMP.Column1.Header1.FontBold = .T.
8381: 
8382:             par_oPage.grd_4c_GrDTEMP.Column2.Header1.Caption  = "Tempo %"
8383:             par_oPage.grd_4c_GrDTEMP.Column2.ControlSource    = "cursor_4c_DTemp.TempoP"
8384:             par_oPage.grd_4c_GrDTEMP.Column2.Width            = 70
8385:             par_oPage.grd_4c_GrDTEMP.Column2.ReadOnly         = .T.
8386:             par_oPage.grd_4c_GrDTEMP.Column2.Header1.FontBold = .T.
8387: 
8388:         CATCH TO loc_oErro
8389:             MsgErro(loc_oErro.Message, "Erro ao configurar p" + CHR(225) + "gina ConsP")
8390:         ENDTRY
8391:     ENDPROC
8392: 
8393:     *==========================================================================
8394:     * CarregarConsP - Carrega SigPrCpo com fase (SigCdPrf) e cat (SigCdCat)
8395:     *==========================================================================
8396:     PROCEDURE CarregarConsP()
8397:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgConsP, loc_oErro, loc_lContinuar
8398:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0

*-- Linhas 8410 a 8476:
8410:                 IF USED("cursor_4c_ConsPTemp")
8411:                     USE IN cursor_4c_ConsPTemp
8412:                 ENDIF
8413:                 loc_cSQL = "SELECT c.Mats, ISNULL(c.Qtds,0) AS Qtds, " + ;
8414:                            "       ISNULL(c.Unisp,'') AS Unisp, " + ;
8415:                            "       ISNULL(c.Grupos,'') AS Grupos, " + ;
8416:                            "       ISNULL(f.Descrs,'') AS Descrs, " + ;
8417:                            "       ISNULL(c.Ordems,0) AS Ordems, " + ;
8418:                            "       ISNULL(c.Conss,0) AS Conss, " + ;
8419:                            "       ISNULL(c.Ccats,'') AS Ccats, " + ;
8420:                            "       ISNULL(cat.Descs,'') AS DCats " + ;
8421:                            "FROM SigPrCpo c " + ;
8422:                            "LEFT JOIN SigCdPrf f ON f.Grupos = c.Grupos " + ;
8423:                            "                     AND f.Ordems = c.Ordems " + ;
8424:                            "LEFT JOIN SigCdCat cat ON LTRIM(RTRIM(cat.Cods)) = LTRIM(RTRIM(c.Ccats)) " + ;
8425:                            "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
8426:                            " ORDER BY c.Ordems, c.Mats"
8427:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPTemp")
8428:                 IF loc_nRet > 0
8429:                     SELECT cursor_4c_ConsP
8430:                     ZAP
8431:                     APPEND FROM DBF("cursor_4c_ConsPTemp")
8432:                     IF USED("cursor_4c_ConsPTemp")
8433:                         USE IN cursor_4c_ConsPTemp
8434:                     ENDIF
8435:                     SELECT cursor_4c_ConsP
8436:                     GO TOP
8437: 
8438:                     loc_oPgConsP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page5
8439:                     loc_oPgConsP.txt_4c_Qtcpnt.Value = LTRIM(STR(RECCOUNT("cursor_4c_ConsP")))
8440:                     loc_oPgConsP.grd_4c_GrdCons.Refresh()
8441:                 ENDIF
8442: 
8443:                 *-- Carregar DTemp (consumo agrupado por fase/grupo)
8444:                 IF USED("cursor_4c_DTempLoad")
8445:                     USE IN cursor_4c_DTempLoad
8446:                 ENDIF
8447:                 loc_cSQL = "SELECT ISNULL(c.Grupos,'') AS Grupos, " + ;
8448:                            "       ISNULL(SUM(c.Conss),0) AS TempoP " + ;
8449:                            "FROM SigPrCpo c " + ;
8450:                            "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
8451:                            "  AND c.Grupos IS NOT NULL AND LTRIM(RTRIM(c.Grupos)) <> '' " + ;
8452:                            "GROUP BY c.Grupos ORDER BY c.Grupos"
8453:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DTempLoad")
8454:                 IF loc_nRet > 0
8455:                     SELECT cursor_4c_DTemp
8456:                     ZAP
8457:                     APPEND FROM DBF("cursor_4c_DTempLoad")
8458:                     IF USED("cursor_4c_DTempLoad")
8459:                         USE IN cursor_4c_DTempLoad
8460:                     ENDIF
8461:                     SELECT cursor_4c_DTemp
8462:                     GO TOP
8463:                     IF VARTYPE(loc_oPgConsP) = "O"
8464:                         loc_oPgConsP.grd_4c_GrDTEMP.Refresh()
8465:                     ENDIF
8466:                 ENDIF
8467:             ENDIF
8468: 
8469:         CATCH TO loc_oErro
8470:             MsgErro(loc_oErro.Message, "Erro ao carregar ConsP")
8471:         ENDTRY
8472:     ENDPROC
8473: 
8474:     *==========================================================================
8475:     * GrdConsCol4KeyPress - F4 em Column4 (Fase) abre lookup SigCdPrf
8476:     *==========================================================================

*-- Linhas 8637 a 8666:
8637:             IF USED("cursor_4c_PrfFase")
8638:                 USE IN cursor_4c_PrfFase
8639:             ENDIF
8640:             CREATE CURSOR cursor_4c_PrfFase (;
8641:                 CIdChaves C(20)  NULL, ;
8642:                 Ordems    N(2,0) NULL, ;
8643:                 Grupos    C(10)  NULL, ;
8644:                 Descrs    C(50)  NULL, ;
8645:                 UniPrdts  C(10)  NULL, ;
8646:                 MatPrdts  C(15)  NULL  ;
8647:             )
8648:             IF USED("cursor_4c_Mtz")
8649:                 USE IN cursor_4c_Mtz
8650:             ENDIF
8651:             CREATE CURSOR cursor_4c_Mtz (;
8652:                 CIdChaves C(20)  NULL, ;
8653:                 CMats     C(14)  NULL, ;
8654:                 DPros     C(65)  NULL, ;
8655:                 Locals    C(10)  NULL, ;
8656:                 Qtds      N(3,0) NULL  ;
8657:             )
8658:             SET NULL OFF
8659: 
8660:             *-- === Shape fundo imagem fase (shpFig, top=152+29=181, left=231, w=244, h=148) ===
8661:             par_oPage.AddObject("shp_4c_ShpFig", "Shape")
8662:             WITH par_oPage.shp_4c_ShpFig
8663:                 .Top    = 181
8664:                 .Left   = 231
8665:                 .Width  = 244
8666:                 .Height = 148

*-- Linhas 9022 a 9071:
9022:             loc_oGrd.FontName    = "Tahoma"
9023:             loc_oGrd.FontSize    = 8
9024:             loc_oGrd.GridLines   = 3
9025:             loc_oGrd.DeleteMark  = .F.
9026:             loc_oGrd.RecordMark  = .F.
9027:             loc_oGrd.RowHeight   = 16
9028:             loc_oGrd.ScrollBars  = 3
9029:             loc_oGrd.Themes      = .F.
9030:             loc_oGrd.Visible     = .T.
9031: 
9032:             loc_oGrd.RecordSource = "cursor_4c_PrfFase"
9033: 
9034:             loc_oGrd.Column1.Header1.Caption  = "Ordem"
9035:             loc_oGrd.Column1.ControlSource    = "cursor_4c_PrfFase.Ordems"
9036:             loc_oGrd.Column1.Width            = 40
9037:             loc_oGrd.Column1.Header1.FontBold = .T.
9038: 
9039:             loc_oGrd.Column2.Header1.Caption  = "Fase"
9040:             loc_oGrd.Column2.ControlSource    = "cursor_4c_PrfFase.Grupos"
9041:             loc_oGrd.Column2.Width            = 70
9042:             loc_oGrd.Column2.Header1.FontBold = .T.
9043: 
9044:             loc_oGrd.Column3.Header1.Caption  = "Utiliza" + CHR(231) + CHR(227) + "o"
9045:             loc_oGrd.Column3.ControlSource    = "cursor_4c_PrfFase.Descrs"
9046:             loc_oGrd.Column3.Width            = 160
9047:             loc_oGrd.Column3.ReadOnly         = .T.
9048:             loc_oGrd.Column3.Header1.FontBold = .T.
9049: 
9050:             loc_oGrd.Column4.Header1.Caption  = "Uni. Produtiva"
9051:             loc_oGrd.Column4.ControlSource    = "cursor_4c_PrfFase.UniPrdts"
9052:             loc_oGrd.Column4.Width            = 75
9053:             loc_oGrd.Column4.Header1.FontBold = .T.
9054: 
9055:             loc_oGrd.Column5.Header1.Caption  = "Material"
9056:             loc_oGrd.Column5.ControlSource    = "cursor_4c_PrfFase.MatPrdts"
9057:             loc_oGrd.Column5.Width            = 75
9058:             loc_oGrd.Column5.Header1.FontBold = .T.
9059: 
9060:             *-- BINDEVENTs para GradFase
9061:             BINDEVENT(loc_oGrd,             "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
9062:             BINDEVENT(loc_oGrd.Column1.Text1, "GotFocus",         THIS, "GradFaseCol1GotFocus")
9063:             BINDEVENT(loc_oGrd.Column1.Text1, "LostFocus",        THIS, "GradFaseCol1LostFocus")
9064:             BINDEVENT(loc_oGrd.Column2.Text1, "KeyPress",         THIS, "GradFaseCol2KeyPress")
9065:             BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress",         THIS, "GradFaseCol4KeyPress")
9066:             BINDEVENT(loc_oGrd.Column5.Text1, "KeyPress",         THIS, "GradFaseCol5KeyPress")
9067: 
9068:             *-- === Botao Incluir fase (inserir, top=152+29=181, left=950, w=40, h=40) ===
9069:             par_oPage.AddObject("cmd_4c_Incluir", "CommandButton")
9070:             WITH par_oPage.cmd_4c_Incluir
9071:                 .Top     = 181

*-- Linhas 9171 a 9216:
9171:             loc_oGrd2.FontName    = "Tahoma"
9172:             loc_oGrd2.FontSize    = 8
9173:             loc_oGrd2.GridLines   = 3
9174:             loc_oGrd2.DeleteMark  = .F.
9175:             loc_oGrd2.RecordMark  = .F.
9176:             loc_oGrd2.RowHeight   = 16
9177:             loc_oGrd2.ScrollBars  = 3
9178:             loc_oGrd2.Themes      = .F.
9179:             loc_oGrd2.Visible     = .T.
9180: 
9181:             loc_oGrd2.RecordSource = "cursor_4c_Mtz"
9182: 
9183:             loc_oGrd2.Column1.Header1.Caption  = "Matriz"
9184:             loc_oGrd2.Column1.ControlSource    = "cursor_4c_Mtz.CMats"
9185:             loc_oGrd2.Column1.Width            = 60
9186:             loc_oGrd2.Column1.Header1.FontBold = .T.
9187: 
9188:             loc_oGrd2.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
9189:             loc_oGrd2.Column2.ControlSource    = "cursor_4c_Mtz.DPros"
9190:             loc_oGrd2.Column2.Width            = 100
9191:             loc_oGrd2.Column2.ReadOnly         = .T.
9192:             loc_oGrd2.Column2.Header1.FontBold = .T.
9193: 
9194:             loc_oGrd2.Column3.Header1.Caption  = "Local"
9195:             loc_oGrd2.Column3.ControlSource    = "cursor_4c_Mtz.Locals"
9196:             loc_oGrd2.Column3.Width            = 50
9197:             loc_oGrd2.Column3.ReadOnly         = .T.
9198:             loc_oGrd2.Column3.Header1.FontBold = .T.
9199: 
9200:             loc_oGrd2.Column4.Header1.Caption  = "Qtde"
9201:             loc_oGrd2.Column4.ControlSource    = "cursor_4c_Mtz.Qtds"
9202:             loc_oGrd2.Column4.Width            = 36
9203:             loc_oGrd2.Column4.Header1.FontBold = .T.
9204: 
9205:             *-- BINDEVENTs para Matrizes
9206:             BINDEVENT(loc_oGrd2,              "AfterRowColChange", THIS, "MatrizesAfterRowColChange")
9207:             BINDEVENT(loc_oGrd2.Column1.Text1, "GotFocus",         THIS, "MatrizesCol1GotFocus")
9208:             BINDEVENT(loc_oGrd2.Column1.Text1, "KeyPress",         THIS, "MatrizesCol1KeyPress")
9209: 
9210:             *-- === Botao Inserir Matriz (btnInsereMtx, top=380+29=409, left=258, w=40, h=40) ===
9211:             par_oPage.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
9212:             WITH par_oPage.cmd_4c_BtnInsereMtx
9213:                 .Top     = 409
9214:                 .Left   = 258
9215:                 .Width   = 40
9216:                 .Height = 40

*-- Linhas 9341 a 9446:
9341:     ENDPROC
9342: 
9343:     *==========================================================================
9344:     * CarregarFaseP - SQLEXEC SigCdPrf -> cursor_4c_PrfFase
9345:     *==========================================================================
9346:     PROCEDURE CarregarFaseP()
9347:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgFaseP, loc_oErro, loc_lContinuar
9348:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9349:             RETURN
9350:         ENDIF
9351:         loc_lContinuar = .T.
9352:         TRY
9353:             loc_cCPros = ALLTRIM(this_cCodigo)
9354:             IF EMPTY(loc_cCPros)
9355:                 loc_lContinuar = .F.
9356:             ENDIF
9357:             IF loc_lContinuar
9358:                 IF USED("cursor_4c_PrfFaseTemp")
9359:                     USE IN cursor_4c_PrfFaseTemp
9360:                 ENDIF
9361:                 loc_cSQL = "SELECT prf.CIdChaves, prf.Ordems, prf.Grupos, " + ;
9362:                            "ISNULL(gcr.Descrs,'') AS Descrs, " + ;
9363:                            "ISNULL(prf.UniPrdts,'') AS UniPrdts, " + ;
9364:                            "ISNULL(prf.MatPrdts,'') AS MatPrdts " + ;
9365:                            "FROM SigCdPrf prf " + ;
9366:                            "LEFT JOIN SigCdGcr gcr ON gcr.Codigos = prf.Grupos " + ;
9367:                            "WHERE prf.Produtos = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
9368:                            " ORDER BY prf.Ordems"
9369:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfFaseTemp")
9370:                 IF loc_nRet > 0
9371:                     SELECT cursor_4c_PrfFase
9372:                     ZAP
9373:                     IF RECCOUNT("cursor_4c_PrfFaseTemp") > 0
9374:                         APPEND FROM DBF("cursor_4c_PrfFaseTemp")
9375:                     ENDIF
9376:                     IF USED("cursor_4c_PrfFaseTemp")
9377:                         USE IN cursor_4c_PrfFaseTemp
9378:                     ENDIF
9379:                     SELECT cursor_4c_PrfFase
9380:                     GO TOP
9381:                     loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9382:                     loc_oPgFaseP.grd_4c_GradFase.Refresh()
9383:                     *-- Carregar imagem da primeira linha
9384:                     THIS.GradFaseAfterRowColChange(0)
9385:                 ELSE
9386:                     IF USED("cursor_4c_PrfFaseTemp")
9387:                         USE IN cursor_4c_PrfFaseTemp
9388:                     ENDIF
9389:                 ENDIF
9390:             ENDIF
9391:         CATCH TO loc_oErro
9392:             MsgErro(loc_oErro.Message, "Erro ao carregar Fase P")
9393:         ENDTRY
9394:     ENDPROC
9395: 
9396:     *==========================================================================
9397:     * CarregarMatrizes - SQLEXEC sigprmtz -> cursor_4c_Mtz
9398:     *==========================================================================
9399:     PROCEDURE CarregarMatrizes()
9400:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgFaseP, loc_oErro, loc_lContinuar
9401:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9402:             RETURN
9403:         ENDIF
9404:         loc_lContinuar = .T.
9405:         TRY
9406:             loc_cCPros = ALLTRIM(this_cCodigo)
9407:             IF EMPTY(loc_cCPros)
9408:                 loc_lContinuar = .F.
9409:             ENDIF
9410:             IF loc_lContinuar
9411:                 IF USED("cursor_4c_MtzTemp")
9412:                     USE IN cursor_4c_MtzTemp
9413:                 ENDIF
9414:                 loc_cSQL = "SELECT mtz.CIdChaves, mtz.CMats, " + ;
9415:                            "ISNULL(pro.DPros,'') AS DPros, " + ;
9416:                            "ISNULL(pro.Locals,'') AS Locals, " + ;
9417:                            "ISNULL(mtz.Qtds,0) AS Qtds " + ;
9418:                            "FROM SigPrMtz mtz " + ;
9419:                            "LEFT JOIN SigCdPro pro ON pro.CPros = mtz.CMats " + ;
9420:                            "WHERE mtz.CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
9421:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MtzTemp")
9422:                 IF loc_nRet > 0
9423:                     SELECT cursor_4c_Mtz
9424:                     ZAP
9425:                     IF RECCOUNT("cursor_4c_MtzTemp") > 0
9426:                         APPEND FROM DBF("cursor_4c_MtzTemp")
9427:                     ENDIF
9428:                     IF USED("cursor_4c_MtzTemp")
9429:                         USE IN cursor_4c_MtzTemp
9430:                     ENDIF
9431:                     SELECT cursor_4c_Mtz
9432:                     GO TOP
9433:                     loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9434:                     loc_oPgFaseP.grd_4c_Matrizes.Refresh()
9435:                     *-- Carregar imagem da primeira matriz
9436:                     THIS.MatrizesAfterRowColChange(0)
9437:                 ELSE
9438:                     IF USED("cursor_4c_MtzTemp")
9439:                         USE IN cursor_4c_MtzTemp
9440:                     ENDIF
9441:                 ENDIF
9442:             ENDIF
9443:         CATCH TO loc_oErro
9444:             MsgErro(loc_oErro.Message, "Erro ao carregar Matrizes")
9445:         ENDTRY
9446:     ENDPROC

*-- Linhas 9462 a 9496:
9462:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase") OR BOF("cursor_4c_PrfFase")
9463:                 RETURN
9464:             ENDIF
9465:             SELECT cursor_4c_PrfFase
9466:             loc_cCIdChaves = ALLTRIM(CIdChaves)
9467:             *-- Preencher descricao da fase atual (ja carregada no cursor)
9468:             loc_oPgFaseP.txt_4c_Desc.Value = ALLTRIM(NVL(Descrs, ""))
9469:             IF EMPTY(loc_cCIdChaves)
9470:                 RETURN
9471:             ENDIF
9472:             *-- Carregar FigProcs e Obs do banco
9473:             IF USED("cursor_4c_FigPrfTmp")
9474:                 USE IN cursor_4c_FigPrfTmp
9475:             ENDIF
9476:             loc_nRet = SQLEXEC(gnConnHandle, ;
9477:                 "SELECT FigProcs, CONVERT(NVARCHAR(MAX), obs) AS ObsText " + ;
9478:                 "FROM SigCdPrf WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves), ;
9479:                 "cursor_4c_FigPrfTmp")
9480:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_FigPrfTmp") > 0
9481:                 SELECT cursor_4c_FigPrfTmp
9482:                 *-- Preencher obs
9483:                 IF !ISNULL(ObsText)
9484:                     loc_oPgFaseP.edt_4c_Get_Obs.Value = ALLTRIM(ObsText)
9485:                 ENDIF
9486:                 *-- Exibir imagem
9487:                 IF !EMPTY(FigProcs) AND !ISNULL(FigProcs)
9488:                     loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9489:                     IF STRTOFILE(FigProcs, loc_cArquivo) > 0
9490:                         loc_oPgFaseP.img_4c_ImgFigJpg.Visible = .T.
9491:                         loc_oPgFaseP.img_4c_ImgFigJpg.Picture = loc_cArquivo
9492:                     ENDIF
9493:                 ENDIF
9494:             ENDIF
9495:             IF USED("cursor_4c_FigPrfTmp")
9496:                 USE IN cursor_4c_FigPrfTmp

*-- Linhas 9507 a 9551:
9507:         LOCAL loc_oErro
9508:         TRY
9509:             IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
9510:                 SELECT cursor_4c_PrfFase
9511:                 this_nAntOrd = NVL(Ordems, 0)
9512:             ENDIF
9513:         CATCH TO loc_oErro
9514:             *-- Tolerado
9515:         ENDTRY
9516:     ENDPROC
9517: 
9518:     *==========================================================================
9519:     * GradFaseCol1LostFocus - Aplica reordenacao se Ordems mudou
9520:     *==========================================================================
9521:     PROCEDURE GradFaseCol1LostFocus()
9522:         LOCAL loc_nNovoOrd, loc_cCIdChaves, loc_nRet, loc_oErro
9523:         TRY
9524:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9525:                 RETURN
9526:             ENDIF
9527:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
9528:                 RETURN
9529:             ENDIF
9530:             SELECT cursor_4c_PrfFase
9531:             loc_nNovoOrd   = NVL(Ordems, 0)
9532:             loc_cCIdChaves = ALLTRIM(CIdChaves)
9533:             IF loc_nNovoOrd > 0 AND loc_nNovoOrd <> this_nAntOrd AND !EMPTY(loc_cCIdChaves)
9534:                 loc_nRet = SQLEXEC(gnConnHandle, ;
9535:                     "UPDATE SigCdPrf SET Ordems = " + FormatarNumeroSQL(loc_nNovoOrd) + ;
9536:                     " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
9537:                 THIS.CarregarFaseP()
9538:             ENDIF
9539:         CATCH TO loc_oErro
9540:             MsgErro(loc_oErro.Message, "Erro ao reordenar fase")
9541:         ENDTRY
9542:     ENDPROC
9543: 
9544:     *==========================================================================
9545:     * GradFaseCol2KeyPress - F4 abre lookup de Fase (SigCdGcr)
9546:     *==========================================================================
9547:     PROCEDURE GradFaseCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9548:         LOCAL loc_oErro
9549:         TRY
9550:             IF par_nKeyCode = 115
9551:                 THIS.AbrirLookupGradFaseFase()

*-- Linhas 9604 a 9642:
9604:             IF loc_lContinuar AND gnConnHandle > 0
9605:                 *-- Calcular proximo Ordems
9606:                 IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
9607:                     SELECT cursor_4c_PrfFase
9608:                     loc_cGrupos = ALLTRIM(Grupos)
9609:                     GO BOTTOM
9610:                     loc_nOrdems = NVL(Ordems, 0) + 1
9611:                     GO TOP
9612:                 ELSE
9613:                     loc_cGrupos = ""
9614:                     loc_nOrdems = 1
9615:                 ENDIF
9616:                 loc_nRet = SQLEXEC(gnConnHandle, ;
9617:                     "INSERT INTO SigCdPrf (Produtos, Ordems, Grupos, CIdChaves) VALUES (" + ;
9618:                     EscaparSQL(PADR(loc_cCPros, 14)) + ", " + ;
9619:                     FormatarNumeroSQL(loc_nOrdems) + ", " + ;
9620:                     EscaparSQL(PADR(loc_cGrupos, 10)) + ", NEWID())")
9621:                 IF loc_nRet < 1
9622:                     MsgErro("Erro ao incluir linha de fase.", "Erro")
9623:                 ELSE
9624:                     THIS.CarregarFaseP()
9625:                     *-- Posicionar na nova linha (ultima)
9626:                     IF USED("cursor_4c_PrfFase")
9627:                         SELECT cursor_4c_PrfFase
9628:                         GO BOTTOM
9629:                     ENDIF
9630:                 ENDIF
9631:             ENDIF
9632:         CATCH TO loc_oErro
9633:             MsgErro(loc_oErro.Message, "Erro ao incluir fase")
9634:         ENDTRY
9635:     ENDPROC
9636: 
9637:     *==========================================================================
9638:     * FasePExcluirClick - Exclui linha atual de GradFase (SigCdPrf)
9639:     *==========================================================================
9640:     PROCEDURE FasePExcluirClick()
9641:         LOCAL loc_nRet, loc_cCIdChaves, loc_lConfirmou, loc_oErro, loc_lContinuar
9642:         loc_lContinuar = .T.

*-- Linhas 9651 a 9679:
9651:                 ENDIF
9652:             ENDIF
9653:             IF loc_lContinuar
9654:                 SELECT cursor_4c_PrfFase
9655:                 loc_cCIdChaves = ALLTRIM(CIdChaves)
9656:                 IF EMPTY(loc_cCIdChaves)
9657:                     loc_lContinuar = .F.
9658:                 ENDIF
9659:             ENDIF
9660:             IF loc_lContinuar
9661:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta fase?", "Confirmar")
9662:                 IF loc_lConfirmou AND gnConnHandle > 0
9663:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9664:                         "DELETE FROM SigCdPrf WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
9665:                     THIS.CarregarFaseP()
9666:                 ENDIF
9667:             ENDIF
9668:         CATCH TO loc_oErro
9669:             MsgErro(loc_oErro.Message, "Erro ao excluir fase")
9670:         ENDTRY
9671:     ENDPROC
9672: 
9673:     *==========================================================================
9674:     * FasePAlternativaClick - Insere fase alternativa (copia grupos da atual)
9675:     *==========================================================================
9676:     PROCEDURE FasePAlternativaClick()
9677:         LOCAL loc_nRet, loc_cCPros, loc_cGrupos, loc_nOrdems, loc_oErro, loc_lContinuar
9678:         loc_lContinuar = .T.
9679:         TRY

*-- Linhas 9694 a 9729:
9694:                 ENDIF
9695:             ENDIF
9696:             IF loc_lContinuar AND gnConnHandle > 0
9697:                 SELECT cursor_4c_PrfFase
9698:                 loc_cGrupos = ALLTRIM(Grupos)
9699:                 loc_nOrdems = NVL(Ordems, 0)
9700:                 *-- Inserir alternativa logo apos a atual (Ordems atual + 0.5 => usa Ordems+1 e reordena depois)
9701:                 GO BOTTOM
9702:                 loc_nOrdems = NVL(Ordems, 0) + 1
9703:                 GO TOP
9704:                 loc_nRet = SQLEXEC(gnConnHandle, ;
9705:                     "INSERT INTO SigCdPrf (Produtos, Ordems, Grupos, CIdChaves) VALUES (" + ;
9706:                     EscaparSQL(PADR(loc_cCPros, 14)) + ", " + ;
9707:                     FormatarNumeroSQL(loc_nOrdems) + ", " + ;
9708:                     EscaparSQL(PADR(loc_cGrupos, 10)) + ", NEWID())")
9709:                 IF loc_nRet < 1
9710:                     MsgErro("Erro ao incluir alternativa de fase.", "Erro")
9711:                 ELSE
9712:                     THIS.CarregarFaseP()
9713:                     IF USED("cursor_4c_PrfFase")
9714:                         SELECT cursor_4c_PrfFase
9715:                         GO BOTTOM
9716:                     ENDIF
9717:                 ENDIF
9718:             ENDIF
9719:         CATCH TO loc_oErro
9720:             MsgErro(loc_oErro.Message, "Erro ao incluir alternativa de fase")
9721:         ENDTRY
9722:     ENDPROC
9723: 
9724:     *==========================================================================
9725:     * FasePCmdFichaClick - Ficha tecnica da fase (relatorio legado)
9726:     *==========================================================================
9727:     PROCEDURE FasePCmdFichaClick()
9728:         LOCAL loc_oErro
9729:         TRY

*-- Linhas 9766 a 9797:
9766:                 ENDIF
9767:             ENDIF
9768:             IF loc_lContinuar
9769:                 SELECT cursor_4c_PrfFase
9770:                 loc_cCIdChaves = ALLTRIM(CIdChaves)
9771:                 IF EMPTY(loc_cCIdChaves)
9772:                     loc_lContinuar = .F.
9773:                 ENDIF
9774:             ENDIF
9775:             IF loc_lContinuar AND gnConnHandle > 0
9776:                 loc_cArquivo = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Selecionar imagem")
9777:                 IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
9778:                     loc_cDados = FILETOSTR(loc_cArquivo)
9779:                     IF !EMPTY(loc_cDados)
9780:                         loc_nRet = SQLEXEC(gnConnHandle, ;
9781:                             "UPDATE SigCdPrf SET FigProcs = " + EscaparSQL(loc_cDados) + ;
9782:                             " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
9783:                         IF loc_nRet > 0
9784:                             *-- Exibir imagem
9785:                             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9786:                             loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
9787:                             IF STRTOFILE(loc_cDados, loc_cArqTemp) > 0
9788:                                 loc_oPgFaseP.img_4c_ImgFigJpg.Visible = .T.
9789:                                 loc_oPgFaseP.img_4c_ImgFigJpg.Picture = loc_cArqTemp
9790:                             ENDIF
9791:                         ENDIF
9792:                     ENDIF
9793:                 ENDIF
9794:             ENDIF
9795:         CATCH TO loc_oErro
9796:             MsgErro(loc_oErro.Message, "Erro ao carregar imagem da fase")
9797:         ENDTRY

*-- Linhas 9824 a 9855:
9824:             IF !USED("cursor_4c_Mtz") OR EOF("cursor_4c_Mtz") OR BOF("cursor_4c_Mtz")
9825:                 RETURN
9826:             ENDIF
9827:             SELECT cursor_4c_Mtz
9828:             loc_cCMats = ALLTRIM(CMats)
9829:             IF EMPTY(loc_cCMats)
9830:                 RETURN
9831:             ENDIF
9832:             *-- Buscar imagem do produto matriz
9833:             IF USED("cursor_4c_MtzImgTmp")
9834:                 USE IN cursor_4c_MtzImgTmp
9835:             ENDIF
9836:             loc_nRet = SQLEXEC(gnConnHandle, ;
9837:                 "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + EscaparSQL(PADR(loc_cCMats, 14)), ;
9838:                 "cursor_4c_MtzImgTmp")
9839:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_MtzImgTmp") > 0
9840:                 SELECT cursor_4c_MtzImgTmp
9841:                 IF !EMPTY(FigJpgs) AND !ISNULL(FigJpgs)
9842:                     loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9843:                     IF STRTOFILE(FigJpgs, loc_cArquivo) > 0
9844:                         loc_oPgFaseP.img_4c_ImgBorracha.Visible = .T.
9845:                         loc_oPgFaseP.img_4c_ImgBorracha.Picture = loc_cArquivo
9846:                     ENDIF
9847:                 ENDIF
9848:             ENDIF
9849:             IF USED("cursor_4c_MtzImgTmp")
9850:                 USE IN cursor_4c_MtzImgTmp
9851:             ENDIF
9852:         CATCH TO loc_oErro
9853:             *-- Tolerado: exibicao de imagem nao critica
9854:         ENDTRY
9855:     ENDPROC

*-- Linhas 9902 a 9928:
9902:                 ENDIF
9903:             ENDIF
9904:             IF loc_lContinuar AND gnConnHandle > 0
9905:                 loc_nRet = SQLEXEC(gnConnHandle, ;
9906:                     "INSERT INTO SigPrMtz (CPros, CMats, Qtds, CIdChaves) VALUES (" + ;
9907:                     EscaparSQL(PADR(loc_cCPros, 14)) + ", '', 0, NEWID())")
9908:                 IF loc_nRet < 1
9909:                     MsgErro("Erro ao incluir linha de matriz.", "Erro")
9910:                 ELSE
9911:                     THIS.CarregarMatrizes()
9912:                     IF USED("cursor_4c_Mtz")
9913:                         SELECT cursor_4c_Mtz
9914:                         GO BOTTOM
9915:                     ENDIF
9916:                 ENDIF
9917:             ENDIF
9918:         CATCH TO loc_oErro
9919:             MsgErro(loc_oErro.Message, "Erro ao incluir matriz")
9920:         ENDTRY
9921:     ENDPROC
9922: 
9923:     *==========================================================================
9924:     * FasePBtnExcluiMtzClick - Exclui linha atual de grdMatrizes (SigPrMtz)
9925:     *==========================================================================
9926:     PROCEDURE FasePBtnExcluiMtzClick()
9927:         LOCAL loc_nRet, loc_cCIdChaves, loc_lConfirmou, loc_oErro, loc_lContinuar
9928:         loc_lContinuar = .T.

*-- Linhas 9937 a 9965:
9937:                 ENDIF
9938:             ENDIF
9939:             IF loc_lContinuar
9940:                 SELECT cursor_4c_Mtz
9941:                 loc_cCIdChaves = ALLTRIM(CIdChaves)
9942:                 IF EMPTY(loc_cCIdChaves)
9943:                     loc_lContinuar = .F.
9944:                 ENDIF
9945:             ENDIF
9946:             IF loc_lContinuar
9947:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta matriz?", "Confirmar")
9948:                 IF loc_lConfirmou AND gnConnHandle > 0
9949:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9950:                         "DELETE FROM SigPrMtz WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
9951:                     THIS.CarregarMatrizes()
9952:                 ENDIF
9953:             ENDIF
9954:         CATCH TO loc_oErro
9955:             MsgErro(loc_oErro.Message, "Erro ao excluir matriz")
9956:         ENDTRY
9957:     ENDPROC
9958: 
9959:     *==========================================================================
9960:     * FasePCodAcbKeyPress - F4 abre lookup de Acabamento (SigCdAca)
9961:     *==========================================================================
9962:     PROCEDURE FasePCodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
9963:         LOCAL loc_oErro
9964:         TRY
9965:             IF par_nKeyCode = 115

*-- Linhas 10045 a 10065:
10045:                     REPLACE cursor_4c_PrfFase.Descrs WITH PADR(loc_cDescrs,  50)
10046:                 ENDIF
10047:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10048:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10049:                         "UPDATE SigCdPrf SET Grupos = " + EscaparSQL(PADR(loc_cCodigos, 10)) + ;
10050:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10051:                 ENDIF
10052:                 loc_oGrd.Column2.Text1.Value = loc_cCodigos
10053:                 loc_oGrd.Column3.Text1.Value = loc_cDescrs
10054:                 loc_oGrd.Refresh()
10055:             ENDIF
10056:             IF USED("cursor_4c_BuscaGcr")
10057:                 USE IN cursor_4c_BuscaGcr
10058:             ENDIF
10059:             loc_oBusca.Release()
10060:         CATCH TO loc_oErro
10061:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de fase")
10062:         ENDTRY
10063:     ENDPROC
10064: 
10065:     *==========================================================================

*-- Linhas 10086 a 10115:
10086:             *-- Filtrar por Codigos = Grupos atual (conforme legado)
10087:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUpd", ;
10088:                 "cursor_4c_BuscaUpd", "UniPrdts", loc_cUniPrdts, "Unidade Produtiva", ;
10089:                 .F., .F., "Codigos = " + EscaparSQL(PADR(loc_cGruposUpd, 10)))
10090:             loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
10091:             loc_oBusca.Show()
10092:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd")
10093:                 loc_cUniPrdts = ALLTRIM(cursor_4c_BuscaUpd.UniPrdts)
10094:                 IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
10095:                     REPLACE cursor_4c_PrfFase.UniPrdts WITH PADR(loc_cUniPrdts, 10)
10096:                 ENDIF
10097:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10098:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10099:                         "UPDATE SigCdPrf SET UniPrdts = " + EscaparSQL(PADR(loc_cUniPrdts, 10)) + ;
10100:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10101:                 ENDIF
10102:                 loc_oGrd.Column4.Text1.Value = loc_cUniPrdts
10103:                 loc_oGrd.Refresh()
10104:             ENDIF
10105:             IF USED("cursor_4c_BuscaUpd")
10106:                 USE IN cursor_4c_BuscaUpd
10107:             ENDIF
10108:             loc_oBusca.Release()
10109:         CATCH TO loc_oErro
10110:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de unidade produtiva")
10111:         ENDTRY
10112:     ENDPROC
10113: 
10114:     *==========================================================================
10115:     * AbrirLookupGradFaseOpt - Lookup SigOpOpt para Column5 (MatPrdts)

*-- Linhas 10141 a 10161:
10141:                     REPLACE cursor_4c_PrfFase.MatPrdts WITH PADR(loc_cMatPrdts, 15)
10142:                 ENDIF
10143:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10144:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10145:                         "UPDATE SigCdPrf SET MatPrdts = " + EscaparSQL(PADR(loc_cMatPrdts, 15)) + ;
10146:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10147:                 ENDIF
10148:                 loc_oGrd.Column5.Text1.Value = loc_cMatPrdts
10149:                 loc_oGrd.Refresh()
10150:             ENDIF
10151:             IF USED("cursor_4c_BuscaOpt")
10152:                 USE IN cursor_4c_BuscaOpt
10153:             ENDIF
10154:             loc_oBusca.Release()
10155:         CATCH TO loc_oErro
10156:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de material")
10157:         ENDTRY
10158:     ENDPROC
10159: 
10160:     *==========================================================================
10161:     * AbrirLookupMatrizesCol1 - Lookup SigCdPro para Column1 de grdMatrizes

*-- Linhas 10193 a 10213:
10193:                     REPLACE cursor_4c_Mtz.Locals WITH PADR(loc_cLocals, 10)
10194:                 ENDIF
10195:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10196:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10197:                         "UPDATE SigPrMtz SET CMats = " + EscaparSQL(PADR(loc_cCMats, 14)) + ;
10198:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10199:                 ENDIF
10200:                 loc_oGrd2.Column1.Text1.Value = loc_cCMats
10201:                 loc_oGrd2.Column2.Text1.Value = loc_cDPros
10202:                 loc_oGrd2.Column3.Text1.Value = loc_cLocals
10203:                 loc_oGrd2.Refresh()
10204:                 THIS.MatrizesAfterRowColChange(0)
10205:             ENDIF
10206:             IF USED("cursor_4c_BuscaMtz")
10207:                 USE IN cursor_4c_BuscaMtz
10208:             ENDIF
10209:             loc_oBusca.Release()
10210:         CATCH TO loc_oErro
10211:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de matriz")
10212:         ENDTRY
10213:     ENDPROC

*-- Linhas 10350 a 10368:
10350:             IF USED("cursor_4c_Cmv")
10351:                 USE IN cursor_4c_Cmv
10352:             ENDIF
10353:             CREATE CURSOR cursor_4c_Cmv (;
10354:                 Periodo C(7)    NULL, ;
10355:                 ValGR   N(15,6) NULL, ;
10356:                 Moe     C(3)    NULL  ;
10357:             )
10358:             SET NULL OFF
10359: 
10360:             *-- === Say16: "Grupo C.C. :" - top=165+29=194, left=138, w=63, h=15 ===
10361:             par_oPage.AddObject("lbl_4c_Label16", "Label")
10362:             WITH par_oPage.lbl_4c_Label16
10363:                 .Top       = 194
10364:                 .Left      = 138
10365:                 .Width     = 63
10366:                 .Height    = 15
10367:                 .FontName  = "Tahoma"
10368:                 .FontSize  = 8

*-- Linhas 10398 a 10416:
10398:                 .FontSize       = 8
10399:                 .SpecialEffect  = 1
10400:                 .Themes         = .F.
10401:                 .ControlSource  = "crSigCdPro.gruccus"
10402:                 .Visible        = .T.
10403:             ENDWITH
10404: 
10405:             *-- === get_dgruccus: top=161+29=190, left=288, w=318, h=23 ===
10406:             par_oPage.AddObject("txt_4c__dgruccus", "TextBox")
10407:             WITH par_oPage.txt_4c__dgruccus
10408:                 .Top            = 190
10409:                 .Left           = 288
10410:                 .Width          = 318
10411:                 .Height         = 23
10412:                 .FontName       = "Tahoma"
10413:                 .FontSize       = 8
10414:                 .SpecialEffect  = 1
10415:                 .Themes         = .F.
10416:                 .Visible        = .T.

*-- Linhas 10427 a 10445:
10427:                 .FontSize       = 8
10428:                 .SpecialEffect  = 1
10429:                 .Themes         = .F.
10430:                 .ControlSource  = "crSigCdPro.contaccus"
10431:                 .Visible        = .T.
10432:             ENDWITH
10433: 
10434:             *-- === get_dcontaccus: top=186+29=215, left=288, w=318, h=23 ===
10435:             par_oPage.AddObject("txt_4c__dcontaccus", "TextBox")
10436:             WITH par_oPage.txt_4c__dcontaccus
10437:                 .Top            = 215
10438:                 .Left           = 288
10439:                 .Width          = 318
10440:                 .Height         = 23
10441:                 .FontName       = "Tahoma"
10442:                 .FontSize       = 8
10443:                 .SpecialEffect  = 1
10444:                 .Themes         = .F.
10445:                 .Visible        = .T.

*-- Linhas 10473 a 10491:
10473:                 .InputMask      = "9999.99.9999"
10474:                 .MaxLength      = 12
10475:                 .Themes         = .F.
10476:                 .ControlSource  = "crSigCdPro.clfiscals"
10477:                 .Visible        = .T.
10478:             ENDWITH
10479: 
10480:             *-- === getDclfiscal: top=211+29=240, left=303, w=303, h=23 ===
10481:             par_oPage.AddObject("txt_4c_Dclfiscal", "TextBox")
10482:             WITH par_oPage.txt_4c_Dclfiscal
10483:                 .Top            = 240
10484:                 .Left           = 303
10485:                 .Width          = 303
10486:                 .Height         = 23
10487:                 .FontName       = "Tahoma"
10488:                 .FontSize       = 8
10489:                 .SpecialEffect  = 1
10490:                 .Format         = "!"
10491:                 .InputMask      = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

*-- Linhas 10520 a 10538:
10520:                 .SpecialEffect  = 1
10521:                 .MaxLength      = 1
10522:                 .Themes         = .F.
10523:                 .ControlSource  = "crSigCdPro.origmercs"
10524:                 .Visible        = .T.
10525:             ENDWITH
10526: 
10527:             *-- === getDorigmerc: top=236+29=265, left=226, w=380, h=23 ===
10528:             par_oPage.AddObject("txt_4c_Dorigmerc", "TextBox")
10529:             WITH par_oPage.txt_4c_Dorigmerc
10530:                 .Top            = 265
10531:                 .Left           = 226
10532:                 .Width          = 380
10533:                 .Height         = 23
10534:                 .FontName       = "Tahoma"
10535:                 .FontSize       = 8
10536:                 .SpecialEffect  = 1
10537:                 .Format         = "!"
10538:                 .InputMask      = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

*-- Linhas 10567 a 10585:
10567:                 .SpecialEffect  = 1
10568:                 .MaxLength      = 3
10569:                 .Themes         = .F.
10570:                 .ControlSource  = "crSigCdPro.sittricms"
10571:                 .Visible        = .T.
10572:             ENDWITH
10573: 
10574:             *-- === getDsittricm: top=261+29=290, left=240, w=366, h=23 ===
10575:             par_oPage.AddObject("txt_4c_Dsittricm", "TextBox")
10576:             WITH par_oPage.txt_4c_Dsittricm
10577:                 .Top            = 290
10578:                 .Left           = 240
10579:                 .Width          = 366
10580:                 .Height         = 23
10581:                 .FontName       = "Tahoma"
10582:                 .FontSize       = 8
10583:                 .SpecialEffect  = 1
10584:                 .Format         = "!"
10585:                 .InputMask      = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

*-- Linhas 10615 a 10633:
10615:                 .InputMask      = "9999"
10616:                 .MaxLength      = 4
10617:                 .Themes         = .F.
10618:                 .ControlSource  = "crSigCdPro.CodServs"
10619:                 .Visible        = .T.
10620:             ENDWITH
10621: 
10622:             *-- === Say8: "Aliquota ICMS :" - top=291+29=320, left=250, w=76, h=15 ===
10623:             par_oPage.AddObject("lbl_4c_Label8", "Label")
10624:             WITH par_oPage.lbl_4c_Label8
10625:                 .Top       = 320
10626:                 .Left      = 250
10627:                 .Width     = 76
10628:                 .Height    = 15
10629:                 .FontName  = "Tahoma"
10630:                 .FontSize  = 8
10631:                 .BackStyle = 0
10632:                 .Caption   = "Al" + CHR(237) + "quota ICMS :"
10633:                 .ForeColor = RGB(90,90,90)

*-- Linhas 10647 a 10665:
10647:                 .InputMask      = "99.99"
10648:                 .MaxLength      = 5
10649:                 .Themes         = .F.
10650:                 .ControlSource  = "crSigCdPro.icms"
10651:                 .Visible        = .T.
10652:             ENDWITH
10653: 
10654:             *-- === Say4: "Tipo de Tributacao :" - top=291+29=320, left=395, w=98 ===
10655:             par_oPage.AddObject("lbl_4c_Label4", "Label")
10656:             WITH par_oPage.lbl_4c_Label4
10657:                 .Top       = 320
10658:                 .Left      = 395
10659:                 .Width     = 98
10660:                 .FontName  = "Tahoma"
10661:                 .FontSize  = 8
10662:                 .BackStyle = 0
10663:                 .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o :"
10664:                 .ForeColor = RGB(90,90,90)
10665:                 .Visible   = .T.

*-- Linhas 10677 a 10695:
10677:                 .SpecialEffect  = 1
10678:                 .MaxLength      = 4
10679:                 .Themes         = .F.
10680:                 .ControlSource  = "crSigCdPro.tptribs"
10681:                 .Visible        = .T.
10682:             ENDWITH
10683: 
10684:             *-- === Say41: "IAT :" - top=290+29=319, left=558, w=26, h=15 ===
10685:             par_oPage.AddObject("lbl_4c_Label41", "Label")
10686:             WITH par_oPage.lbl_4c_Label41
10687:                 .Top       = 319
10688:                 .Left      = 558
10689:                 .Width     = 26
10690:                 .Height    = 15
10691:                 .FontName  = "Tahoma"
10692:                 .FontSize  = 8
10693:                 .BackStyle = 0
10694:                 .Caption   = "IAT :"
10695:                 .ForeColor = RGB(90,90,90)

*-- Linhas 10708 a 10726:
10708:                 .SpecialEffect  = 1
10709:                 .MaxLength      = 1
10710:                 .Themes         = .F.
10711:                 .ControlSource  = "crSigCdPro.iats"
10712:                 .Visible        = .T.
10713:             ENDWITH
10714: 
10715:             *-- === Say42: "[A]rredondamento [T]runcamento" - top=290+29=319, left=609, w=165, h=15 ===
10716:             par_oPage.AddObject("lbl_4c_Label42", "Label")
10717:             WITH par_oPage.lbl_4c_Label42
10718:                 .Top       = 319
10719:                 .Left      = 609
10720:                 .Width     = 165
10721:                 .Height    = 15
10722:                 .FontName  = "Tahoma"
10723:                 .FontSize  = 8
10724:                 .BackStyle = 0
10725:                 .Caption   = "[A]rredondamento [T]runcamento"
10726:                 .ForeColor = RGB(90,90,90)

*-- Linhas 10785 a 10803:
10785:                 .InputMask      = "99.99"
10786:                 .MaxLength      = 5
10787:                 .Themes         = .F.
10788:                 .ControlSource  = "crSigCdPro.AliqIpis"
10789:                 .Visible        = .T.
10790:             ENDWITH
10791: 
10792:             *-- === Say13: "Excecao da TIPI :" - top=316+29=345, left=495, w=87, h=15 ===
10793:             par_oPage.AddObject("lbl_4c_Label13", "Label")
10794:             WITH par_oPage.lbl_4c_Label13
10795:                 .Top       = 345
10796:                 .Left      = 495
10797:                 .Width     = 87
10798:                 .Height    = 15
10799:                 .FontName  = "Tahoma"
10800:                 .FontSize  = 8
10801:                 .BackStyle = 0
10802:                 .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
10803:                 .ForeColor = RGB(90,90,90)

*-- Linhas 10817 a 10835:
10817:                 .MaxLength      = 3
10818:                 .Format         = "K"
10819:                 .Themes         = .F.
10820:                 .ControlSource  = "crSigCdPro.extipi"
10821:                 .Visible        = .T.
10822:             ENDWITH
10823: 
10824:             *-- === Say18: "Descricao Fiscal :" - top=341+29=370, left=117, w=84, h=15 ===
10825:             par_oPage.AddObject("lbl_4c_Label18", "Label")
10826:             WITH par_oPage.lbl_4c_Label18
10827:                 .Top       = 370
10828:                 .Left      = 117
10829:                 .Width     = 84
10830:                 .Height    = 15
10831:                 .FontName  = "Tahoma"
10832:                 .FontSize  = 8
10833:                 .BackStyle = 0
10834:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o Fiscal :"
10835:                 .ForeColor = RGB(90,90,90)

*-- Linhas 10859 a 10877:
10859:                 .FontSize       = 8
10860:                 .SpecialEffect  = 1
10861:                 .Themes         = .F.
10862:                 .ControlSource  = "crSigCdPro.descfis"
10863:                 .Visible        = .T.
10864:             ENDWITH
10865: 
10866:             *-- === Say9: "Valor do Grama Produzido" - top=320+29=349, left=756, w=125, h=15 ===
10867:             par_oPage.AddObject("lbl_4c_Label9", "Label")
10868:             WITH par_oPage.lbl_4c_Label9
10869:                 .Top       = 349
10870:                 .Left      = 756
10871:                 .Width     = 125
10872:                 .Height    = 15
10873:                 .FontName  = "Tahoma"
10874:                 .FontSize  = 8
10875:                 .BackStyle = 0
10876:                 .Caption   = "Valor do Grama Produzido"
10877:                 .ForeColor = RGB(90,90,90)

*-- Linhas 10888 a 10939:
10888:             par_oPage.grd_4c_Dados.FontName    = "Tahoma"
10889:             par_oPage.grd_4c_Dados.FontSize    = 8
10890:             par_oPage.grd_4c_Dados.ReadOnly    = .T.
10891:             par_oPage.grd_4c_Dados.DeleteMark  = .F.
10892:             par_oPage.grd_4c_Dados.RecordMark  = .F.
10893:             par_oPage.grd_4c_Dados.RowHeight   = 17
10894:             par_oPage.grd_4c_Dados.GridLines   = 3
10895:             par_oPage.grd_4c_Dados.ScrollBars  = 3
10896:             par_oPage.grd_4c_Dados.Themes      = .F.
10897:             par_oPage.grd_4c_Dados.Visible     = .T.
10898: 
10899:             par_oPage.grd_4c_Dados.RecordSource = "cursor_4c_Cmv"
10900: 
10901:             par_oPage.grd_4c_Dados.Column1.Header1.Caption  = "Per" + CHR(237) + "odo"
10902:             par_oPage.grd_4c_Dados.Column1.ControlSource    = "cursor_4c_Cmv.Periodo"
10903:             par_oPage.grd_4c_Dados.Column1.Width            = 59
10904:             par_oPage.grd_4c_Dados.Column1.ReadOnly         = .T.
10905:             par_oPage.grd_4c_Dados.Column1.Movable          = .F.
10906:             par_oPage.grd_4c_Dados.Column1.Resizable        = .F.
10907:             par_oPage.grd_4c_Dados.Column1.FontName         = "Tahoma"
10908:             par_oPage.grd_4c_Dados.Column1.FontSize         = 8
10909:             par_oPage.grd_4c_Dados.Column1.Header1.FontBold = .T.
10910:             par_oPage.grd_4c_Dados.Column1.Header1.Alignment = 2
10911: 
10912:             par_oPage.grd_4c_Dados.Column2.Header1.Caption  = "Valor Custo GR"
10913:             par_oPage.grd_4c_Dados.Column2.ControlSource    = "cursor_4c_Cmv.ValGR"
10914:             par_oPage.grd_4c_Dados.Column2.Width            = 100
10915:             par_oPage.grd_4c_Dados.Column2.ReadOnly         = .T.
10916:             par_oPage.grd_4c_Dados.Column2.Movable          = .F.
10917:             par_oPage.grd_4c_Dados.Column2.Resizable        = .F.
10918:             par_oPage.grd_4c_Dados.Column2.FontName         = "Tahoma"
10919:             par_oPage.grd_4c_Dados.Column2.FontSize         = 8
10920:             par_oPage.grd_4c_Dados.Column2.Header1.FontBold = .T.
10921:             par_oPage.grd_4c_Dados.Column2.Header1.Alignment = 2
10922: 
10923:             par_oPage.grd_4c_Dados.Column3.Header1.Caption  = "Moe"
10924:             par_oPage.grd_4c_Dados.Column3.ControlSource    = "cursor_4c_Cmv.Moe"
10925:             par_oPage.grd_4c_Dados.Column3.Width            = 31
10926:             par_oPage.grd_4c_Dados.Column3.ReadOnly         = .T.
10927:             par_oPage.grd_4c_Dados.Column3.FontName         = "Tahoma"
10928:             par_oPage.grd_4c_Dados.Column3.Header1.FontBold = .T.
10929:             par_oPage.grd_4c_Dados.Column3.Header1.Alignment = 2
10930: 
10931:             *-- === Say12: "Descricao ECF :" - top=433+29=462, left=124, w=77, h=15 ===
10932:             par_oPage.AddObject("lbl_4c_Label12", "Label")
10933:             WITH par_oPage.lbl_4c_Label12
10934:                 .Top       = 462
10935:                 .Left      = 124
10936:                 .Width     = 77
10937:                 .Height    = 15
10938:                 .FontName  = "Tahoma"
10939:                 .FontSize  = 8

*-- Linhas 10955 a 10973:
10955:                 .SpecialEffect  = 1
10956:                 .MaxLength      = 29
10957:                 .Themes         = .F.
10958:                 .ControlSource  = "crSigCdPro.descecfs"
10959:                 .Visible        = .T.
10960:             ENDWITH
10961: 
10962:             *-- === Say11: "Metal :" - top=433+29=462, left=494, w=35 ===
10963:             par_oPage.AddObject("lbl_4c_Label11", "Label")
10964:             WITH par_oPage.lbl_4c_Label11
10965:                 .Top       = 462
10966:                 .Left      = 494
10967:                 .Width     = 35
10968:                 .FontName  = "Tahoma"
10969:                 .FontSize  = 8
10970:                 .BackStyle = 0
10971:                 .Caption   = "Metal :"
10972:                 .ForeColor = RGB(90,90,90)
10973:                 .Visible   = .T.

*-- Linhas 10984 a 11002:
10984:                 .FontSize       = 8
10985:                 .SpecialEffect  = 1
10986:                 .Themes         = .F.
10987:                 .ControlSource  = "crSigCdPro.metals"
10988:                 .Visible        = .T.
10989:             ENDWITH
10990: 
10991:             *-- === Get_DesMetal: top=429+29=458, left=564, w=150, h=23 ===
10992:             par_oPage.AddObject("txt_4c_DesMetal", "TextBox")
10993:             WITH par_oPage.txt_4c_DesMetal
10994:                 .Top            = 458
10995:                 .Left           = 564
10996:                 .Width          = 150
10997:                 .Height         = 23
10998:                 .FontName       = "Tahoma"
10999:                 .FontSize       = 8
11000:                 .SpecialEffect  = 1
11001:                 .Format         = "!"
11002:                 .InputMask      = "XXXXXXXXXXXXXXXXXXXXXXX"

*-- Linhas 11034 a 11068:
11034:                 .InputMask      = "999,999,999.99"
11035:                 .MaxLength      = 14
11036:                 .Themes         = .F.
11037:                 .ControlSource  = "crSigCdPro.valors"
11038:                 .Visible        = .T.
11039:             ENDWITH
11040: 
11041:             *-- === GetMvalor: top=454+29=483, left=317, w=31, h=23 ===
11042:             par_oPage.AddObject("txt_4c_Mvalor", "TextBox")
11043:             WITH par_oPage.txt_4c_Mvalor
11044:                 .Top            = 483
11045:                 .Left           = 317
11046:                 .Width          = 31
11047:                 .Height         = 23
11048:                 .FontName       = "Tahoma"
11049:                 .FontSize       = 8
11050:                 .SpecialEffect  = 1
11051:                 .MaxLength      = 3
11052:                 .Themes         = .F.
11053:                 .ControlSource  = "crSigCdPro.moedas"
11054:                 .Visible        = .T.
11055:             ENDWITH
11056: 
11057:             *-- === Say15: "Teor :" - top=458+29=487, left=498, w=31 ===
11058:             par_oPage.AddObject("lbl_4c_Label15", "Label")
11059:             WITH par_oPage.lbl_4c_Label15
11060:                 .Top       = 487
11061:                 .Left      = 498
11062:                 .Width     = 31
11063:                 .FontName  = "Tahoma"
11064:                 .FontSize  = 8
11065:                 .BackStyle = 0
11066:                 .Caption   = "Teor :"
11067:                 .ForeColor = RGB(90,90,90)
11068:                 .Visible   = .T.

*-- Linhas 11079 a 11097:
11079:                 .FontSize       = 8
11080:                 .SpecialEffect  = 1
11081:                 .Themes         = .F.
11082:                 .ControlSource  = "crSigCdPro.teors"
11083:                 .Visible        = .T.
11084:             ENDWITH
11085: 
11086:             *-- === Get_DesTeor: top=454+29=483, left=564, w=150, h=23 ===
11087:             par_oPage.AddObject("txt_4c_DesTeor", "TextBox")
11088:             WITH par_oPage.txt_4c_DesTeor
11089:                 .Top            = 483
11090:                 .Left           = 564
11091:                 .Width          = 150
11092:                 .Height         = 23
11093:                 .FontName       = "Tahoma"
11094:                 .FontSize       = 8
11095:                 .SpecialEffect  = 1
11096:                 .Format         = "!"
11097:                 .InputMask      = "XXXXXXXXXXXXXXXXXXXX"

*-- Linhas 11624 a 11644:
11624:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11625:                 IF !EMPTY(ALLTRIM(loc_oPgFisc.txt_4c_Clfiscal.Value)) AND ;
11626:                    !EMPTY(ALLTRIM(loc_oPgFisc.txt_4c_AliqIPI.Value))
11627:                     loc_nRet = SQLEXEC(gnConnHandle, ;
11628:                         "SELECT TOP 1 aIpis FROM SigCdClf WHERE Codigos = " + ;
11629:                         EscaparSQL(ALLTRIM(loc_oPgFisc.txt_4c_Clfiscal.Value)), ;
11630:                         "cursor_4c_TmpClf")
11631:                     IF loc_nRet > 0 AND !EOF("cursor_4c_TmpClf")
11632:                         loc_nAliqClf = cursor_4c_TmpClf.aIpis
11633:                         IF loc_oPgFisc.txt_4c_AliqIPI.Value = loc_nAliqClf
11634:                             MsgAviso("Al" + CHR(237) + "quota de IPI id" + CHR(234) + "ntica " + ;
11635:                                 CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal. " + ;
11636:                                 "Deixe zero para usar a da classifica" + CHR(231) + CHR(227) + "o fiscal!", ;
11637:                                 "Aten" + CHR(231) + CHR(227) + "o")
11638:                         ENDIF
11639:                     ENDIF
11640:                     IF USED("cursor_4c_TmpClf")
11641:                         USE IN cursor_4c_TmpClf
11642:                     ENDIF
11643:                 ENDIF
11644:             ENDIF

*-- Linhas 11720 a 11738:
11720:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11721:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Metal.Value)
11722:             IF !EMPTY(loc_cCodigo) AND USED("TmpMTal")
11723:                 SELECT TmpMTal
11724:                 SET ORDER TO Codigos
11725:                 SET NEAR ON
11726:                 IF !SEEK(loc_cCodigo, "TmpMTal", "Codigos")
11727:                     *-- Nao encontrou exato: mant?m valor digitado
11728:                 ENDIF
11729:                 SET NEAR OFF
11730:                 loc_oPgFisc.txt_4c_Metal.Value    = ALLTRIM(TmpMTal.Codigos)
11731:                 loc_oPgFisc.txt_4c_DesMetal.Value = ALLTRIM(TmpMTal.Descs)
11732:                 loc_oPgFisc.txt_4c_Metal.Refresh
11733:                 loc_oPgFisc.txt_4c_DesMetal.Refresh
11734:             ENDIF
11735:         CATCH TO loc_oErro
11736:             MsgErro(loc_oErro.Message, "Erro ao validar metal")
11737:         ENDTRY
11738:     ENDPROC

*-- Linhas 11764 a 11782:
11764:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11765:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Teor.Value)
11766:             IF !EMPTY(loc_cCodigo) AND USED("TmpTeor")
11767:                 SELECT TmpTeor
11768:                 SET ORDER TO Codigos
11769:                 SET NEAR ON
11770:                 IF !SEEK(loc_cCodigo, "TmpTeor", "Codigos")
11771:                     *-- Nao encontrou exato: mant?m valor digitado
11772:                 ENDIF
11773:                 SET NEAR OFF
11774:                 loc_oPgFisc.txt_4c_Teor.Value    = ALLTRIM(TmpTeor.Codigos)
11775:                 loc_oPgFisc.txt_4c_DesTeor.Value = ALLTRIM(TmpTeor.Descs)
11776:                 loc_oPgFisc.txt_4c_Teor.Refresh
11777:                 loc_oPgFisc.txt_4c_DesTeor.Refresh
11778:             ENDIF
11779:         CATCH TO loc_oErro
11780:             MsgErro(loc_oErro.Message, "Erro ao validar teor")
11781:         ENDTRY
11782:     ENDPROC

*-- Linhas 11819 a 11849:
11819:             IF USED("crSigPrTar")
11820:                 USE IN crSigPrTar
11821:             ENDIF
11822:             CREATE CURSOR crSigPrTar (;
11823:                 CPros    C(14)  NULL, ;
11824:                 pkChaves C(30)  NULL, ;
11825:                 DtInis   T      NULL, ;
11826:                 DtFims   T      NULL, ;
11827:                 Usuars   C(20)  NULL, ;
11828:                 Tarefas  C(10)  NULL, ;
11829:                 ObsTars  M      NULL  ;
11830:             )
11831:             IF USED("crSigPrArq")
11832:                 USE IN crSigPrArq
11833:             ENDIF
11834:             CREATE CURSOR crSigPrArq (;
11835:                 CPros    C(14)  NULL, ;
11836:                 pkChaves C(30)  NULL, ;
11837:                 Arquivos C(254) NULL  ;
11838:             )
11839:             SET NULL OFF
11840: 
11841:             *-- === lbl_4c_ObsTar (Say31): top=144+29=173, left=583, w=126, h=15 ===
11842:             par_oPage.AddObject("lbl_4c_ObsTar", "Label")
11843:             WITH par_oPage.lbl_4c_ObsTar
11844:                 .Top       = 173
11845:                 .Left      = 583
11846:                 .Width     = 126
11847:                 .Height    = 15
11848:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
11849:                 .FontName  = "Tahoma"

*-- Linhas 11865 a 11911:
11865:             loc_oGrd.FontName    = "Tahoma"
11866:             loc_oGrd.FontSize    = 8
11867:             loc_oGrd.GridLines   = 3
11868:             loc_oGrd.DeleteMark  = .F.
11869:             loc_oGrd.RecordMark  = .F.
11870:             loc_oGrd.RowHeight   = 16
11871:             loc_oGrd.ScrollBars  = 3
11872:             loc_oGrd.Themes      = .F.
11873:             loc_oGrd.Visible     = .T.
11874: 
11875:             loc_oGrd.RecordSource = "crSigPrTar"
11876: 
11877:             loc_oGrd.Column1.Header1.Caption  = "Data de In" + CHR(237) + "cio"
11878:             loc_oGrd.Column1.ControlSource    = "crSigPrTar.DtInis"
11879:             loc_oGrd.Column1.Width            = 110
11880:             loc_oGrd.Column1.ReadOnly         = .T.
11881:             loc_oGrd.Column1.Header1.FontBold = .T.
11882: 
11883:             loc_oGrd.Column2.Header1.Caption  = "Data de Conclus" + CHR(227) + "o"
11884:             loc_oGrd.Column2.ControlSource    = "crSigPrTar.DtFims"
11885:             loc_oGrd.Column2.Width            = 120
11886:             loc_oGrd.Column2.ReadOnly         = .T.
11887:             loc_oGrd.Column2.Header1.FontBold = .T.
11888: 
11889:             loc_oGrd.Column3.Header1.Caption  = "Usu" + CHR(225) + "rio"
11890:             loc_oGrd.Column3.ControlSource    = "crSigPrTar.Usuars"
11891:             loc_oGrd.Column3.Width            = 100
11892:             loc_oGrd.Column3.ReadOnly         = .T.
11893:             loc_oGrd.Column3.Header1.FontBold = .T.
11894: 
11895:             loc_oGrd.Column4.Header1.Caption  = "Tarefa"
11896:             loc_oGrd.Column4.ControlSource    = "crSigPrTar.Tarefas"
11897:             loc_oGrd.Column4.Width            = 165
11898:             loc_oGrd.Column4.ReadOnly         = .T.
11899:             loc_oGrd.Column4.Header1.FontBold = .T.
11900: 
11901:             *-- BINDEVENTs para grd_4c_Designer
11902:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "DesignerAfterRowColChange")
11903:             BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress", THIS, "DesignerCol4KeyPress")
11904: 
11905:             *-- === cmd_4c_BtnIniTarefa (btnIniTarefa): top=161+29=190, left=509, w=42, h=42 ===
11906:             par_oPage.AddObject("cmd_4c_BtnIniTarefa", "CommandButton")
11907:             WITH par_oPage.cmd_4c_BtnIniTarefa
11908:                 .Top     = 190
11909:                 .Left    = 509
11910:                 .Width   = 42
11911:                 .Height  = 42

*-- Linhas 11937 a 11955:
11937:                 .Left        = 584
11938:                 .Width       = 407
11939:                 .Height      = 238
11940:                 .ControlSource = "crSigPrTar.ObsTars"
11941:                 .FontName    = "Tahoma"
11942:                 .FontSize    = 8
11943:                 .ScrollBars  = 2
11944:                 .ReadOnly    = .T.
11945:                 .Themes      = .F.
11946:                 .Visible     = .T.
11947:             ENDWITH
11948: 
11949:             *-- === shp_4c_Shape1 (Shape1): top=415+29=444, left=584, w=407, h=202 ===
11950:             par_oPage.AddObject("shp_4c_Shape1", "Shape")
11951:             WITH par_oPage.shp_4c_Shape1
11952:                 .Top         = 444
11953:                 .Left        = 584
11954:                 .Width       = 407
11955:                 .Height      = 202

*-- Linhas 11970 a 11998:
11970:             loc_oGrdArq.FontName    = "Tahoma"
11971:             loc_oGrdArq.FontSize    = 8
11972:             loc_oGrdArq.GridLines   = 3
11973:             loc_oGrdArq.DeleteMark  = .F.
11974:             loc_oGrdArq.RecordMark  = .F.
11975:             loc_oGrdArq.RowHeight   = 16
11976:             loc_oGrdArq.ScrollBars  = 3
11977:             loc_oGrdArq.Themes      = .F.
11978:             loc_oGrdArq.Visible     = .T.
11979: 
11980:             loc_oGrdArq.RecordSource = "crSigPrArq"
11981: 
11982:             loc_oGrdArq.Column1.Header1.Caption  = "Arquivos Para Designer"
11983:             loc_oGrdArq.Column1.ControlSource    = "crSigPrArq.Arquivos"
11984:             loc_oGrdArq.Column1.Width            = 495
11985:             loc_oGrdArq.Column1.ReadOnly         = .T.
11986:             loc_oGrdArq.Column1.Header1.FontBold = .T.
11987: 
11988:             *-- BINDEVENTs para grd_4c_Arquivos
11989:             BINDEVENT(loc_oGrdArq, "AfterRowColChange", THIS, "ArquivosAfterRowColChange")
11990: 
11991:             *-- === cmd_4c_BtnInsArqs (btnInsArqs): top=416+29=445, left=509, w=42, h=42 ===
11992:             par_oPage.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
11993:             WITH par_oPage.cmd_4c_BtnInsArqs
11994:                 .Top     = 445
11995:                 .Left    = 509
11996:                 .Width   = 42
11997:                 .Height  = 42
11998:                 .Caption = ""

*-- Linhas 12068 a 12125:
12068:                 IF USED("cursor_4c_TarTemp")
12069:                     USE IN cursor_4c_TarTemp
12070:                 ENDIF
12071:                 loc_cSQL = "SELECT CPros, pkChaves, DtInis, DtFims, Usuars, Tarefas, " + ;
12072:                            "CONVERT(NVARCHAR(MAX), ObsTars) AS ObsTars " + ;
12073:                            "FROM SigPrTar WHERE CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
12074:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TarTemp")
12075:                 IF loc_nRet > 0
12076:                     SELECT crSigPrTar
12077:                     ZAP
12078:                     IF RECCOUNT("cursor_4c_TarTemp") > 0
12079:                         APPEND FROM DBF("cursor_4c_TarTemp")
12080:                     ENDIF
12081:                     IF USED("cursor_4c_TarTemp")
12082:                         USE IN cursor_4c_TarTemp
12083:                     ENDIF
12084:                     SELECT crSigPrTar
12085:                     GO TOP
12086:                     loc_oPgDesigner.grd_4c_Designer.Refresh()
12087:                     THIS.DesignerAfterRowColChange(0)
12088:                 ELSE
12089:                     IF USED("cursor_4c_TarTemp")
12090:                         USE IN cursor_4c_TarTemp
12091:                     ENDIF
12092:                 ENDIF
12093: 
12094:                 *-- Carregar crSigPrArq de SigPrArq
12095:                 IF USED("cursor_4c_ArqTemp")
12096:                     USE IN cursor_4c_ArqTemp
12097:                 ENDIF
12098:                 loc_cSQL = "SELECT CPros, pkChaves, Arquivos FROM SigPrArq " + ;
12099:                            "WHERE CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
12100:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ArqTemp")
12101:                 IF loc_nRet > 0
12102:                     SELECT crSigPrArq
12103:                     ZAP
12104:                     IF RECCOUNT("cursor_4c_ArqTemp") > 0
12105:                         APPEND FROM DBF("cursor_4c_ArqTemp")
12106:                     ENDIF
12107:                     IF USED("cursor_4c_ArqTemp")
12108:                         USE IN cursor_4c_ArqTemp
12109:                     ENDIF
12110:                     SELECT crSigPrArq
12111:                     GO TOP
12112:                     loc_oPgDesigner.grd_4c_Arquivos.Refresh()
12113:                     THIS.ArquivosAfterRowColChange(0)
12114:                 ELSE
12115:                     IF USED("cursor_4c_ArqTemp")
12116:                         USE IN cursor_4c_ArqTemp
12117:                     ENDIF
12118:                 ENDIF
12119: 
12120:                 *-- Carregar crTarefas de SigCdCad (se ainda nao carregado)
12121:                 IF !USED("crTarefas")
12122:                     THIS.CarregarTarefas()
12123:                 ENDIF
12124:             ENDIF
12125:         CATCH TO loc_oErro

*-- Linhas 12139 a 12160:
12139:             IF USED("crTarefas")
12140:                 USE IN crTarefas
12141:             ENDIF
12142:             loc_cSQL = "SELECT LEFT(CodCads, 10) AS CodCads, DesCads " + ;
12143:                        "FROM SigCdCad " + ;
12144:                        "WHERE TipoCads = " + EscaparSQL(PADR("TAREFAS", 20))
12145:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "crTarefas")
12146:             IF loc_nRet < 1
12147:                 IF USED("crTarefas")
12148:                     USE IN crTarefas
12149:                 ENDIF
12150:             ENDIF
12151:         CATCH TO loc_oErro
12152:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de tarefas")
12153:         ENDTRY
12154:     ENDPROC
12155: 
12156:     *==========================================================================
12157:     * DesignerAfterRowColChange - Atualiza ObsTarefas e controla edicao Tarefa
12158:     *==========================================================================
12159:     PROCEDURE DesignerAfterRowColChange(par_nColIndex)
12160:         LOCAL loc_oPgDesigner, loc_lPodeEditar, loc_oErro

*-- Linhas 12169 a 12187:
12169:             loc_lPodeEditar = .F.
12170:             IF INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12171:                 IF USED("crSigPrTar") AND !EOF("crSigPrTar") AND !BOF("crSigPrTar")
12172:                     SELECT crSigPrTar
12173:                     IF ALLTRIM(NVL(Usuars, "")) == ALLTRIM(gc_4c_UsuarioLogado) ;
12174:                        AND EMPTY(NVL(DtFims, {}))
12175:                         loc_lPodeEditar = .T.
12176:                     ENDIF
12177:                 ENDIF
12178:             ENDIF
12179:             loc_oPgDesigner.grd_4c_Designer.Column4.ReadOnly = !loc_lPodeEditar
12180:         CATCH TO loc_oErro
12181:             *-- Tolerado: controle da coluna nao critico
12182:         ENDTRY
12183:     ENDPROC
12184: 
12185:     *==========================================================================
12186:     * DesignerCol4KeyPress - F4 abre lookup de Tarefa (crTarefas/SigCdCad)
12187:     *==========================================================================

*-- Linhas 12223 a 12304:
12223:             IF VARTYPE(loc_oBusca) = "O"
12224:                 IF loc_oBusca.this_lSelecionou
12225:                     IF USED("cursor_4c_BuscaTar") AND RECCOUNT("cursor_4c_BuscaTar") > 0
12226:                         SELECT cursor_4c_BuscaTar
12227:                         REPLACE crSigPrTar.Tarefas WITH ALLTRIM(CodCads)
12228:                         loc_oGrd.Refresh()
12229:                     ENDIF
12230:                 ELSE
12231:                     loc_oBusca.mAddColuna("CodCads",  "", "C" + CHR(243) + "digo")
12232:                     loc_oBusca.mAddColuna("DesCads",  "", "Descri" + CHR(231) + CHR(227) + "o")
12233:                     loc_oBusca.Show()
12234:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTar")
12235:                         SELECT cursor_4c_BuscaTar
12236:                         REPLACE crSigPrTar.Tarefas WITH ALLTRIM(CodCads)
12237:                         loc_oGrd.Refresh()
12238:                     ENDIF
12239:                 ENDIF
12240:                 loc_oBusca.Release()
12241:             ENDIF
12242:             IF USED("cursor_4c_BuscaTar")
12243:                 USE IN cursor_4c_BuscaTar
12244:             ENDIF
12245:         CATCH TO loc_oErro
12246:             MsgErro(loc_oErro.Message, "Erro ao buscar tarefa")
12247:         ENDTRY
12248:     ENDPROC
12249: 
12250:     *==========================================================================
12251:     * BtnIniTarefaClick - Inicia nova tarefa (INSERT Into crSigPrTar)
12252:     *==========================================================================
12253:     PROCEDURE BtnIniTarefaClick()
12254:         LOCAL loc_oPgDesigner, loc_oGrd, loc_dtAgora, loc_lContinuar, loc_oErro
12255:         loc_lContinuar = .T.
12256:         TRY
12257:             IF !INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12258:                 loc_lContinuar = .F.
12259:             ENDIF
12260:             IF loc_lContinuar AND !USED("crSigPrTar")
12261:                 loc_lContinuar = .F.
12262:             ENDIF
12263:             IF loc_lContinuar
12264:                 *-- Verificar se existe tarefa nao encerrada para o usuario
12265:                 SELECT crSigPrTar
12266:                 GO TOP
12267:                 LOCATE FOR ALLTRIM(NVL(Usuars,"")) == ALLTRIM(gc_4c_UsuarioLogado) ;
12268:                          AND EMPTY(NVL(DtFims, {}))
12269:                 IF !EOF("crSigPrTar")
12270:                     MsgAviso("Existe uma tarefa n" + CHR(227) + "o encerrada para esse usu" + ;
12271:                              CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12272:                     loc_lContinuar = .F.
12273:                 ENDIF
12274:             ENDIF
12275:             IF loc_lContinuar
12276:                 *-- Verificar se existe tarefa com campo Tarefas vazio
12277:                 SELECT crSigPrTar
12278:                 GO TOP
12279:                 LOCATE FOR ALLTRIM(NVL(Usuars,"")) == ALLTRIM(gc_4c_UsuarioLogado) ;
12280:                          AND EMPTY(NVL(Tarefas,""))
12281:                 IF !EOF("crSigPrTar")
12282:                     MsgAviso("Existe uma tarefa ainda n" + CHR(227) + "o informada!", ;
12283:                              "Aten" + CHR(231) + CHR(227) + "o")
12284:                     loc_lContinuar = .F.
12285:                 ENDIF
12286:             ENDIF
12287:             IF loc_lContinuar
12288:                 loc_dtAgora = DATETIME()
12289:                 INSERT INTO crSigPrTar (CPros, pkChaves, DtInis, Usuars) ;
12290:                     VALUES (PADR(ALLTRIM(this_cCodigo), 14), ;
12291:                             PADR(SYS(2015), 30), ;
12292:                             loc_dtAgora, ;
12293:                             PADR(ALLTRIM(gc_4c_UsuarioLogado), 20))
12294:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12295:                 loc_oPgDesigner.grd_4c_Designer.Refresh()
12296:             ENDIF
12297:         CATCH TO loc_oErro
12298:             MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
12299:         ENDTRY
12300:     ENDPROC
12301: 
12302:     *==========================================================================
12303:     * BtnFimTarefaClick - Finaliza tarefa atual (Replace DtFims)
12304:     *==========================================================================

*-- Linhas 12313 a 12340:
12313:                 loc_lContinuar = .F.
12314:             ENDIF
12315:             IF loc_lContinuar
12316:                 SELECT crSigPrTar
12317:                 *-- Verificar se a tarefa pertence ao usuario atual
12318:                 IF ALLTRIM(NVL(Usuars,"")) <> ALLTRIM(gc_4c_UsuarioLogado)
12319:                     MsgAviso("Essa tarefa n" + CHR(227) + "o pertence a esse usu" + ;
12320:                              CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12321:                     loc_lContinuar = .F.
12322:                 ENDIF
12323:             ENDIF
12324:             IF loc_lContinuar
12325:                 SELECT crSigPrTar
12326:                 *-- Verificar se a tarefa ja esta finalizada
12327:                 IF !EMPTY(NVL(DtFims, {}))
12328:                     MsgAviso("Essa tarefa j" + CHR(225) + " se encontra finalizada!", ;
12329:                              "Aten" + CHR(231) + CHR(227) + "o")
12330:                     loc_lContinuar = .F.
12331:                 ENDIF
12332:             ENDIF
12333:             IF loc_lContinuar
12334:                 loc_dtAgora = DATETIME()
12335:                 REPLACE DtFims WITH loc_dtAgora IN crSigPrTar
12336:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12337:                 loc_oPgDesigner.grd_4c_Designer.Refresh()
12338:                 THIS.DesignerAfterRowColChange(0)
12339:             ENDIF
12340:         CATCH TO loc_oErro

*-- Linhas 12357 a 12375:
12357:             IF !USED("crSigPrArq") OR EOF("crSigPrArq") OR BOF("crSigPrArq")
12358:                 RETURN
12359:             ENDIF
12360:             SELECT crSigPrArq
12361:             loc_cArq = ALLTRIM(NVL(Arquivos, ""))
12362:             IF EMPTY(loc_cArq)
12363:                 RETURN
12364:             ENDIF
12365:             loc_cExt = ALLTRIM(UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq), 5)))
12366:             IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG") AND FILE(loc_cArq)
12367:                 CLEAR RESOURCES
12368:                 loc_oPgDesigner.img_4c_ImgArqJpg.Picture  = loc_cArq
12369:                 loc_oPgDesigner.img_4c_ImgArqJpg.Visible  = .T.
12370:             ENDIF
12371:         CATCH TO loc_oErro
12372:             *-- Tolerado: preview de imagem nao critico
12373:         ENDTRY
12374:     ENDPROC
12375: 

*-- Linhas 12387 a 12405:
12387:                 loc_cArq = GETFILE("", "Selecione o Arquivo", "Selecione o Arquivo", 0, ;
12388:                     "Sele" + CHR(231) + CHR(227) + "o de Arquivos")
12389:                 IF !EMPTY(loc_cArq)
12390:                     INSERT INTO crSigPrArq (CPros, pkChaves, Arquivos) ;
12391:                         VALUES (PADR(ALLTRIM(this_cCodigo), 14), ;
12392:                                 PADR(SYS(2015), 30), ;
12393:                                 UPPER(loc_cArq))
12394:                     loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12395:                     loc_oPgDesigner.grd_4c_Arquivos.Refresh()
12396:                 ENDIF
12397:             ENDIF
12398:         CATCH TO loc_oErro
12399:             MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
12400:         ENDTRY
12401:     ENDPROC
12402: 
12403:     *==========================================================================
12404:     * BtnOpnArqsClick - Abre arquivo selecionado com Shell.Application
12405:     *==========================================================================

*-- Linhas 12411 a 12429:
12411:                 loc_lContinuar = .F.
12412:             ENDIF
12413:             IF loc_lContinuar
12414:                 SELECT crSigPrArq
12415:                 loc_cArq = ALLTRIM(NVL(Arquivos, ""))
12416:                 IF EMPTY(loc_cArq)
12417:                     loc_lContinuar = .F.
12418:                 ENDIF
12419:             ENDIF
12420:             IF loc_lContinuar
12421:                 IF FILE(loc_cArq)
12422:                     loc_oShell = CREATEOBJECT("Shell.Application")
12423:                     IF VARTYPE(loc_oShell) = "O"
12424:                         loc_oShell.Open(loc_cArq)
12425:                     ENDIF
12426:                 ELSE
12427:                     MsgAviso("Arquivo n" + CHR(227) + "o encontrado: " + loc_cArq, ;
12428:                              "Aten" + CHR(231) + CHR(227) + "o")
12429:                 ENDIF

*-- Linhas 12447 a 12467:
12447:                 loc_lContinuar = .F.
12448:             ENDIF
12449:             IF loc_lContinuar
12450:                 SELECT crSigPrArq
12451:                 IF !EMPTY(ALLTRIM(NVL(Arquivos, "")))
12452:                     DELETE IN crSigPrArq
12453:                     IF !EOF("crSigPrArq")
12454:                         SKIP IN crSigPrArq
12455:                     ENDIF
12456:                 ENDIF
12457:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12458:                 loc_oPgDesigner.grd_4c_Arquivos.Refresh()
12459:                 THIS.ArquivosAfterRowColChange(0)
12460:             ENDIF
12461:         CATCH TO loc_oErro
12462:             MsgErro(loc_oErro.Message, "Erro ao excluir arquivo")
12463:         ENDTRY
12464:     ENDPROC
12465: 
12466:     *==========================================================================
12467:     * ImgArqJpgClick - Zoom na imagem (abre SigOpZom se for imagem valida)

*-- Linhas 12474 a 12492:
12474:                 loc_lContinuar = .F.
12475:             ENDIF
12476:             IF loc_lContinuar
12477:                 SELECT crSigPrArq
12478:                 loc_cArq = ALLTRIM(NVL(Arquivos, ""))
12479:                 IF EMPTY(loc_cArq)
12480:                     loc_lContinuar = .F.
12481:                 ENDIF
12482:             ENDIF
12483:             IF loc_lContinuar
12484:                 loc_cExt = ALLTRIM(UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq), 5)))
12485:                 IF FILE(loc_cArq) AND INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
12486:                     DO FORM SigOpZom WITH loc_cArq, "Arquivo: " + loc_cArq
12487:                 ENDIF
12488:             ENDIF
12489:         CATCH TO loc_oErro
12490:             MsgErro(loc_oErro.Message, "Erro ao exibir imagem em zoom")
12491:         ENDTRY
12492:     ENDPROC


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

