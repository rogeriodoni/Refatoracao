# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, LNCODIGO, EMPS, PCESCOLHA, VALOR, SERIES, _CONT, PNVOLUME
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, LNCODIGO, EMPS, PCESCOLHA, VALOR, SERIES, _CONT, PNVOLUME
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CUNIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, LNCODIGO, EMPS, PCESCOLHA, VALOR, SERIES, _CONT, PNVOLUME
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDCHAVES, LNCODIGO, EMPS, PCESCOLHA, VALOR, SERIES, _CONT, PNVOLUME

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
  ControlSource = "crSigCnFNf.l1nf"
  ControlSource = "crSigCnFNf.c1nf"
  ControlSource = "crSigCnFNf.lnfsai"
  ControlSource = "crSigCnFN2.ntpmargems"
  ControlSource = "crSigCnFNf.cnfsai"
  ControlSource = "crSigCnFNf.lnfent"
  ControlSource = "crSigCnFNf.cnfent"
  ControlSource = "crSigCnFNf.lnatop"
  ControlSource = "crSigCnFNf.cnatop"
  ControlSource = "crSigCnFNf.lcfop"
  ControlSource = "crSigCnFNf.ccfop"
  ControlSource = "crSigCnFNf.imppads"
  ControlSource = "crSigCnFNf.tamanhos"
  ControlSource = "crSigCnFN2.lxinc"
  ControlSource = "crSigCnFN2.cxinc"
  ControlSource = "crSigCnFN2.lenxinc"
  ControlSource = "crSigCnFN2.lsac"
  ControlSource = "crSigCnFN2.csac"
  ControlSource = "crSigCnFN2.contsac"
  ControlSource = "crSigCnFN2.lnatopsub"
  ControlSource = "crSigCnFN2.cnatopsub"
  ControlSource = "crSigCnFN2.lcfopsub"
  ControlSource = "crSigCnFN2.ccfopsub"
  ControlSource = "crSigCnFNf.lnome"
  ControlSource = "crSigCnFNf.cnome"
  ControlSource = "crSigCnFNf.lcgc"
  ControlSource = "crSigCnFNf.ccgc"
  ControlSource = "crSigCnFNf.ldtemi"
  ControlSource = "crSigCnFNf.cdtemi"
  ControlSource = "crSigCnFNf.lender"
  ControlSource = "crSigCnFNf.cender"
  ControlSource = "crSigCnFNf.lbairr"
  ControlSource = "crSigCnFNf.cbairr"
  ControlSource = "crSigCnFNf.lcep"
  ControlSource = "crSigCnFNf.ccep"
  ControlSource = "crSigCnFNf.lmuni"
  ControlSource = "crSigCnFNf.cmuni"
  ControlSource = "crSigCnFNf.lesta"
  ControlSource = "crSigCnFNf.cesta"
  ControlSource = "crSigCnFNf.lfone"
  ControlSource = "crSigCnFNf.cfone"
  ControlSource = "crSigCnFNf.liest"
  ControlSource = "crSigCnFNf.ciest"
  ControlSource = "crSigCnFNf.lposfis"
  ControlSource = "crSigCnFNf.cposfis"
  ControlSource = "crSigCnFNf.lsufras"
  ControlSource = "crSigCnFNf.csufras"
  ControlSource = "crSigCnFN2.lendent"
  ControlSource = "crSigCnFN2.cendent"
  ControlSource = "crSigCnFN2.lbaient"
  ControlSource = "crSigCnFN2.cbaient"
  ControlSource = "crSigCnFN2.lcepent"
  ControlSource = "crSigCnFN2.ccepent"
  ControlSource = "crSigCnFN2.lmunent"
  ControlSource = "crSigCnFN2.cmunent"
  ControlSource = "crSigCnFN2.lestent"
  ControlSource = "crSigCnFN2.cestent"
  ControlSource = "crSigCnFN2.lfoneent"
  ControlSource = "crSigCnFN2.cfoneent"
  ControlSource = "crSigCnFN2.lendtite"
  ControlSource = "crSigCnFN2.cendtite"
  ControlSource = "crSigCnFN2.ctitent"
  ControlSource = "crSigCnFN2.lempnome"
  ControlSource = "crSigCnFN2.cempnome"
  ControlSource = "crSigCnFN2.lempcgc"
  ControlSource = "crSigCnFN2.cempcgc"
  ControlSource = "crSigCnFN2.lempender"
  ControlSource = "crSigCnFN2.cempender"
  ControlSource = "crSigCnFN2.lempbair"
  ControlSource = "crSigCnFN2.cempbair"
  ControlSource = "crSigCnFN2.lempcep"
  ControlSource = "crSigCnFN2.cempcep"
  ControlSource = "crSigCnFN2.lempmuni"
  ControlSource = "crSigCnFN2.cempmuni"
  ControlSource = "crSigCnFN2.lempfone"
  ControlSource = "crSigCnFN2.cempfone"
  ControlSource = "crSigCnFN2.lempiest"
  ControlSource = "crSigCnFN2.cempiest"
  ControlSource = "crSigCnFN2.lempesta"
  ControlSource = "crSigCnFN2.cempesta"
  ControlSource = "crSigCnFNf.lfat1num"
  ControlSource = "crSigCnFNf.cfat1num"
  ControlSource = "crSigCnFNf.lfat1val"
  ControlSource = "crSigCnFNf.cfat1val"
  ControlSource = "crSigCnFNf.lfat1vec"
  ControlSource = "crSigCnFNf.cfat1vec"
  ControlSource = "crSigCnFNf.lfat2num"
  ControlSource = "crSigCnFNf.cfat2num"
  ControlSource = "crSigCnFNf.lfat2val"
  ControlSource = "crSigCnFNf.cfat2val"
  ControlSource = "crSigCnFNf.lfat2vec"
  ControlSource = "crSigCnFNf.cfat2vec"
  ControlSource = "crSigCnFNf.lfat3num"
  ControlSource = "crSigCnFNf.cfat3num"
  ControlSource = "crSigCnFNf.lfat3val"
  ControlSource = "crSigCnFNf.cfat3val"
  ControlSource = "crSigCnFNf.lfat3vec"
  ControlSource = "crSigCnFNf.cfat3vec"
  ControlSource = "crSigCnFNf.lfat4num"
  ControlSource = "crSigCnFNf.cfat4num"
  ControlSource = "crSigCnFNf.lfat4val"
  ControlSource = "crSigCnFNf.cfat4val"
  ControlSource = "crSigCnFNf.lfat4vec"
  ControlSource = "crSigCnFNf.cfat4vec"
  ControlSource = "crSigCnFNf.lfat5num"
  ControlSource = "crSigCnFNf.cfat5num"
  ControlSource = "crSigCnFNf.lfat5val"
  ControlSource = "crSigCnFNf.cfat5val"
  ControlSource = "crSigCnFNf.lfat5vec"
  ControlSource = "crSigCnFNf.cfat5vec"
  ControlSource = "crSigCnFNf.lfat6num"
  ControlSource = "crSigCnFNf.cfat6num"
  ControlSource = "crSigCnFNf.lfat6val"
  ControlSource = "crSigCnFNf.cfat6val"
  ControlSource = "crSigCnFNf.lfat6vec"
  ControlSource = "crSigCnFNf.cfat6vec"
  ControlSource = "crSigCnFNf.lendcob"
  ControlSource = "crSigCnFNf.cendcob"
  ControlSource = "crSigCnFNf.lbaicob"
  ControlSource = "crSigCnFNf.cbaicob"
  ControlSource = "crSigCnFNf.lcepcob"
  ControlSource = "crSigCnFNf.ccepcob"
  ControlSource = "crSigCnFNf.lmuncob"
  ControlSource = "crSigCnFNf.cmuncob"
  ControlSource = "crSigCnFNf.lestcob"
  ControlSource = "crSigCnFNf.cestcob"
  ControlSource = "crSigCnFNf.lfat7num"
  ControlSource = "crSigCnFNf.cfat7num"
  ControlSource = "crSigCnFNf.lfat7val"
  ControlSource = "crSigCnFNf.cfat7val"
  ControlSource = "crSigCnFNf.lfat7vec"
  ControlSource = "crSigCnFNf.cfat7vec"
  ControlSource = "crSigCnFNf.lfat8num"
  ControlSource = "crSigCnFNf.cfat8num"
  ControlSource = "crSigCnFNf.lfat8val"
  ControlSource = "crSigCnFNf.cfat8val"
  ControlSource = "crSigCnFNf.lfat8vec"
  ControlSource = "crSigCnFNf.cfat8vec"
  ControlSource = "crSigCnFNf.lfat9num"
  ControlSource = "crSigCnFNf.cfat9num"
  ControlSource = "crSigCnFNf.lfat9val"
  ControlSource = "crSigCnFNf.cfat9val"
  ControlSource = "crSigCnFNf.lfat9vec"
  ControlSource = "crSigCnFNf.cfat9vec"
  ControlSource = "crSigCnFNf.lfat10num"
  ControlSource = "crSigCnFNf.cfat10num"
  ControlSource = "crSigCnFNf.lfat10val"
  ControlSource = "crSigCnFNf.cfat10val"
  ControlSource = "crSigCnFNf.lfat10vec"
  ControlSource = "crSigCnFNf.cfat10vec"
  ControlSource = "crSigCnFNf.linprod"
  ControlSource = "crSigCnFNf.ccodpro"
  ControlSource = "crSigCnFNf.cdespro"
  ControlSource = "crSigCnFNf.cclfis"
  ControlSource = "crSigCnFNf.cstrib"
  ControlSource = "crSigCnFNf.cunid"
  ControlSource = "crSigCnFNf.cqtde"
  ControlSource = "crSigCnFNf.cvluni"
  ControlSource = "crSigCnFNf.cvltot"
  ControlSource = "crSigCnFNf.caicm"
  ControlSource = "crSigCnFNf.caipi"
  ControlSource = "crSigCnFNf.cvipi"
  ControlSource = "crSigCnFNf.oorig"
  ControlSource = "crSigCnFNf.oaden"
  ControlSource = "crSigCnFNf.ocor"
  ControlSource = "crSigCnFNf.oemb"
  ControlSource = "crSigCnFNf.otam"
  ControlSource = "crSigCnFNf.cobsi"
  ControlSource = "crSigCnFNf.tamdesc"
  ControlSource = "crSigCnFNf.tamcolobsi"
  ControlSource = "crSigCnFNf.tamlinobsi"
  ControlSource = "crSigCnFNf.cpespro"
  ControlSource = "crSigCnFNf.ltqtde"
  ControlSource = "crSigCnFNf.ctqtde"
  ControlSource = "crSigCnFNf.corigem"
  ControlSource = "crSigCnFNf.ldesconto"
  ControlSource = "crSigCnFNf.cdesconto"
  ControlSource = "crSigCnFN2.ccfoppro"
  ControlSource = "crSigCnFN2.cpesomet"
  ControlSource = "crSigCnFNf.lbicm"
  ControlSource = "crSigCnFNf.cbicm"
  ControlSource = "crSigCnFNf.lticm"
  ControlSource = "crSigCnFNf.cticm"
  ControlSource = "crSigCnFNf.lfrete"
  ControlSource = "crSigCnFNf.cfrete"
  ControlSource = "crSigCnFNf.lseguro"
  ControlSource = "crSigCnFNf.cseguro"
  ControlSource = "crSigCnFNf.loutras"
  ControlSource = "crSigCnFNf.coutras"
  ControlSource = "crSigCnFNf.ltprod"
  ControlSource = "crSigCnFNf.ctprod"
  ControlSource = "crSigCnFNf.ltipi"
  ControlSource = "crSigCnFNf.ctipi"
  ControlSource = "crSigCnFNf.ltnota"
  ControlSource = "crSigCnFNf.ctnota"
  ControlSource = "crSigCnFNf.pirs"
  ControlSource = "crSigCnFNf.piss"
  ControlSource = "crSigCnFN2.lbipi"
  ControlSource = "crSigCnFN2.cbipi"
  ControlSource = "crSigCnFN2.lbicmss"
  ControlSource = "crSigCnFN2.cbicmss"
  ControlSource = "crSigCnFN2.lvicmss"
  ControlSource = "crSigCnFN2.cvicmss"
  ControlSource = "crSigCnFN2.totfsize"
  ControlSource = "crSigCnFNf.lqtvol"
  ControlSource = "crSigCnFNf.cqtvol"
  ControlSource = "crSigCnFNf.lesp"
  ControlSource = "crSigCnFNf.cesp"
  ControlSource = "crSigCnFNf.lmarca"
  ControlSource = "crSigCnFNf.cmarca"
  ControlSource = "crSigCnFNf.lnumero"
  ControlSource = "crSigCnFNf.cnumero"
  ControlSource = "crSigCnFNf.lpbru"
  ControlSource = "crSigCnFNf.cpbru"
  ControlSource = "crSigCnFNf.lpliq"
  ControlSource = "crSigCnFNf.cpliq"
  ControlSource = "crSigCnFNf.ltrnome"
  ControlSource = "crSigCnFNf.ctrnome"
  ControlSource = "crSigCnFNf.ltrcgc"
  ControlSource = "crSigCnFNf.ctrcgc"
  ControlSource = "crSigCnFNf.ltrend"
  ControlSource = "crSigCnFNf.ctrend"
  ControlSource = "crSigCnFNf.ltrmun"
  ControlSource = "crSigCnFNf.ctrmun"
  ControlSource = "crSigCnFNf.ltrest"
  ControlSource = "crSigCnFNf.ctrest"
  ControlSource = "crSigCnFNf.ltrie"
  ControlSource = "crSigCnFNf.ctrie"
  ControlSource = "crSigCnFNf.ltpfrete"
  ControlSource = "crSigCnFNf.ctpfrete"
  ControlSource = "crSigCnFNf.lplaca"
  ControlSource = "crSigCnFNf.cplaca"
  ControlSource = "crSigCnFNf.lplacauf"
  ControlSource = "crSigCnFNf.cplacauf"
  ControlSource = "crSigCnFN2.cunipesos"
  ControlSource = "crSigCnFNf.lclas1"
  ControlSource = "crSigCnFNf.cclas1"
  ControlSource = "crSigCnFNf.impclas1"
  ControlSource = "crSigCnFNf.lclas2"
  ControlSource = "crSigCnFNf.cclas2"
  ControlSource = "crSigCnFNf.impclas2"
  ControlSource = "crSigCnFNf.lclas3"
  ControlSource = "crSigCnFNf.cclas3"
  ControlSource = "crSigCnFNf.impclas3"
  ControlSource = "crSigCnFNf.lclas4"
  ControlSource = "crSigCnFNf.cclas4"
  ControlSource = "crSigCnFNf.impclas4"
  ControlSource = "crSigCnFNf.lclas5"
  ControlSource = "crSigCnFNf.cclas5"
  ControlSource = "crSigCnFNf.impclas5"
  ControlSource = "crSigCnFNf.lclas6"
  ControlSource = "crSigCnFNf.cclas6"
  ControlSource = "crSigCnFNf.impclas6"
  ControlSource = "crSigCnFNf.l2nf"
  ControlSource = "crSigCnFNf.c2nf"
  ControlSource = "crSigCnFNf.lobs"
  ControlSource = "crSigCnFNf.cobs"
  ControlSource = "crSigCnFNf.tamcolobs"
  ControlSource = "crSigCnFNf.tamlinobs"
  ControlSource = "crSigCnFNf.Letras"
  ControlSource = "crSigCnFNf.Impc1"
  ControlSource = "crSigCnFNf.Impc2"
  ControlSource = "crSigCnFNf.Impc3"
  ControlSource = "crSigCnFNf.Impc4"
  ControlSource = "crSigCnFNf.Impc5"
  ControlSource = "crSigCnFNf.Impc6"
  ControlSource = "crSigCnFNf.ltnotar"
  ControlSource = "crSigCnFNf.ctnotar"
  ControlSource = "crSigCnFNf.lclas7"
  ControlSource = "crSigCnFNf.cclas7"
  ControlSource = "crSigCnFNf.impclas7"
  ControlSource = "crSigCnFNf.Impc7"
  ControlSource = "crSigCnFN2.liniped"
  ControlSource = "crSigCnFN2.ciniped"
  ControlSource = "crSigCnFN2.aclas1"
  ControlSource = "crSigCnFN2.aclas2"
  ControlSource = "crSigCnFN2.aclas3"
  ControlSource = "crSigCnFN2.aclas4"
  ControlSource = "crSigCnFN2.aclas5"
  ControlSource = "crSigCnFN2.aclas6"
  ControlSource = "crSigCnFN2.aclas7"
  ControlSource = "crSigCnFN2.a2nf"
  ControlSource = "crSigCnFN2.atnotar"
  ControlSource = "crSigCnFN2.aselo"
  ControlSource = "crSigCnFN2.anfselo"
  ControlSource = "crSigCnFN2.ainiped"
  ControlSource = "crSigCnFN2.aobs"
  ControlSource = "crSigCnFN2.liniped2"
  ControlSource = "crSigCnFN2.ciniped2"
  ControlSource = "crSigCnFN2.ainiped2"
  ControlSource = "crSigCnFN2.lclas8"
  ControlSource = "crSigCnFN2.cclas8"
  ControlSource = "crSigCnFN2.impclas8"
  ControlSource = "crSigCnFN2.lclas9"
  ControlSource = "crSigCnFN2.cclas9"
  ControlSource = "crSigCnFN2.impclas9"
  ControlSource = "crSigCnFN2.lclas10"
  ControlSource = "crSigCnFN2.cclas10"
  ControlSource = "crSigCnFN2.impclas10"
  ControlSource = "crSigCnFN2.lclas11"
  ControlSource = "crSigCnFN2.cclas11"
  ControlSource = "crSigCnFN2.impclas11"
  ControlSource = "crSigCnFN2.lclas12"
  ControlSource = "crSigCnFN2.cclas12"
  ControlSource = "crSigCnFN2.impclas12"
  ControlSource = "crSigCnFN2.Impc8"
  ControlSource = "crSigCnFN2.Impc9"
  ControlSource = "crSigCnFN2.Impc10"
  ControlSource = "crSigCnFN2.Impc11"
  ControlSource = "crSigCnFN2.Impc12"
  ControlSource = "crSigCnFN2.aclas8"
  ControlSource = "crSigCnFN2.aclas9"
  ControlSource = "crSigCnFN2.aclas10"
  ControlSource = "crSigCnFN2.aclas11"
  ControlSource = "crSigCnFN2.aclas12"
  ControlSource = "crSigCnFNf.ldtemif"
  ControlSource = "crSigCnFNf.cdtemif"
  ControlSource = "crSigCnFNf.lfatnum"
  ControlSource = "crSigCnFNf.cfatnum"
  ControlSource = "crSigCnFNf.ltnotaf"
  ControlSource = "crSigCnFNf.ctnotaf"
  ControlSource = "crSigCnFNf.ldupnum"
  ControlSource = "crSigCnFNf.cdupnum"
  ControlSource = "crSigCnFNf.lfatvec"
  ControlSource = "crSigCnFNf.cfatvec"
  ControlSource = "crSigCnFNf.lvalext"
  ControlSource = "crSigCnFNf.cvalext"
  ControlSource = "crSigCnFNf.ldtsaidas"
  ControlSource = "crSigCnFNf.cdtsaidas"
  ControlSource = "crSigCnFNf.ldescser"
  ControlSource = "crSigCnFNf.cdescser"
  ControlSource = "crSigCnFNf.lvaliss"
  ControlSource = "crSigCnFNf.cvaliss"
  ControlSource = "crSigCnFNf.lvalser"
  ControlSource = "crSigCnFNf.cvalser"
  ControlSource = "crSigCnFNf.ncdser"
  ControlSource = "crSigCnFNf.nldser"
  ControlSource = "crSigCnFNf.esppads"
  ControlSource = "crSigCnFNf.fatbrutos"
  ControlSource = "crSigCnFNf.marpads"
  ControlSource = "crSigCnFNf.pesovols"
  ControlSource = "crSigCnFNf.Emps"
  ControlSource = "crSigCnFN2.VSeqNota"
  ControlSource = "crSigC2FNf.LOPLOC"
  ControlSource = "crSigCnFN2.COPLOC"
  ControlSource = "crSigCnFN2.LOPCVD"
  ControlSource = "crSigCnFN2.COPCVD"
  ControlSource = "crSigCnFN2.LOPNVD"
  ControlSource = "crSigCnFN2.COPNVD"
  ControlSource = "crSigCnFN2.LOPCRP"
  ControlSource = "crSigCnFN2.COPCRP"
  ControlSource = "crSigCnFN2.LOPNRP"
  ControlSource = "crSigCnFN2.COPNRP"
  ControlSource = "crSigCnFN2.nVias"
  ControlSource = "crSigCnFN2.nftgdi1s"
  ControlSource = "crSigCnFNf.TpCasas"
  ControlSource = "crSigCnFNf.series"
lcQryCfgNf = [select * from SigCnFnf order by emps,series]
lcQryCfgN2 = [select cidchaves,series,emps,lendent,cendent,lbaient,cbaient,lmunent,cmunent,lestent,cestent,lcepent,] + ;
			 [from SigCnFn2 where cidchaves=?m.pcIdChaves order by emps,series]
        Select crSigCnFNf
Select crSigCnFN2
Delete In crSigCnFN2
If ThisForm.poDataMgr.UpDate('crSigCnFN2')
Select ('crSigCnFN2')
Select crSigCnFNf
	lcQuery = [Select cIdChaves ] + ;
			    [From SigCnFNf ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crBusca') < 1)
	Select crBusca
	Select crSigCnFNf
	Select crSigCnFNf
	Select ('crSigCnFN2')
	If Not ThisForm.poDataMgr.UpDate('crSigCnFN2')
		lcQuery = [Update SigSySeq Set Conteudo=]+Str(ThisForm.Pagina.Dados.ProxNota.Value - 1)+;
      lcQuery = [INSERT INTO SigSySeq (Valor, Conteudo, DigChecks) VALUES ('] + Iif(Empty(crSigCnFNf.Emps), _Empr, crSigCnFNf.Emps) + "NOTA FISCAL" + crSigCnFNf.Series+[', ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigSySeq Set Conteudo=]+Str(ThisForm.Pagina.Dados.ProxSelo.Value - 1)+;
      lcQuery = [INSERT INTO SigSySeq (Valor, Conteudo, DigChecks) VALUES ('] + Iif(Empty(crSigCnFNf.Emps), _Empr, crSigCnFNf.Emps) + "SELO NOTA FISCAL" + crSigCnFNf.Series+[', ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigSySeq Set Conteudo=]+Str(ThisForm.Pagina.Dados.ProxSeloTrans.Value - 1)+;
      lcQuery = [INSERT INTO SigSySeq (Valor, Conteudo, DigChecks) VALUES (']+ Iif(Empty(crSigCnFNf.Emps), _Empr, crSigCnFNf.Emps) + "TRANSP NOTA FISCAL" + crSigCnFNf.Series+[', ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
Select crSigCnFNf
Select crSigCnFNf
Select crSigCnFNf
	Insert Into crSigCnFNf From Memvar
Insert Into crSigCnFN2 From Memvar
If Not ThisForm.poDataMgr.Update('crSigCnFNf')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigCnFNF)')
If Not ThisForm.poDataMgr.Update('crSigCnFN2')
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - SigCnFN2)')
	Select crSigCnFNf
Select crSigCnFNf
Select crSigCnFNf
	Select crSigCnFNf

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormNfl.prg) - TRECHOS RELEVANTES PARA PASS SQL (11058 linhas total):

*-- Linhas 42 a 78:
42:                 THIS.ConfigurarPageFrame()
43:                 THIS.ConfigurarPaginaLista()
44: 
45:                 *-- Criar cursores para ControlSource dos controles das 10 abas
46:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
47:                     IF !USED("crSigCnFNf")
48:                         IF SQLEXEC(gnConnHandle, "SELECT TOP 0 * FROM SigCnFNf", "crSigCnFNf") > 0
49:                             APPEND BLANK IN crSigCnFNf
50:                         ENDIF
51:                     ENDIF
52:                     IF !USED("crSigCnFN2")
53:                         IF SQLEXEC(gnConnHandle, "SELECT TOP 0 * FROM SigCnFN2", "crSigCnFN2") > 0
54:                             APPEND BLANK IN crSigCnFN2
55:                         ENDIF
56:                     ENDIF
57:                 ELSE
58:                     IF !USED("crSigCnFNf")
59:                         CREATE CURSOR crSigCnFNf (cidchaves c(20), emps c(3), series c(3))
60:                         APPEND BLANK IN crSigCnFNf
61:                     ENDIF
62:                     IF !USED("crSigCnFN2")
63:                         CREATE CURSOR crSigCnFN2 (cidchaves c(20), emps c(3), series c(3))
64:                         APPEND BLANK IN crSigCnFN2
65:                     ENDIF
66:                 ENDIF
67: 
68:                 THIS.ConfigurarPaginaDados()
69:                 THIS.TornarControlesVisiveis(THIS)
70: 
71:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
72:                     THIS.CarregarLista()
73:                 ENDIF
74: 
75:                 THIS.pgf_4c_Paginas.Visible = .T.
76:                 THIS.pgf_4c_Paginas.ActivePage = 1
77:                 THIS.this_cModoAtual = "LISTA"
78:                 THIS.AjustarBotoesPorModo("LISTA")

*-- Linhas 280 a 319:
280:             .ReadOnly     = .T.
281:             .GridLines    = 2
282:             .RecordMark   = .F.
283:             .DeleteMark   = .F.
284:             .Visible      = .T.
285:             WITH .Column1
286:                 .ControlSource   = "cursor_4c_Dados.emps"
287:                 .Width           = 55
288:                 .ReadOnly        = .T.
289:                 .Header1.Caption = "Empr."
290:             ENDWITH
291:             WITH .Column2
292:                 .ControlSource   = "cursor_4c_Dados.Razas"
293:                 .Width           = 220
294:                 .ReadOnly        = .T.
295:                 .Header1.Caption = "Empresa"
296:             ENDWITH
297:             WITH .Column3
298:                 .ControlSource   = "cursor_4c_Dados.series"
299:                 .Width           = 55
300:                 .ReadOnly        = .T.
301:                 .Header1.Caption = "S" + CHR(233) + "rie"
302:             ENDWITH
303:             WITH .Column4
304:                 .ControlSource   = "cursor_4c_Dados.cidchaves"
305:                 .Width           = 641
306:                 .ReadOnly        = .T.
307:                 .Header1.Caption = "Chave"
308:             ENDWITH
309:         ENDWITH
310:         THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
311: 
312:         *-- Container cntcopia (flutuante, inicialmente oculto)
313:         *-- Top=244+29=273 compensado; Left=257 como no legado
314:         loc_oPagina.AddObject("cnt_4c_copia", "Container")
315:         WITH loc_oPagina.cnt_4c_copia
316:             .Top         = 273
317:             .Left        = 257
318:             .Width       = 484
319:             .Height      = 116

*-- Linhas 964 a 982:
964:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
965:                 MsgAviso("Nenhum registro selecionado.", "FormNfl")
966:             ELSE
967:                 SELECT cursor_4c_Dados
968:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
969:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
970:                     THIS.BOParaForm()
971:                     THIS.this_cModoAtual = "VISUALIZAR"
972:                     THIS.HabilitarCampos(.F.)
973:                     THIS.AjustarBotoesPorModo("VISUALIZAR")
974:                     THIS.AlternarPagina(2)
975:                     THIS.this_cModoAtual = "VISUALIZAR"
976:                     loc_lResultado = .T.
977:                 ENDIF
978:             ENDIF
979:         CATCH TO loc_oErro
980:             MsgErro(loc_oErro.Message, "FormNfl.BtnVisualizarClick")
981:         ENDTRY
982:         RETURN loc_lResultado

*-- Linhas 990 a 1008:
990:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
991:                 MsgAviso("Nenhum registro selecionado.", "FormNfl")
992:             ELSE
993:                 SELECT cursor_4c_Dados
994:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
995:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
996:                     THIS.this_oBusinessObject.EditarRegistro()
997:                     THIS.BOParaForm()
998:                     THIS.this_cModoAtual = "ALTERAR"
999:                     THIS.HabilitarCampos(.T.)
1000:                     THIS.AjustarBotoesPorModo("ALTERAR")
1001:                     THIS.AlternarPagina(2)
1002:                     THIS.this_cModoAtual = "ALTERAR"
1003:                     loc_lResultado = .T.
1004:                 ENDIF
1005:             ENDIF
1006:         CATCH TO loc_oErro
1007:             MsgErro(loc_oErro.Message, "FormNfl.BtnAlterarClick")
1008:         ENDTRY

*-- Linhas 1017 a 1035:
1017:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1018:                 MsgAviso("Nenhum registro selecionado.", "FormNfl")
1019:             ELSE
1020:                 SELECT cursor_4c_Dados
1021:                 loc_cChave    = ALLTRIM(cursor_4c_Dados.cidchaves)
1022:                 loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da configura" + CHR(231) + CHR(227) + "o selecionada?", "FormNfl")
1023:                 IF loc_lConfirma
1024:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1025:                         loc_lResultado = THIS.this_oBusinessObject.Excluir()
1026:                         IF loc_lResultado
1027:                             THIS.CarregarLista()
1028:                         ENDIF
1029:                     ENDIF
1030:                 ENDIF
1031:             ENDIF
1032:         CATCH TO loc_oErro
1033:             MsgErro(loc_oErro.Message, "FormNfl.BtnExcluirClick")
1034:         ENDTRY
1035:         RETURN loc_lResultado

*-- Linhas 1177 a 1195:
1177:         ENDWITH
1178:         loc_oAba.AddObject("txt_4c_Text1", "TextBox")
1179:         WITH loc_oAba.txt_4c_Text1
1180:             .ControlSource = "crSigCnFNf.l1nf"
1181:             .Top           = 46
1182:             .Left          = 41
1183:             .Width         = 41
1184:             .Height        = 18
1185:             .FontName      = "Tahoma"
1186:             .FontSize      = 8
1187:             .Format        = "K"
1188:             .InputMask     = "999.99"
1189:             .SpecialEffect = 1
1190:             .Margin        = 0
1191:             .Visible       = .T.
1192:         ENDWITH
1193:         loc_oAba.AddObject("lbl_4c_Label2", "Label")
1194:         WITH loc_oAba.lbl_4c_Label2
1195:             .Caption   = "x"

*-- Linhas 1205 a 1223:
1205:         ENDWITH
1206:         loc_oAba.AddObject("txt_4c_Text2", "TextBox")
1207:         WITH loc_oAba.txt_4c_Text2
1208:             .ControlSource = "crSigCnFNf.c1nf"
1209:             .Top           = 46
1210:             .Left          = 90
1211:             .Width         = 41
1212:             .Height        = 18
1213:             .FontName      = "Tahoma"
1214:             .FontSize      = 8
1215:             .Format        = "K"
1216:             .InputMask     = "999.99"
1217:             .SpecialEffect = 1
1218:             .Margin        = 0
1219:             .Visible       = .T.
1220:         ENDWITH
1221: 
1222:         *-- NF Saida (lnfsai x cnfsai)
1223:         loc_oAba.AddObject("lbl_4c_Label3", "Label")

*-- Linhas 1235 a 1253:
1235:         ENDWITH
1236:         loc_oAba.AddObject("txt_4c_Text3", "TextBox")
1237:         WITH loc_oAba.txt_4c_Text3
1238:             .ControlSource = "crSigCnFNf.lnfsai"
1239:             .Top           = 78
1240:             .Left          = 41
1241:             .Width         = 41
1242:             .Height        = 18
1243:             .FontName      = "Tahoma"
1244:             .FontSize      = 8
1245:             .Format        = "K"
1246:             .InputMask     = "999.99"
1247:             .SpecialEffect = 1
1248:             .Margin        = 0
1249:             .Visible       = .T.
1250:         ENDWITH
1251:         loc_oAba.AddObject("lbl_4c_Label4", "Label")
1252:         WITH loc_oAba.lbl_4c_Label4
1253:             .Caption   = "x"

*-- Linhas 1263 a 1281:
1263:         ENDWITH
1264:         loc_oAba.AddObject("txt_4c_Text4", "TextBox")
1265:         WITH loc_oAba.txt_4c_Text4
1266:             .ControlSource = "crSigCnFNf.cnfsai"
1267:             .Top           = 78
1268:             .Left          = 90
1269:             .Width         = 41
1270:             .Height        = 18
1271:             .FontName      = "Tahoma"
1272:             .FontSize      = 8
1273:             .Format        = "K"
1274:             .InputMask     = "999.99"
1275:             .SpecialEffect = 1
1276:             .Margin        = 0
1277:             .Visible       = .T.
1278:         ENDWITH
1279: 
1280:         *-- NF Entrada (lnfent x cnfent)
1281:         loc_oAba.AddObject("lbl_4c_Label5", "Label")

*-- Linhas 1293 a 1311:
1293:         ENDWITH
1294:         loc_oAba.AddObject("txt_4c_Text5", "TextBox")
1295:         WITH loc_oAba.txt_4c_Text5
1296:             .ControlSource = "crSigCnFNf.lnfent"
1297:             .Top           = 110
1298:             .Left          = 41
1299:             .Width         = 41
1300:             .Height        = 18
1301:             .FontName      = "Tahoma"
1302:             .FontSize      = 8
1303:             .Format        = "K"
1304:             .InputMask     = "999.99"
1305:             .SpecialEffect = 1
1306:             .Margin        = 0
1307:             .Visible       = .T.
1308:         ENDWITH
1309:         loc_oAba.AddObject("lbl_4c_Label6", "Label")
1310:         WITH loc_oAba.lbl_4c_Label6
1311:             .Caption   = "x"

*-- Linhas 1321 a 1339:
1321:         ENDWITH
1322:         loc_oAba.AddObject("txt_4c_Text6", "TextBox")
1323:         WITH loc_oAba.txt_4c_Text6
1324:             .ControlSource = "crSigCnFNf.cnfent"
1325:             .Top           = 110
1326:             .Left          = 90
1327:             .Width         = 41
1328:             .Height        = 18
1329:             .FontName      = "Tahoma"
1330:             .FontSize      = 8
1331:             .Format        = "K"
1332:             .InputMask     = "999.99"
1333:             .SpecialEffect = 1
1334:             .Margin        = 0
1335:             .Visible       = .T.
1336:         ENDWITH
1337: 
1338:         *-- Nat. Operacao (lnatop x cnatop)
1339:         loc_oAba.AddObject("lbl_4c_Label7", "Label")

*-- Linhas 1351 a 1369:
1351:         ENDWITH
1352:         loc_oAba.AddObject("txt_4c_Text7", "TextBox")
1353:         WITH loc_oAba.txt_4c_Text7
1354:             .ControlSource = "crSigCnFNf.lnatop"
1355:             .Top           = 142
1356:             .Left          = 41
1357:             .Width         = 41
1358:             .Height        = 18
1359:             .FontName      = "Tahoma"
1360:             .FontSize      = 8
1361:             .Format        = "K"
1362:             .InputMask     = "999.99"
1363:             .SpecialEffect = 1
1364:             .Margin        = 0
1365:             .Visible       = .T.
1366:         ENDWITH
1367:         loc_oAba.AddObject("lbl_4c_Label8", "Label")
1368:         WITH loc_oAba.lbl_4c_Label8
1369:             .Caption   = "x"

*-- Linhas 1379 a 1397:
1379:         ENDWITH
1380:         loc_oAba.AddObject("txt_4c_Text8", "TextBox")
1381:         WITH loc_oAba.txt_4c_Text8
1382:             .ControlSource = "crSigCnFNf.cnatop"
1383:             .Top           = 142
1384:             .Left          = 90
1385:             .Width         = 41
1386:             .Height        = 18
1387:             .FontName      = "Tahoma"
1388:             .FontSize      = 8
1389:             .Format        = "K"
1390:             .InputMask     = "999.99"
1391:             .SpecialEffect = 1
1392:             .Margin        = 0
1393:             .Visible       = .T.
1394:         ENDWITH
1395: 
1396:         *-- CFOP (lcfop x ccfop)
1397:         loc_oAba.AddObject("lbl_4c_Label9", "Label")

*-- Linhas 1409 a 1427:
1409:         ENDWITH
1410:         loc_oAba.AddObject("txt_4c_Text9", "TextBox")
1411:         WITH loc_oAba.txt_4c_Text9
1412:             .ControlSource = "crSigCnFNf.lcfop"
1413:             .Top           = 174
1414:             .Left          = 41
1415:             .Width         = 41
1416:             .Height        = 18
1417:             .FontName      = "Tahoma"
1418:             .FontSize      = 8
1419:             .Format        = "K"
1420:             .InputMask     = "999.99"
1421:             .SpecialEffect = 1
1422:             .Margin        = 0
1423:             .Visible       = .T.
1424:         ENDWITH
1425:         loc_oAba.AddObject("lbl_4c_Label10", "Label")
1426:         WITH loc_oAba.lbl_4c_Label10
1427:             .Caption   = "x"

*-- Linhas 1437 a 1469:
1437:         ENDWITH
1438:         loc_oAba.AddObject("txt_4c_Text10", "TextBox")
1439:         WITH loc_oAba.txt_4c_Text10
1440:             .ControlSource = "crSigCnFNf.ccfop"
1441:             .Top           = 174
1442:             .Left          = 90
1443:             .Width         = 41
1444:             .Height        = 18
1445:             .FontName      = "Tahoma"
1446:             .FontSize      = 8
1447:             .Format        = "K"
1448:             .InputMask     = "999.99"
1449:             .SpecialEffect = 1
1450:             .Margin        = 0
1451:             .Visible       = .T.
1452:         ENDWITH
1453: 
1454:         *-- Razao Social (LRAZEMP x CRAZEMP, sem ControlSource)
1455:         loc_oAba.AddObject("lbl_4c_Label11", "Label")
1456:         WITH loc_oAba.lbl_4c_Label11
1457:             .Caption   = "Raz" + CHR(227) + "o Social"
1458:             .Top       = 193
1459:             .Left      = 41
1460:             .Width     = 54
1461:             .Height    = 13
1462:             .FontName  = "Tahoma"
1463:             .FontSize  = 7
1464:             .BackStyle = 0
1465:             .ForeColor = RGB(90, 90, 90)
1466:             .Visible   = .T.
1467:         ENDWITH
1468:         loc_oAba.AddObject("txt_4c_LRAZEMP", "TextBox")
1469:         WITH loc_oAba.txt_4c_LRAZEMP

*-- Linhas 1507 a 1525:
1507:             .Visible       = .T.
1508:         ENDWITH
1509: 
1510:         *-- Endereco (LENDEMP x CENDEMP, sem ControlSource)
1511:         loc_oAba.AddObject("lbl_4c_Label16", "Label")
1512:         WITH loc_oAba.lbl_4c_Label16
1513:             .Caption   = "Endere" + CHR(231) + "o"
1514:             .Top       = 226
1515:             .Left      = 43
1516:             .Width     = 40
1517:             .Height    = 13
1518:             .FontName  = "Tahoma"
1519:             .FontSize  = 7
1520:             .BackStyle = 0
1521:             .ForeColor = RGB(90, 90, 90)
1522:             .Visible   = .T.
1523:         ENDWITH
1524:         loc_oAba.AddObject("txt_4c_LENDEMP", "TextBox")
1525:         WITH loc_oAba.txt_4c_LENDEMP

*-- Linhas 1581 a 1599:
1581:         ENDWITH
1582:         loc_oAba.AddObject("txt_4c_Text12", "TextBox")
1583:         WITH loc_oAba.txt_4c_Text12
1584:             .ControlSource = "crSigCnFN2.lxinc"
1585:             .Top           = 46
1586:             .Left          = 165
1587:             .Width         = 41
1588:             .Height        = 18
1589:             .FontName      = "Tahoma"
1590:             .FontSize      = 8
1591:             .Format        = "K"
1592:             .InputMask     = "999.99"
1593:             .SpecialEffect = 1
1594:             .Margin        = 0
1595:             .Visible       = .T.
1596:         ENDWITH
1597:         loc_oAba.AddObject("lbl_4c_Label20", "Label")
1598:         WITH loc_oAba.lbl_4c_Label20
1599:             .Caption   = "x"

*-- Linhas 1609 a 1627:
1609:         ENDWITH
1610:         loc_oAba.AddObject("txt_4c_Text16", "TextBox")
1611:         WITH loc_oAba.txt_4c_Text16
1612:             .ControlSource = "crSigCnFN2.cxinc"
1613:             .Top           = 46
1614:             .Left          = 214
1615:             .Width         = 41
1616:             .Height        = 18
1617:             .FontName      = "Tahoma"
1618:             .FontSize      = 8
1619:             .Format        = "K"
1620:             .InputMask     = "999.99"
1621:             .SpecialEffect = 1
1622:             .Margin        = 0
1623:             .Visible       = .T.
1624:         ENDWITH
1625:         loc_oAba.AddObject("lbl_4c_Label21", "Label")
1626:         WITH loc_oAba.lbl_4c_Label21
1627:             .Caption   = "x"

*-- Linhas 1637 a 1655:
1637:         ENDWITH
1638:         loc_oAba.AddObject("txt_4c_Text17", "TextBox")
1639:         WITH loc_oAba.txt_4c_Text17
1640:             .ControlSource = "crSigCnFN2.lenxinc"
1641:             .Top           = 46
1642:             .Left          = 261
1643:             .Width         = 41
1644:             .Height        = 18
1645:             .FontName      = "Tahoma"
1646:             .FontSize      = 8
1647:             .Format        = "K"
1648:             .InputMask     = "99999"
1649:             .SpecialEffect = 1
1650:             .Margin        = 0
1651:             .Visible       = .T.
1652:         ENDWITH
1653: 
1654:         *-- SAC (lsac x csac + contsac)
1655:         loc_oAba.AddObject("lbl_4c_Label22", "Label")

*-- Linhas 1667 a 1685:
1667:         ENDWITH
1668:         loc_oAba.AddObject("txt_4c_Text18", "TextBox")
1669:         WITH loc_oAba.txt_4c_Text18
1670:             .ControlSource = "crSigCnFN2.lsac"
1671:             .Top           = 78
1672:             .Left          = 164
1673:             .Width         = 41
1674:             .Height        = 18
1675:             .FontName      = "Tahoma"
1676:             .FontSize      = 8
1677:             .Format        = "K"
1678:             .InputMask     = "999.99"
1679:             .SpecialEffect = 1
1680:             .Margin        = 0
1681:             .Visible       = .T.
1682:         ENDWITH
1683:         loc_oAba.AddObject("lbl_4c_Label23", "Label")
1684:         WITH loc_oAba.lbl_4c_Label23
1685:             .Caption   = "x"

*-- Linhas 1695 a 1728:
1695:         ENDWITH
1696:         loc_oAba.AddObject("txt_4c_Text19", "TextBox")
1697:         WITH loc_oAba.txt_4c_Text19
1698:             .ControlSource = "crSigCnFN2.csac"
1699:             .Top           = 78
1700:             .Left          = 213
1701:             .Width         = 41
1702:             .Height        = 18
1703:             .FontName      = "Tahoma"
1704:             .FontSize      = 8
1705:             .Format        = "K"
1706:             .InputMask     = "999.99"
1707:             .SpecialEffect = 1
1708:             .Margin        = 0
1709:             .Visible       = .T.
1710:         ENDWITH
1711:         loc_oAba.AddObject("txt_4c_Text20", "TextBox")
1712:         WITH loc_oAba.txt_4c_Text20
1713:             .ControlSource = "crSigCnFN2.contsac"
1714:             .Top           = 97
1715:             .Left          = 164
1716:             .Width         = 137
1717:             .Height        = 18
1718:             .MaxLength     = 20
1719:             .FontName      = "Tahoma"
1720:             .FontSize      = 8
1721:             .Format        = "K"
1722:             .SpecialEffect = 1
1723:             .Margin        = 0
1724:             .Visible       = .T.
1725:         ENDWITH
1726: 
1727:         *-- Nat. Operacao Substituicao Tributaria (lnatopsub x cnatopsub)
1728:         loc_oAba.AddObject("lbl_4c_Label24", "Label")

*-- Linhas 1740 a 1758:
1740:         ENDWITH
1741:         loc_oAba.AddObject("txt_4c_Text21", "TextBox")
1742:         WITH loc_oAba.txt_4c_Text21
1743:             .ControlSource = "crSigCnFN2.lnatopsub"
1744:             .Top           = 142
1745:             .Left          = 164
1746:             .Width         = 41
1747:             .Height        = 18
1748:             .FontName      = "Tahoma"
1749:             .FontSize      = 8
1750:             .Format        = "K"
1751:             .InputMask     = "999.99"
1752:             .SpecialEffect = 1
1753:             .Margin        = 0
1754:             .Visible       = .T.
1755:         ENDWITH
1756:         loc_oAba.AddObject("lbl_4c_Label25", "Label")
1757:         WITH loc_oAba.lbl_4c_Label25
1758:             .Caption   = "x"

*-- Linhas 1768 a 1786:
1768:         ENDWITH
1769:         loc_oAba.AddObject("txt_4c_Text22", "TextBox")
1770:         WITH loc_oAba.txt_4c_Text22
1771:             .ControlSource = "crSigCnFN2.cnatopsub"
1772:             .Top           = 142
1773:             .Left          = 213
1774:             .Width         = 41
1775:             .Height        = 18
1776:             .FontName      = "Tahoma"
1777:             .FontSize      = 8
1778:             .Format        = "K"
1779:             .InputMask     = "999.99"
1780:             .SpecialEffect = 1
1781:             .Margin        = 0
1782:             .Visible       = .T.
1783:         ENDWITH
1784: 
1785:         *-- CFOP Substituicao Tributaria (lcfopsub x ccfopsub)
1786:         loc_oAba.AddObject("lbl_4c_Label26", "Label")

*-- Linhas 1798 a 1816:
1798:         ENDWITH
1799:         loc_oAba.AddObject("txt_4c_Text23", "TextBox")
1800:         WITH loc_oAba.txt_4c_Text23
1801:             .ControlSource = "crSigCnFN2.lcfopsub"
1802:             .Top           = 174
1803:             .Left          = 164
1804:             .Width         = 41
1805:             .Height        = 18
1806:             .FontName      = "Tahoma"
1807:             .FontSize      = 8
1808:             .Format        = "K"
1809:             .InputMask     = "999.99"
1810:             .SpecialEffect = 1
1811:             .Margin        = 0
1812:             .Visible       = .T.
1813:         ENDWITH
1814:         loc_oAba.AddObject("lbl_4c_Label27", "Label")
1815:         WITH loc_oAba.lbl_4c_Label27
1816:             .Caption   = "x"

*-- Linhas 1826 a 1844:
1826:         ENDWITH
1827:         loc_oAba.AddObject("txt_4c_Text24", "TextBox")
1828:         WITH loc_oAba.txt_4c_Text24
1829:             .ControlSource = "crSigCnFN2.ccfopsub"
1830:             .Top           = 174
1831:             .Left          = 213
1832:             .Width         = 41
1833:             .Height        = 18
1834:             .FontName      = "Tahoma"
1835:             .FontSize      = 8
1836:             .Format        = "K"
1837:             .InputMask     = "999.99"
1838:             .SpecialEffect = 1
1839:             .Margin        = 0
1840:             .Visible       = .T.
1841:         ENDWITH
1842: 
1843:         *===== Coluna direita: impressora (dentro do Shape1) =====
1844: 

*-- Linhas 1858 a 1889:
1858:         ENDWITH
1859:         loc_oAba.AddObject("txt_4c_Text13", "TextBox")
1860:         WITH loc_oAba.txt_4c_Text13
1861:             .ControlSource = "crSigCnFNf.imppads"
1862:             .Top           = 61
1863:             .Left          = 393
1864:             .Width         = 240
1865:             .Height        = 18
1866:             .FontName      = "Tahoma"
1867:             .FontSize      = 8
1868:             .Format        = "K"
1869:             .SpecialEffect = 1
1870:             .Margin        = 0
1871:             .Visible       = .T.
1872:         ENDWITH
1873: 
1874:         *-- Fonte Padrao + Tamanho (sem ControlSource; Text14 abre dialogo fonte)
1875:         loc_oAba.AddObject("lbl_4c_Label14", "Label")
1876:         WITH loc_oAba.lbl_4c_Label14
1877:             .Caption   = "Fonte Padr" + CHR(227) + "o"
1878:             .Top       = 81
1879:             .Left      = 393
1880:             .Width     = 58
1881:             .Height    = 13
1882:             .FontName  = "Tahoma"
1883:             .FontSize  = 7
1884:             .BackStyle = 0
1885:             .ForeColor = RGB(90, 90, 90)
1886:             .Visible   = .T.
1887:         ENDWITH
1888:         loc_oAba.AddObject("txt_4c_Text14", "TextBox")
1889:         WITH loc_oAba.txt_4c_Text14

*-- Linhas 1913 a 1945:
1913:         ENDWITH
1914:         loc_oAba.AddObject("txt_4c_Text15", "TextBox")
1915:         WITH loc_oAba.txt_4c_Text15
1916:             .ControlSource = "crSigCnFNf.tamanhos"
1917:             .Top           = 93
1918:             .Left          = 592
1919:             .Width         = 41
1920:             .Height        = 18
1921:             .FontName      = "Tahoma"
1922:             .FontSize      = 8
1923:             .Format        = "K"
1924:             .InputMask     = "999"
1925:             .SpecialEffect = 1
1926:             .Margin        = 0
1927:             .Visible       = .T.
1928:         ENDWITH
1929: 
1930:         *-- Tamanho da Folha (Text11, sem ControlSource; abre dialogo)
1931:         loc_oAba.AddObject("lbl_4c_Label18", "Label")
1932:         WITH loc_oAba.lbl_4c_Label18
1933:             .Caption   = "Tamanho da Folha"
1934:             .Top       = 114
1935:             .Left      = 394
1936:             .Width     = 80
1937:             .Height    = 13
1938:             .FontName  = "Tahoma"
1939:             .FontSize  = 7
1940:             .BackStyle = 0
1941:             .ForeColor = RGB(90, 90, 90)
1942:             .Visible   = .T.
1943:         ENDWITH
1944:         loc_oAba.AddObject("txt_4c_Text11", "TextBox")
1945:         WITH loc_oAba.txt_4c_Text11

*-- Linhas 1959 a 1977:
1959:         *-- optTpMargem (Sem Margem / Com Margem)
1960:         loc_oAba.AddObject("obj_4c_OptTpMargem", "OptionGroup")
1961:         WITH loc_oAba.obj_4c_OptTpMargem
1962:             .ControlSource = "crSigCnFN2.ntpmargems"
1963:             .Top           = 149
1964:             .Left          = 389
1965:             .Width         = 202
1966:             .Height        = 27
1967:             .BackStyle     = 0
1968:             .BorderStyle   = 0
1969:             .Value         = 1
1970:             .Visible       = .T.
1971:             WITH .Buttons(1)
1972:                 .Caption   = "Sem Margem"
1973:                 .Left      = 5
1974:                 .Top       = 5
1975:                 .AutoSize  = .T.
1976:                 .BackStyle = 0
1977:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 2032 a 2051:
2032:             IF EMPTY(loc_cVal) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
2033:                 loc_lResultado = .T.
2034:             ENDIF
2035:             loc_nRes = SQLEXEC(gnConnHandle, ;
2036:                 "SELECT cods FROM SigCdSer WHERE cods = " + EscaparSQL(loc_cVal), ;
2037:                 "cursor_4c_ValidSer")
2038:             IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_ValidSer") = 0
2039:                 THIS.AbrirLookupSeries()
2040:             ENDIF
2041:             IF USED("cursor_4c_ValidSer")
2042:                 USE IN cursor_4c_ValidSer
2043:             ENDIF
2044:         CATCH TO loc_oErro
2045:             MsgErro(loc_oErro.Message, "FormNfl.SeriesDadosValid")
2046:         ENDTRY
2047:         RETURN loc_lResultado
2048:     ENDPROC
2049: 
2050:     *--------------------------------------------------------------------------
2051:     PROCEDURE SeriesKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 2069 a 2108:
2069:             ENDIF
2070:             loc_cVal = ALLTRIM(loc_oCtrl.Value)
2071:             IF !EMPTY(loc_cVal)
2072:                 loc_cSQL = "SELECT cods, descs FROM SigCdSer WHERE UPPER(cods) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY cods"
2073:             ELSE
2074:                 loc_cSQL = "SELECT cods, descs FROM SigCdSer ORDER BY cods"
2075:             ENDIF
2076:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaSer")
2077:             IF !USED("cursor_4c_BuscaSer") OR RECCOUNT("cursor_4c_BuscaSer") = 0
2078:                 IF USED("cursor_4c_BuscaSer")
2079:                     USE IN cursor_4c_BuscaSer
2080:                 ENDIF
2081:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdSer ORDER BY cods", "cursor_4c_BuscaSer")
2082:             ENDIF
2083:             IF !USED("cursor_4c_BuscaSer")
2084:                 CREATE CURSOR cursor_4c_BuscaSer (cods c(3), descs c(50))
2085:             ENDIF
2086:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2087:             IF VARTYPE(loc_oBusca) = "O"
2088:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaSer", "cods", "descs", "S" + CHR(233) + "ries")
2089:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
2090:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2091:                 loc_oBusca.Mostrar()
2092:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSer")
2093:                     SELECT cursor_4c_BuscaSer
2094:                     loc_oCtrl.Value = ALLTRIM(cods)
2095:                 ENDIF
2096:             ENDIF
2097:             IF USED("cursor_4c_BuscaSer")
2098:                 USE IN cursor_4c_BuscaSer
2099:             ENDIF
2100:         CATCH TO loc_oErro
2101:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupSeries")
2102:         ENDTRY
2103:     ENDPROC
2104: 
2105:     *--------------------------------------------------------------------------
2106:     PROCEDURE NomedestKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2107:         IF par_nKeyCode = 28
2108:             THIS.AbrirLookupNomedest()

*-- Linhas 2121 a 2160:
2121:             loc_oCtrl = THIS.pgf_4c_Paginas.Page1.cnt_4c_copia.txt_4c_nomedest
2122:             loc_cVal  = ALLTRIM(loc_oCtrl.Value)
2123:             IF !EMPTY(loc_cVal)
2124:                 loc_cSQL = "SELECT cods, descs FROM SigCdSer WHERE UPPER(cods) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY cods"
2125:             ELSE
2126:                 loc_cSQL = "SELECT cods, descs FROM SigCdSer ORDER BY cods"
2127:             ENDIF
2128:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaSerCp")
2129:             IF !USED("cursor_4c_BuscaSerCp") OR RECCOUNT("cursor_4c_BuscaSerCp") = 0
2130:                 IF USED("cursor_4c_BuscaSerCp")
2131:                     USE IN cursor_4c_BuscaSerCp
2132:                 ENDIF
2133:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdSer ORDER BY cods", "cursor_4c_BuscaSerCp")
2134:             ENDIF
2135:             IF !USED("cursor_4c_BuscaSerCp")
2136:                 CREATE CURSOR cursor_4c_BuscaSerCp (cods c(3), descs c(50))
2137:             ENDIF
2138:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2139:             IF VARTYPE(loc_oBusca) = "O"
2140:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaSerCp", "cods", "descs", "S" + CHR(233) + "rie Destino")
2141:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
2142:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2143:                 loc_oBusca.Mostrar()
2144:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSerCp")
2145:                     SELECT cursor_4c_BuscaSerCp
2146:                     loc_oCtrl.Value = ALLTRIM(cods)
2147:                 ENDIF
2148:             ENDIF
2149:             IF USED("cursor_4c_BuscaSerCp")
2150:                 USE IN cursor_4c_BuscaSerCp
2151:             ENDIF
2152:         CATCH TO loc_oErro
2153:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupNomedest")
2154:         ENDTRY
2155:     ENDPROC
2156: 
2157:     *--------------------------------------------------------------------------
2158:     PROCEDURE EmpDestKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2159:         IF par_nKeyCode = 28
2160:             THIS.AbrirLookupEmpDest()

*-- Linhas 2173 a 2212:
2173:             loc_oCtrl = THIS.pgf_4c_Paginas.Page1.cnt_4c_copia.txt_4c_empDest
2174:             loc_cVal  = ALLTRIM(loc_oCtrl.Value)
2175:             IF !EMPTY(loc_cVal)
2176:                 loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp WHERE UPPER(CEmps) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY CEmps"
2177:             ELSE
2178:                 loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps"
2179:             ENDIF
2180:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpDest")
2181:             IF !USED("cursor_4c_BuscaEmpDest") OR RECCOUNT("cursor_4c_BuscaEmpDest") = 0
2182:                 IF USED("cursor_4c_BuscaEmpDest")
2183:                     USE IN cursor_4c_BuscaEmpDest
2184:                 ENDIF
2185:                 SQLEXEC(gnConnHandle, "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps", "cursor_4c_BuscaEmpDest")
2186:             ENDIF
2187:             IF !USED("cursor_4c_BuscaEmpDest")
2188:                 CREATE CURSOR cursor_4c_BuscaEmpDest (CEmps c(2), Razas c(60))
2189:             ENDIF
2190:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2191:             IF VARTYPE(loc_oBusca) = "O"
2192:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaEmpDest", "CEmps", "Razas", "Empresa Destino")
2193:                 loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
2194:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
2195:                 loc_oBusca.Mostrar()
2196:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpDest")
2197:                     SELECT cursor_4c_BuscaEmpDest
2198:                     loc_oCtrl.Value = ALLTRIM(CEmps)
2199:                 ENDIF
2200:             ENDIF
2201:             IF USED("cursor_4c_BuscaEmpDest")
2202:                 USE IN cursor_4c_BuscaEmpDest
2203:             ENDIF
2204:         CATCH TO loc_oErro
2205:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupEmpDest")
2206:         ENDTRY
2207:     ENDPROC
2208: 
2209:     *--------------------------------------------------------------------------
2210:     PROCEDURE EmpPadKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2211:         IF par_nKeyCode = 28
2212:             THIS.AbrirLookupEmpPad()

*-- Linhas 2227 a 2246:
2227:             IF EMPTY(loc_cVal) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
2228:                 loc_lResultado = .T.
2229:             ENDIF
2230:             loc_nRes = SQLEXEC(gnConnHandle, ;
2231:                 "SELECT CEmps FROM SigCdEmp WHERE CEmps = " + EscaparSQL(loc_cVal), ;
2232:                 "cursor_4c_ValidEmpPad")
2233:             IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_ValidEmpPad") = 0
2234:                 THIS.AbrirLookupEmpPad()
2235:             ENDIF
2236:             IF USED("cursor_4c_ValidEmpPad")
2237:                 USE IN cursor_4c_ValidEmpPad
2238:             ENDIF
2239:         CATCH TO loc_oErro
2240:             MsgErro(loc_oErro.Message, "FormNfl.EmpPadValid")
2241:         ENDTRY
2242:         RETURN loc_lResultado
2243:     ENDPROC
2244: 
2245:     *--------------------------------------------------------------------------
2246:     PROTECTED PROCEDURE AbrirLookupEmpPad()

*-- Linhas 2252 a 2291:
2252:             ENDIF
2253:             loc_cVal = ALLTRIM(loc_oCtrl.Value)
2254:             IF !EMPTY(loc_cVal)
2255:                 loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp WHERE UPPER(CEmps) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY CEmps"
2256:             ELSE
2257:                 loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps"
2258:             ENDIF
2259:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpPad")
2260:             IF !USED("cursor_4c_BuscaEmpPad") OR RECCOUNT("cursor_4c_BuscaEmpPad") = 0
2261:                 IF USED("cursor_4c_BuscaEmpPad")
2262:                     USE IN cursor_4c_BuscaEmpPad
2263:                 ENDIF
2264:                 SQLEXEC(gnConnHandle, "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps", "cursor_4c_BuscaEmpPad")
2265:             ENDIF
2266:             IF !USED("cursor_4c_BuscaEmpPad")
2267:                 CREATE CURSOR cursor_4c_BuscaEmpPad (CEmps c(2), Razas c(60))
2268:             ENDIF
2269:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2270:             IF VARTYPE(loc_oBusca) = "O"
2271:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaEmpPad", "CEmps", "Razas", "Empresa Padr" + CHR(227) + "o")
2272:                 loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
2273:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
2274:                 loc_oBusca.Mostrar()
2275:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpPad")
2276:                     SELECT cursor_4c_BuscaEmpPad
2277:                     loc_oCtrl.Value = ALLTRIM(CEmps)
2278:                 ENDIF
2279:             ENDIF
2280:             IF USED("cursor_4c_BuscaEmpPad")
2281:                 USE IN cursor_4c_BuscaEmpPad
2282:             ENDIF
2283:         CATCH TO loc_oErro
2284:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupEmpPad")
2285:         ENDTRY
2286:     ENDPROC
2287: 
2288:     *--------------------------------------------------------------------------
2289:     PROCEDURE UnPesosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2290:         IF par_nKeyCode = 28
2291:             THIS.AbrirLookupUnPesos()

*-- Linhas 2306 a 2325:
2306:             IF EMPTY(loc_cVal) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
2307:                 loc_lResultado = .T.
2308:             ENDIF
2309:             loc_nRes = SQLEXEC(gnConnHandle, ;
2310:                 "SELECT CUnis FROM SigCdUni WHERE CUnis = " + EscaparSQL(loc_cVal), ;
2311:                 "cursor_4c_ValidUni")
2312:             IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_ValidUni") = 0
2313:                 THIS.AbrirLookupUnPesos()
2314:             ENDIF
2315:             IF USED("cursor_4c_ValidUni")
2316:                 USE IN cursor_4c_ValidUni
2317:             ENDIF
2318:         CATCH TO loc_oErro
2319:             MsgErro(loc_oErro.Message, "FormNfl.UnPesosValid")
2320:         ENDTRY
2321:         RETURN loc_lResultado
2322:     ENDPROC
2323: 
2324:     *--------------------------------------------------------------------------
2325:     PROTECTED PROCEDURE AbrirLookupUnPesos()

*-- Linhas 2331 a 2437:
2331:             ENDIF
2332:             loc_cVal = ALLTRIM(loc_oCtrl.Value)
2333:             IF !EMPTY(loc_cVal)
2334:                 loc_cSQL = "SELECT CUnis, DUnis FROM SigCdUni WHERE UPPER(CUnis) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY CUnis"
2335:             ELSE
2336:                 loc_cSQL = "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis"
2337:             ENDIF
2338:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUni")
2339:             IF !USED("cursor_4c_BuscaUni") OR RECCOUNT("cursor_4c_BuscaUni") = 0
2340:                 IF USED("cursor_4c_BuscaUni")
2341:                     USE IN cursor_4c_BuscaUni
2342:                 ENDIF
2343:                 SQLEXEC(gnConnHandle, "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", "cursor_4c_BuscaUni")
2344:             ENDIF
2345:             IF !USED("cursor_4c_BuscaUni")
2346:                 CREATE CURSOR cursor_4c_BuscaUni (CUnis c(6), DUnis c(30))
2347:             ENDIF
2348:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2349:             IF VARTYPE(loc_oBusca) = "O"
2350:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaUni", "CUnis", "DUnis", "Unidades de Medida")
2351:                 loc_oBusca.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
2352:                 loc_oBusca.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
2353:                 loc_oBusca.Mostrar()
2354:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUni")
2355:                     SELECT cursor_4c_BuscaUni
2356:                     loc_oCtrl.Value = ALLTRIM(CUnis)
2357:                 ENDIF
2358:             ENDIF
2359:             IF USED("cursor_4c_BuscaUni")
2360:                 USE IN cursor_4c_BuscaUni
2361:             ENDIF
2362:         CATCH TO loc_oErro
2363:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupUnPesos")
2364:         ENDTRY
2365:     ENDPROC
2366: 
2367:     *--------------------------------------------------------------------------
2368:     PROTECTED PROCEDURE AbrirLookupClsFis(par_cNomeCampo)
2369:         LOCAL loc_oRdp, loc_oCtrl, loc_cVal, loc_oBusca, loc_cSQL
2370:         TRY
2371:             loc_oRdp  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page7
2372:             loc_oCtrl = THIS.ObterControle(loc_oRdp, par_cNomeCampo)
2373:             IF PEMSTATUS(loc_oCtrl, "Enabled", 5) AND !loc_oCtrl.Enabled
2374:                 RETURN
2375:             ENDIF
2376:             loc_cVal = ALLTRIM(loc_oCtrl.Value)
2377:             IF !EMPTY(loc_cVal)
2378:                 loc_cSQL = "SELECT codigos, descricaos FROM SigCdClf WHERE UPPER(codigos) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY codigos"
2379:             ELSE
2380:                 loc_cSQL = "SELECT codigos, descricaos FROM SigCdClf ORDER BY codigos"
2381:             ENDIF
2382:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaClf")
2383:             IF !USED("cursor_4c_BuscaClf") OR RECCOUNT("cursor_4c_BuscaClf") = 0
2384:                 IF USED("cursor_4c_BuscaClf")
2385:                     USE IN cursor_4c_BuscaClf
2386:                 ENDIF
2387:                 SQLEXEC(gnConnHandle, "SELECT codigos, descricaos FROM SigCdClf ORDER BY codigos", "cursor_4c_BuscaClf")
2388:             ENDIF
2389:             IF !USED("cursor_4c_BuscaClf")
2390:                 CREATE CURSOR cursor_4c_BuscaClf (codigos c(10), descricaos c(60))
2391:             ENDIF
2392:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2393:             IF VARTYPE(loc_oBusca) = "O"
2394:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaClf", "codigos", "descricaos", "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
2395:                 loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
2396:                 loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2397:                 loc_oBusca.Mostrar()
2398:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
2399:                     SELECT cursor_4c_BuscaClf
2400:                     loc_oCtrl.Value = ALLTRIM(codigos)
2401:                 ENDIF
2402:             ENDIF
2403:             IF USED("cursor_4c_BuscaClf")
2404:                 USE IN cursor_4c_BuscaClf
2405:             ENDIF
2406:         CATCH TO loc_oErro
2407:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupClsFis")
2408:         ENDTRY
2409:     ENDPROC
2410: 
2411:     *--------------------------------------------------------------------------
2412:     PROTECTED PROCEDURE ValidarClsFis(par_cNomeCampo)
2413:         LOCAL loc_lResultado, loc_oRdp, loc_cVal, loc_nRes
2414:         loc_lResultado = .T.
2415:         TRY
2416:             loc_oRdp = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page7
2417:             loc_cVal = ALLTRIM(loc_oRdp.Value)
2418:             IF EMPTY(loc_cVal) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
2419:                 loc_lResultado = .T.
2420:             ENDIF
2421:             loc_nRes = SQLEXEC(gnConnHandle, ;
2422:                 "SELECT codigos FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cVal), ;
2423:                 "cursor_4c_ValidClf")
2424:             IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_ValidClf") = 0
2425:                 THIS.AbrirLookupClsFis(par_cNomeCampo)
2426:             ENDIF
2427:             IF USED("cursor_4c_ValidClf")
2428:                 USE IN cursor_4c_ValidClf
2429:             ENDIF
2430:         CATCH TO loc_oErro
2431:             MsgErro(loc_oErro.Message, "FormNfl.ValidarClsFis")
2432:         ENDTRY
2433:         RETURN loc_lResultado
2434:     ENDPROC
2435: 
2436:     *-- CodImp bloco 1 (campos 1-7)
2437:     PROCEDURE CodImp1KeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 2618 a 2648:
2618:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2619:         loc_oBO   = THIS.this_oBusinessObject
2620: 
2621:         *-- Controles standalone (sem ControlSource)
2622:         IF PEMSTATUS(loc_oPag2, "txt_4c_Series", 5)
2623:             loc_oBO.this_cSeries = ALLTRIM(loc_oPag2.txt_4c_Series.Value)
2624:         ENDIF
2625:         IF VARTYPE(loc_oPag2.pgf_4c_Abas) = "O"
2626:             IF PEMSTATUS(loc_oPag2.pgf_4c_Abas.Page10, "txt_4c_EmpPad", 5)
2627:                 loc_oBO.this_cEmps = ALLTRIM(loc_oPag2.pgf_4c_Abas.Page10.txt_4c_EmpPad.Value)
2628:             ENDIF
2629:         ENDIF
2630: 
2631:         *-- Campos de crSigCnFN2 (Empresa, Destinatario, Impostos adicionais, Classes extras)
2632:         IF USED("crSigCnFN2") AND RECCOUNT("crSigCnFN2") > 0
2633:             SELECT crSigCnFN2
2634:             loc_oBO.this_cCtitent      = ALLTRIM(ctitent)
2635:             loc_oBO.this_nLendent      = lendent
2636:             loc_oBO.this_nCendent      = cendent
2637:             loc_oBO.this_nLbaient      = lbaient
2638:             loc_oBO.this_nCbaient      = cbaient
2639:             loc_oBO.this_nLmunent      = lmunent
2640:             loc_oBO.this_nCmunent      = cmunent
2641:             loc_oBO.this_nLestent      = lestent
2642:             loc_oBO.this_nCestent      = cestent
2643:             loc_oBO.this_nLcepent      = lcepent
2644:             loc_oBO.this_nCcepent      = ccepent
2645:             loc_oBO.this_nLfoneent     = lfoneent
2646:             loc_oBO.this_nCfoneent     = cfoneent
2647:             loc_oBO.this_nLiniped      = liniped
2648:             loc_oBO.this_nCiniped      = ciniped

*-- Linhas 2746 a 2793:
2746:         *-- Campos editados via crSigCnFNf que tem contraparte em SigCnFN2
2747:         *   (desdobramento posicoes e vseqnota)
2748:         IF USED("crSigCnFNf") AND FCOUNT("crSigCnFNf") > 3 AND RECCOUNT("crSigCnFNf") > 0
2749:             SELECT crSigCnFNf
2750:             loc_oBO.this_lVseqnota = (vseqnota = 1)
2751:             loc_oBO.this_nLopcvd   = lopcvd
2752:             loc_oBO.this_nCopcvd   = copcvd
2753:             loc_oBO.this_nLoploc   = loploc
2754:             loc_oBO.this_nCoploc   = coploc
2755:             loc_oBO.this_nLopnvd   = lopnvd
2756:             loc_oBO.this_nCopnvd   = copnvd
2757:             loc_oBO.this_nLopnrp   = lopnrp
2758:             loc_oBO.this_nCopnrp   = copnrp
2759:         ENDIF
2760:     ENDPROC
2761: 
2762:     *--------------------------------------------------------------------------
2763:     PROTECTED PROCEDURE BOParaForm()
2764:         LOCAL loc_lResultado, loc_oPag2, loc_oBO, loc_cChave
2765:         loc_lResultado = .F.
2766:         TRY
2767:             loc_oPag2  = THIS.pgf_4c_Paginas.Page2
2768:             loc_oBO    = THIS.this_oBusinessObject
2769:             loc_cChave = ALLTRIM(loc_oBO.this_cCidchaves)
2770: 
2771:             IF !EMPTY(loc_cChave)
2772:                 IF SQLEXEC(gnConnHandle, ;
2773:                     "SELECT * FROM SigCnFNf WHERE cidchaves = " + EscaparSQL(loc_cChave), ;
2774:                     "crSigCnFNf") <= 0
2775:                     MsgErro("Erro ao recarregar SigCnFNf.", "FormNfl.BOParaForm")
2776:                 ENDIF
2777:                 IF SQLEXEC(gnConnHandle, ;
2778:                     "SELECT * FROM SigCnFN2 WHERE cidchaves = " + EscaparSQL(loc_cChave), ;
2779:                     "crSigCnFN2") <= 0
2780:                     MsgErro("Erro ao recarregar SigCnFN2.", "FormNfl.BOParaForm")
2781:                 ENDIF
2782:             ENDIF
2783: 
2784:             IF PEMSTATUS(loc_oPag2, "txt_4c_Series", 5)
2785:                 loc_oPag2.txt_4c_Series.Value = ALLTRIM(loc_oBO.this_cSeries)
2786:             ENDIF
2787:             IF VARTYPE(loc_oPag2.pgf_4c_Abas) = "O"
2788:                 IF PEMSTATUS(loc_oPag2.pgf_4c_Abas.Page10, "txt_4c_EmpPad", 5)
2789:                     loc_oPag2.pgf_4c_Abas.Page10.txt_4c_EmpPad.Value = ALLTRIM(loc_oBO.this_cEmps)
2790:                 ENDIF
2791:             ENDIF
2792:             loc_lResultado = .T.
2793:         CATCH TO loc_oErro

*-- Linhas 2843 a 2861:
2843: 
2844:         loc_oAba.AddObject("txt_4c_EmpNomeL", "TextBox")
2845:         WITH loc_oAba.txt_4c_EmpNomeL
2846:             .ControlSource = "crSigCnFN2.lempnome"
2847:             .Top           = 38
2848:             .Left          = 42
2849:             .Width         = 41
2850:             .Height        = 18
2851:             .FontName      = "Tahoma"
2852:             .FontSize      = 8
2853:             .SpecialEffect = 1
2854:             .Format        = "K"
2855:             .InputMask     = "999.99"
2856:             .Visible       = .T.
2857:         ENDWITH
2858: 
2859:         loc_oAba.AddObject("lbl_4c_Label42", "Label")
2860:         WITH loc_oAba.lbl_4c_Label42
2861:             .Caption   = "x"

*-- Linhas 2871 a 2889:
2871: 
2872:         loc_oAba.AddObject("txt_4c_EmpNomeC", "TextBox")
2873:         WITH loc_oAba.txt_4c_EmpNomeC
2874:             .ControlSource = "crSigCnFN2.cempnome"
2875:             .Top           = 38
2876:             .Left          = 91
2877:             .Width         = 41
2878:             .Height        = 18
2879:             .FontName      = "Tahoma"
2880:             .FontSize      = 8
2881:             .SpecialEffect = 1
2882:             .Format        = "K"
2883:             .InputMask     = "999.99"
2884:             .Visible       = .T.
2885:         ENDWITH
2886: 
2887:         *-- Empresa - CGC/CPF (top=26)
2888:         loc_oAba.AddObject("lbl_4c_Label43", "Label")
2889:         WITH loc_oAba.lbl_4c_Label43

*-- Linhas 2900 a 2918:
2900: 
2901:         loc_oAba.AddObject("txt_4c_EmpCgcL", "TextBox")
2902:         WITH loc_oAba.txt_4c_EmpCgcL
2903:             .ControlSource = "crSigCnFN2.lempcgc"
2904:             .Top           = 38
2905:             .Left          = 150
2906:             .Width         = 41
2907:             .Height        = 18
2908:             .FontName      = "Tahoma"
2909:             .FontSize      = 8
2910:             .SpecialEffect = 1
2911:             .Format        = "K"
2912:             .InputMask     = "999.99"
2913:             .Visible       = .T.
2914:         ENDWITH
2915: 
2916:         loc_oAba.AddObject("lbl_4c_Label44", "Label")
2917:         WITH loc_oAba.lbl_4c_Label44
2918:             .Caption   = "x"

*-- Linhas 2928 a 2946:
2928: 
2929:         loc_oAba.AddObject("txt_4c_EmpCgcC", "TextBox")
2930:         WITH loc_oAba.txt_4c_EmpCgcC
2931:             .ControlSource = "crSigCnFN2.cempcgc"
2932:             .Top           = 38
2933:             .Left          = 199
2934:             .Width         = 41
2935:             .Height        = 18
2936:             .FontName      = "Tahoma"
2937:             .FontSize      = 8
2938:             .SpecialEffect = 1
2939:             .Format        = "K"
2940:             .InputMask     = "999.99"
2941:             .Visible       = .T.
2942:         ENDWITH
2943: 
2944:         *-- Empresa - Insc.Estadual (top=26)
2945:         loc_oAba.AddObject("lbl_4c_Label55", "Label")
2946:         WITH loc_oAba.lbl_4c_Label55

*-- Linhas 2957 a 2975:
2957: 
2958:         loc_oAba.AddObject("txt_4c_EmpIestL", "TextBox")
2959:         WITH loc_oAba.txt_4c_EmpIestL
2960:             .ControlSource = "crSigCnFN2.lempiest"
2961:             .Top           = 38
2962:             .Left          = 258
2963:             .Width         = 41
2964:             .Height        = 18
2965:             .FontName      = "Tahoma"
2966:             .FontSize      = 8
2967:             .SpecialEffect = 1
2968:             .Format        = "K"
2969:             .InputMask     = "999.99"
2970:             .Visible       = .T.
2971:         ENDWITH
2972: 
2973:         loc_oAba.AddObject("lbl_4c_Label56", "Label")
2974:         WITH loc_oAba.lbl_4c_Label56
2975:             .Caption   = "x"

*-- Linhas 2985 a 3003:
2985: 
2986:         loc_oAba.AddObject("txt_4c_EmpIestC", "TextBox")
2987:         WITH loc_oAba.txt_4c_EmpIestC
2988:             .ControlSource = "crSigCnFN2.cempiest"
2989:             .Top           = 38
2990:             .Left          = 307
2991:             .Width         = 41
2992:             .Height        = 18
2993:             .FontName      = "Tahoma"
2994:             .FontSize      = 8
2995:             .SpecialEffect = 1
2996:             .Format        = "K"
2997:             .InputMask     = "999.99"
2998:             .Visible       = .T.
2999:         ENDWITH
3000: 
3001:         *-- Empresa - Endereco (top=56)
3002:         loc_oAba.AddObject("lbl_4c_Label45", "Label")
3003:         WITH loc_oAba.lbl_4c_Label45

*-- Linhas 3014 a 3032:
3014: 
3015:         loc_oAba.AddObject("txt_4c_EmpEnderL", "TextBox")
3016:         WITH loc_oAba.txt_4c_EmpEnderL
3017:             .ControlSource = "crSigCnFN2.lempender"
3018:             .Top           = 68
3019:             .Left          = 42
3020:             .Width         = 41
3021:             .Height        = 18
3022:             .FontName      = "Tahoma"
3023:             .FontSize      = 8
3024:             .SpecialEffect = 1
3025:             .Format        = "K"
3026:             .InputMask     = "999.99"
3027:             .Visible       = .T.
3028:         ENDWITH
3029: 
3030:         loc_oAba.AddObject("lbl_4c_Label46", "Label")
3031:         WITH loc_oAba.lbl_4c_Label46
3032:             .Caption   = "x"

*-- Linhas 3042 a 3060:
3042: 
3043:         loc_oAba.AddObject("txt_4c_EmpEnderC", "TextBox")
3044:         WITH loc_oAba.txt_4c_EmpEnderC
3045:             .ControlSource = "crSigCnFN2.cempender"
3046:             .Top           = 68
3047:             .Left          = 91
3048:             .Width         = 41
3049:             .Height        = 18
3050:             .FontName      = "Tahoma"
3051:             .FontSize      = 8
3052:             .SpecialEffect = 1
3053:             .Format        = "K"
3054:             .InputMask     = "999.99"
3055:             .Visible       = .T.
3056:         ENDWITH
3057: 
3058:         *-- Empresa - Bairro (top=56)
3059:         loc_oAba.AddObject("lbl_4c_Label47", "Label")
3060:         WITH loc_oAba.lbl_4c_Label47

*-- Linhas 3071 a 3089:
3071: 
3072:         loc_oAba.AddObject("txt_4c_EmpBairL", "TextBox")
3073:         WITH loc_oAba.txt_4c_EmpBairL
3074:             .ControlSource = "crSigCnFN2.lempbair"
3075:             .Top           = 68
3076:             .Left          = 149
3077:             .Width         = 41
3078:             .Height        = 18
3079:             .FontName      = "Tahoma"
3080:             .FontSize      = 8
3081:             .SpecialEffect = 1
3082:             .Format        = "K"
3083:             .InputMask     = "999.99"
3084:             .Visible       = .T.
3085:         ENDWITH
3086: 
3087:         loc_oAba.AddObject("lbl_4c_Label48", "Label")
3088:         WITH loc_oAba.lbl_4c_Label48
3089:             .Caption   = "x"

*-- Linhas 3099 a 3117:
3099: 
3100:         loc_oAba.AddObject("txt_4c_EmpBairC", "TextBox")
3101:         WITH loc_oAba.txt_4c_EmpBairC
3102:             .ControlSource = "crSigCnFN2.cempbair"
3103:             .Top           = 68
3104:             .Left          = 198
3105:             .Width         = 41
3106:             .Height        = 18
3107:             .FontName      = "Tahoma"
3108:             .FontSize      = 8
3109:             .SpecialEffect = 1
3110:             .Format        = "K"
3111:             .InputMask     = "999.99"
3112:             .Visible       = .T.
3113:         ENDWITH
3114: 
3115:         *-- Empresa - Municipio (top=56)
3116:         loc_oAba.AddObject("lbl_4c_Label51", "Label")
3117:         WITH loc_oAba.lbl_4c_Label51

*-- Linhas 3128 a 3146:
3128: 
3129:         loc_oAba.AddObject("txt_4c_EmpMuniL", "TextBox")
3130:         WITH loc_oAba.txt_4c_EmpMuniL
3131:             .ControlSource = "crSigCnFN2.lempmuni"
3132:             .Top           = 68
3133:             .Left          = 257
3134:             .Width         = 41
3135:             .Height        = 18
3136:             .FontName      = "Tahoma"
3137:             .FontSize      = 8
3138:             .SpecialEffect = 1
3139:             .Format        = "K"
3140:             .InputMask     = "999.99"
3141:             .Visible       = .T.
3142:         ENDWITH
3143: 
3144:         loc_oAba.AddObject("lbl_4c_Label52", "Label")
3145:         WITH loc_oAba.lbl_4c_Label52
3146:             .Caption   = "x"

*-- Linhas 3156 a 3174:
3156: 
3157:         loc_oAba.AddObject("txt_4c_EmpMuniC", "TextBox")
3158:         WITH loc_oAba.txt_4c_EmpMuniC
3159:             .ControlSource = "crSigCnFN2.cempmuni"
3160:             .Top           = 68
3161:             .Left          = 306
3162:             .Width         = 41
3163:             .Height        = 18
3164:             .FontName      = "Tahoma"
3165:             .FontSize      = 8
3166:             .SpecialEffect = 1
3167:             .Format        = "K"
3168:             .InputMask     = "999.99"
3169:             .Visible       = .T.
3170:         ENDWITH
3171: 
3172:         *-- Empresa - CEP (top=86)
3173:         loc_oAba.AddObject("lbl_4c_Label49", "Label")
3174:         WITH loc_oAba.lbl_4c_Label49

*-- Linhas 3185 a 3203:
3185: 
3186:         loc_oAba.AddObject("txt_4c_EmpCepL", "TextBox")
3187:         WITH loc_oAba.txt_4c_EmpCepL
3188:             .ControlSource = "crSigCnFN2.lempcep"
3189:             .Top           = 98
3190:             .Left          = 41
3191:             .Width         = 41
3192:             .Height        = 18
3193:             .FontName      = "Tahoma"
3194:             .FontSize      = 8
3195:             .SpecialEffect = 1
3196:             .Format        = "K"
3197:             .InputMask     = "999.99"
3198:             .Visible       = .T.
3199:         ENDWITH
3200: 
3201:         loc_oAba.AddObject("lbl_4c_Label50", "Label")
3202:         WITH loc_oAba.lbl_4c_Label50
3203:             .Caption   = "x"

*-- Linhas 3213 a 3231:
3213: 
3214:         loc_oAba.AddObject("txt_4c_EmpCepC", "TextBox")
3215:         WITH loc_oAba.txt_4c_EmpCepC
3216:             .ControlSource = "crSigCnFN2.cempcep"
3217:             .Top           = 98
3218:             .Left          = 90
3219:             .Width         = 41
3220:             .Height        = 18
3221:             .FontName      = "Tahoma"
3222:             .FontSize      = 8
3223:             .SpecialEffect = 1
3224:             .Format        = "K"
3225:             .InputMask     = "999.99"
3226:             .Visible       = .T.
3227:         ENDWITH
3228: 
3229:         *-- Empresa - Fone/Fax (top=86)
3230:         loc_oAba.AddObject("lbl_4c_Label53", "Label")
3231:         WITH loc_oAba.lbl_4c_Label53

*-- Linhas 3242 a 3260:
3242: 
3243:         loc_oAba.AddObject("txt_4c_EmpFoneL", "TextBox")
3244:         WITH loc_oAba.txt_4c_EmpFoneL
3245:             .ControlSource = "crSigCnFN2.lempfone"
3246:             .Top           = 98
3247:             .Left          = 149
3248:             .Width         = 41
3249:             .Height        = 18
3250:             .FontName      = "Tahoma"
3251:             .FontSize      = 8
3252:             .SpecialEffect = 1
3253:             .Format        = "K"
3254:             .InputMask     = "999.99"
3255:             .Visible       = .T.
3256:         ENDWITH
3257: 
3258:         loc_oAba.AddObject("lbl_4c_Label54", "Label")
3259:         WITH loc_oAba.lbl_4c_Label54
3260:             .Caption   = "x"

*-- Linhas 3270 a 3288:
3270: 
3271:         loc_oAba.AddObject("txt_4c_EmpFoneC", "TextBox")
3272:         WITH loc_oAba.txt_4c_EmpFoneC
3273:             .ControlSource = "crSigCnFN2.cempfone"
3274:             .Top           = 98
3275:             .Left          = 198
3276:             .Width         = 41
3277:             .Height        = 18
3278:             .FontName      = "Tahoma"
3279:             .FontSize      = 8
3280:             .SpecialEffect = 1
3281:             .Format        = "K"
3282:             .InputMask     = "999.99"
3283:             .Visible       = .T.
3284:         ENDWITH
3285: 
3286:         *-- Empresa - Estado (top=86)
3287:         loc_oAba.AddObject("lbl_4c_Label58", "Label")
3288:         WITH loc_oAba.lbl_4c_Label58

*-- Linhas 3299 a 3317:
3299: 
3300:         loc_oAba.AddObject("txt_4c_EmpEstaL", "TextBox")
3301:         WITH loc_oAba.txt_4c_EmpEstaL
3302:             .ControlSource = "crSigCnFN2.lempesta"
3303:             .Top           = 98
3304:             .Left          = 257
3305:             .Width         = 41
3306:             .Height        = 18
3307:             .FontName      = "Tahoma"
3308:             .FontSize      = 8
3309:             .SpecialEffect = 1
3310:             .Format        = "K"
3311:             .InputMask     = "999.99"
3312:             .Visible       = .T.
3313:         ENDWITH
3314: 
3315:         loc_oAba.AddObject("lbl_4c_Label59", "Label")
3316:         WITH loc_oAba.lbl_4c_Label59
3317:             .Caption   = "x"

*-- Linhas 3327 a 3345:
3327: 
3328:         loc_oAba.AddObject("txt_4c_EmpEstaC", "TextBox")
3329:         WITH loc_oAba.txt_4c_EmpEstaC
3330:             .ControlSource = "crSigCnFN2.cempesta"
3331:             .Top           = 98
3332:             .Left          = 306
3333:             .Width         = 41
3334:             .Height        = 18
3335:             .FontName      = "Tahoma"
3336:             .FontSize      = 8
3337:             .SpecialEffect = 1
3338:             .Format        = "K"
3339:             .InputMask     = "999.99"
3340:             .Visible       = .T.
3341:         ENDWITH
3342: 
3343:         *-- Secao: Dados/Endereco - Empresa/Cliente (top=120 shape + top=127 header)
3344:         loc_oAba.AddObject("shp_4c_Shape1", "Shape")
3345:         WITH loc_oAba.shp_4c_Shape1

*-- Linhas 3383 a 3401:
3383: 
3384:         loc_oAba.AddObject("txt_4c_CliNomeL", "TextBox")
3385:         WITH loc_oAba.txt_4c_CliNomeL
3386:             .ControlSource = "crSigCnFNf.lnome"
3387:             .Top           = 153
3388:             .Left          = 42
3389:             .Width         = 41
3390:             .Height        = 18
3391:             .FontName      = "Tahoma"
3392:             .FontSize      = 8
3393:             .SpecialEffect = 1
3394:             .Format        = "K"
3395:             .InputMask     = "999.99"
3396:             .Visible       = .T.
3397:         ENDWITH
3398: 
3399:         loc_oAba.AddObject("lbl_4c_Label2", "Label")
3400:         WITH loc_oAba.lbl_4c_Label2
3401:             .Caption   = "x"

*-- Linhas 3411 a 3429:
3411: 
3412:         loc_oAba.AddObject("txt_4c_CliNomeC", "TextBox")
3413:         WITH loc_oAba.txt_4c_CliNomeC
3414:             .ControlSource = "crSigCnFNf.cnome"
3415:             .Top           = 153
3416:             .Left          = 91
3417:             .Width         = 41
3418:             .Height        = 18
3419:             .FontName      = "Tahoma"
3420:             .FontSize      = 8
3421:             .SpecialEffect = 1
3422:             .Format        = "K"
3423:             .InputMask     = "999.99"
3424:             .Visible       = .T.
3425:         ENDWITH
3426: 
3427:         *-- CGC/CPF (cliente, top=141)
3428:         loc_oAba.AddObject("lbl_4c_Label3", "Label")
3429:         WITH loc_oAba.lbl_4c_Label3

*-- Linhas 3440 a 3458:
3440: 
3441:         loc_oAba.AddObject("txt_4c_CliCgcL", "TextBox")
3442:         WITH loc_oAba.txt_4c_CliCgcL
3443:             .ControlSource = "crSigCnFNf.lcgc"
3444:             .Top           = 153
3445:             .Left          = 150
3446:             .Width         = 41
3447:             .Height        = 18
3448:             .FontName      = "Tahoma"
3449:             .FontSize      = 8
3450:             .SpecialEffect = 1
3451:             .Format        = "K"
3452:             .InputMask     = "999.99"
3453:             .Visible       = .T.
3454:         ENDWITH
3455: 
3456:         loc_oAba.AddObject("lbl_4c_Label4", "Label")
3457:         WITH loc_oAba.lbl_4c_Label4
3458:             .Caption   = "x"

*-- Linhas 3468 a 3486:
3468: 
3469:         loc_oAba.AddObject("txt_4c_CliCgcC", "TextBox")
3470:         WITH loc_oAba.txt_4c_CliCgcC
3471:             .ControlSource = "crSigCnFNf.ccgc"
3472:             .Top           = 153
3473:             .Left          = 199
3474:             .Width         = 41
3475:             .Height        = 18
3476:             .FontName      = "Tahoma"
3477:             .FontSize      = 8
3478:             .SpecialEffect = 1
3479:             .Format        = "K"
3480:             .InputMask     = "999.99"
3481:             .Visible       = .T.
3482:         ENDWITH
3483: 
3484:         *-- Insc.Estadual (cliente, top=141)
3485:         loc_oAba.AddObject("lbl_4c_Label21", "Label")
3486:         WITH loc_oAba.lbl_4c_Label21

*-- Linhas 3497 a 3515:
3497: 
3498:         loc_oAba.AddObject("txt_4c_CliIestL", "TextBox")
3499:         WITH loc_oAba.txt_4c_CliIestL
3500:             .ControlSource = "crSigCnFNf.liest"
3501:             .Top           = 153
3502:             .Left          = 258
3503:             .Width         = 41
3504:             .Height        = 18
3505:             .FontName      = "Tahoma"
3506:             .FontSize      = 8
3507:             .SpecialEffect = 1
3508:             .Format        = "K"
3509:             .InputMask     = "999.99"
3510:             .Visible       = .T.
3511:         ENDWITH
3512: 
3513:         loc_oAba.AddObject("lbl_4c_Label22", "Label")
3514:         WITH loc_oAba.lbl_4c_Label22
3515:             .Caption   = "x"

*-- Linhas 3525 a 3543:
3525: 
3526:         loc_oAba.AddObject("txt_4c_CliIestC", "TextBox")
3527:         WITH loc_oAba.txt_4c_CliIestC
3528:             .ControlSource = "crSigCnFNf.ciest"
3529:             .Top           = 153
3530:             .Left          = 307
3531:             .Width         = 41
3532:             .Height        = 18
3533:             .FontName      = "Tahoma"
3534:             .FontSize      = 8
3535:             .SpecialEffect = 1
3536:             .Format        = "K"
3537:             .InputMask     = "999.99"
3538:             .Visible       = .T.
3539:         ENDWITH
3540: 
3541:         *-- Data de Emissao (cliente, top=141)
3542:         loc_oAba.AddObject("lbl_4c_Label5", "Label")
3543:         WITH loc_oAba.lbl_4c_Label5

*-- Linhas 3554 a 3572:
3554: 
3555:         loc_oAba.AddObject("txt_4c_CliDtEmiL", "TextBox")
3556:         WITH loc_oAba.txt_4c_CliDtEmiL
3557:             .ControlSource = "crSigCnFNf.ldtemi"
3558:             .Top           = 153
3559:             .Left          = 366
3560:             .Width         = 41
3561:             .Height        = 18
3562:             .FontName      = "Tahoma"
3563:             .FontSize      = 8
3564:             .SpecialEffect = 1
3565:             .Format        = "K"
3566:             .InputMask     = "999.99"
3567:             .Visible       = .T.
3568:         ENDWITH
3569: 
3570:         loc_oAba.AddObject("lbl_4c_Label6", "Label")
3571:         WITH loc_oAba.lbl_4c_Label6
3572:             .Caption   = "x"

*-- Linhas 3582 a 3600:
3582: 
3583:         loc_oAba.AddObject("txt_4c_CliDtEmiC", "TextBox")
3584:         WITH loc_oAba.txt_4c_CliDtEmiC
3585:             .ControlSource = "crSigCnFNf.cdtemi"
3586:             .Top           = 153
3587:             .Left          = 415
3588:             .Width         = 41
3589:             .Height        = 18
3590:             .FontName      = "Tahoma"
3591:             .FontSize      = 8
3592:             .SpecialEffect = 1
3593:             .Format        = "K"
3594:             .InputMask     = "999.99"
3595:             .Visible       = .T.
3596:         ENDWITH
3597: 
3598:         *-- Endereco (cliente, top=171)
3599:         loc_oAba.AddObject("lbl_4c_Label7", "Label")
3600:         WITH loc_oAba.lbl_4c_Label7

*-- Linhas 3611 a 3629:
3611: 
3612:         loc_oAba.AddObject("txt_4c_CliEnderL", "TextBox")
3613:         WITH loc_oAba.txt_4c_CliEnderL
3614:             .ControlSource = "crSigCnFNf.lender"
3615:             .Top           = 183
3616:             .Left          = 42
3617:             .Width         = 41
3618:             .Height        = 18
3619:             .FontName      = "Tahoma"
3620:             .FontSize      = 8
3621:             .SpecialEffect = 1
3622:             .Format        = "K"
3623:             .InputMask     = "999.99"
3624:             .Visible       = .T.
3625:         ENDWITH
3626: 
3627:         loc_oAba.AddObject("lbl_4c_Label8", "Label")
3628:         WITH loc_oAba.lbl_4c_Label8
3629:             .Caption   = "x"

*-- Linhas 3639 a 3657:
3639: 
3640:         loc_oAba.AddObject("txt_4c_CliEnderC", "TextBox")
3641:         WITH loc_oAba.txt_4c_CliEnderC
3642:             .ControlSource = "crSigCnFNf.cender"
3643:             .Top           = 183
3644:             .Left          = 91
3645:             .Width         = 41
3646:             .Height        = 18
3647:             .FontName      = "Tahoma"
3648:             .FontSize      = 8
3649:             .SpecialEffect = 1
3650:             .Format        = "K"
3651:             .InputMask     = "999.99"
3652:             .Visible       = .T.
3653:         ENDWITH
3654: 
3655:         *-- Bairro (cliente, top=171)
3656:         loc_oAba.AddObject("lbl_4c_Label9", "Label")
3657:         WITH loc_oAba.lbl_4c_Label9

*-- Linhas 3668 a 3686:
3668: 
3669:         loc_oAba.AddObject("txt_4c_CliBairrL", "TextBox")
3670:         WITH loc_oAba.txt_4c_CliBairrL
3671:             .ControlSource = "crSigCnFNf.lbairr"
3672:             .Top           = 183
3673:             .Left          = 149
3674:             .Width         = 41
3675:             .Height        = 18
3676:             .FontName      = "Tahoma"
3677:             .FontSize      = 8
3678:             .SpecialEffect = 1
3679:             .Format        = "K"
3680:             .InputMask     = "999.99"
3681:             .Visible       = .T.
3682:         ENDWITH
3683: 
3684:         loc_oAba.AddObject("lbl_4c_Label10", "Label")
3685:         WITH loc_oAba.lbl_4c_Label10
3686:             .Caption   = "x"

*-- Linhas 3696 a 3714:
3696: 
3697:         loc_oAba.AddObject("txt_4c_CliBairrC", "TextBox")
3698:         WITH loc_oAba.txt_4c_CliBairrC
3699:             .ControlSource = "crSigCnFNf.cbairr"
3700:             .Top           = 183
3701:             .Left          = 198
3702:             .Width         = 41
3703:             .Height        = 18
3704:             .FontName      = "Tahoma"
3705:             .FontSize      = 8
3706:             .SpecialEffect = 1
3707:             .Format        = "K"
3708:             .InputMask     = "999.99"
3709:             .Visible       = .T.
3710:         ENDWITH
3711: 
3712:         *-- Municipio (cliente, top=171)
3713:         loc_oAba.AddObject("lbl_4c_Label15", "Label")
3714:         WITH loc_oAba.lbl_4c_Label15

*-- Linhas 3725 a 3743:
3725: 
3726:         loc_oAba.AddObject("txt_4c_CliMuniL", "TextBox")
3727:         WITH loc_oAba.txt_4c_CliMuniL
3728:             .ControlSource = "crSigCnFNf.lmuni"
3729:             .Top           = 183
3730:             .Left          = 257
3731:             .Width         = 41
3732:             .Height        = 18
3733:             .FontName      = "Tahoma"
3734:             .FontSize      = 8
3735:             .SpecialEffect = 1
3736:             .Format        = "K"
3737:             .InputMask     = "999.99"
3738:             .Visible       = .T.
3739:         ENDWITH
3740: 
3741:         loc_oAba.AddObject("lbl_4c_Label16", "Label")
3742:         WITH loc_oAba.lbl_4c_Label16
3743:             .Caption   = "x"

*-- Linhas 3753 a 3771:
3753: 
3754:         loc_oAba.AddObject("txt_4c_CliMuniC", "TextBox")
3755:         WITH loc_oAba.txt_4c_CliMuniC
3756:             .ControlSource = "crSigCnFNf.cmuni"
3757:             .Top           = 183
3758:             .Left          = 306
3759:             .Width         = 41
3760:             .Height        = 18
3761:             .FontName      = "Tahoma"
3762:             .FontSize      = 8
3763:             .SpecialEffect = 1
3764:             .Format        = "K"
3765:             .InputMask     = "999.99"
3766:             .Visible       = .T.
3767:         ENDWITH
3768: 
3769:         *-- Estado (cliente, top=171)
3770:         loc_oAba.AddObject("lbl_4c_Label17", "Label")
3771:         WITH loc_oAba.lbl_4c_Label17

*-- Linhas 3782 a 3800:
3782: 
3783:         loc_oAba.AddObject("txt_4c_CliEstaL", "TextBox")
3784:         WITH loc_oAba.txt_4c_CliEstaL
3785:             .ControlSource = "crSigCnFNf.lesta"
3786:             .Top           = 183
3787:             .Left          = 365
3788:             .Width         = 41
3789:             .Height        = 18
3790:             .FontName      = "Tahoma"
3791:             .FontSize      = 8
3792:             .SpecialEffect = 1
3793:             .Format        = "K"
3794:             .InputMask     = "999.99"
3795:             .Visible       = .T.
3796:         ENDWITH
3797: 
3798:         loc_oAba.AddObject("lbl_4c_Label18", "Label")
3799:         WITH loc_oAba.lbl_4c_Label18
3800:             .Caption   = "x"

*-- Linhas 3810 a 3828:
3810: 
3811:         loc_oAba.AddObject("txt_4c_CliEstaC", "TextBox")
3812:         WITH loc_oAba.txt_4c_CliEstaC
3813:             .ControlSource = "crSigCnFNf.cesta"
3814:             .Top           = 183
3815:             .Left          = 414
3816:             .Width         = 41
3817:             .Height        = 18
3818:             .FontName      = "Tahoma"
3819:             .FontSize      = 8
3820:             .SpecialEffect = 1
3821:             .Format        = "K"
3822:             .InputMask     = "999.99"
3823:             .Visible       = .T.
3824:         ENDWITH
3825: 
3826:         *-- CEP (cliente, top=201)
3827:         loc_oAba.AddObject("lbl_4c_Label13", "Label")
3828:         WITH loc_oAba.lbl_4c_Label13

*-- Linhas 3839 a 3857:
3839: 
3840:         loc_oAba.AddObject("txt_4c_CliCepL", "TextBox")
3841:         WITH loc_oAba.txt_4c_CliCepL
3842:             .ControlSource = "crSigCnFNf.lcep"
3843:             .Top           = 213
3844:             .Left          = 41
3845:             .Width         = 41
3846:             .Height        = 18
3847:             .FontName      = "Tahoma"
3848:             .FontSize      = 8
3849:             .SpecialEffect = 1
3850:             .Format        = "K"
3851:             .InputMask     = "999.99"
3852:             .Visible       = .T.
3853:         ENDWITH
3854: 
3855:         loc_oAba.AddObject("lbl_4c_Label14", "Label")
3856:         WITH loc_oAba.lbl_4c_Label14
3857:             .Caption   = "x"

*-- Linhas 3867 a 3885:
3867: 
3868:         loc_oAba.AddObject("txt_4c_CliCepC", "TextBox")
3869:         WITH loc_oAba.txt_4c_CliCepC
3870:             .ControlSource = "crSigCnFNf.ccep"
3871:             .Top           = 213
3872:             .Left          = 90
3873:             .Width         = 41
3874:             .Height        = 18
3875:             .FontName      = "Tahoma"
3876:             .FontSize      = 8
3877:             .SpecialEffect = 1
3878:             .Format        = "K"
3879:             .InputMask     = "999.99"
3880:             .Visible       = .T.
3881:         ENDWITH
3882: 
3883:         *-- Fone/Fax (cliente, top=201)
3884:         loc_oAba.AddObject("lbl_4c_Label19", "Label")
3885:         WITH loc_oAba.lbl_4c_Label19

*-- Linhas 3896 a 3914:
3896: 
3897:         loc_oAba.AddObject("txt_4c_CliFoneL", "TextBox")
3898:         WITH loc_oAba.txt_4c_CliFoneL
3899:             .ControlSource = "crSigCnFNf.lfone"
3900:             .Top           = 213
3901:             .Left          = 149
3902:             .Width         = 41
3903:             .Height        = 18
3904:             .FontName      = "Tahoma"
3905:             .FontSize      = 8
3906:             .SpecialEffect = 1
3907:             .Format        = "K"
3908:             .InputMask     = "999.99"
3909:             .Visible       = .T.
3910:         ENDWITH
3911: 
3912:         loc_oAba.AddObject("lbl_4c_Label20", "Label")
3913:         WITH loc_oAba.lbl_4c_Label20
3914:             .Caption   = "x"

*-- Linhas 3924 a 3942:
3924: 
3925:         loc_oAba.AddObject("txt_4c_CliFoneC", "TextBox")
3926:         WITH loc_oAba.txt_4c_CliFoneC
3927:             .ControlSource = "crSigCnFNf.cfone"
3928:             .Top           = 213
3929:             .Left          = 198
3930:             .Width         = 41
3931:             .Height        = 18
3932:             .FontName      = "Tahoma"
3933:             .FontSize      = 8
3934:             .SpecialEffect = 1
3935:             .Format        = "K"
3936:             .InputMask     = "999.99"
3937:             .Visible       = .T.
3938:         ENDWITH
3939: 
3940:         *-- Secao: Endereco de Entrega - Empresa/Cliente (top=234 shape + top=238 header)
3941:         loc_oAba.AddObject("shp_4c_Shape2", "Shape")
3942:         WITH loc_oAba.shp_4c_Shape2

*-- Linhas 3980 a 3998:
3980: 
3981:         loc_oAba.AddObject("txt_4c_EntEnderL", "TextBox")
3982:         WITH loc_oAba.txt_4c_EntEnderL
3983:             .ControlSource = "crSigCnFN2.lendent"
3984:             .Top           = 264
3985:             .Left          = 42
3986:             .Width         = 41
3987:             .Height        = 18
3988:             .FontName      = "Tahoma"
3989:             .FontSize      = 8
3990:             .SpecialEffect = 1
3991:             .Format        = "K"
3992:             .InputMask     = "999.99"
3993:             .Visible       = .T.
3994:         ENDWITH
3995: 
3996:         loc_oAba.AddObject("lbl_4c_Label26", "Label")
3997:         WITH loc_oAba.lbl_4c_Label26
3998:             .Caption   = "x"

*-- Linhas 4008 a 4026:
4008: 
4009:         loc_oAba.AddObject("txt_4c_EntEnderC", "TextBox")
4010:         WITH loc_oAba.txt_4c_EntEnderC
4011:             .ControlSource = "crSigCnFN2.cendent"
4012:             .Top           = 264
4013:             .Left          = 91
4014:             .Width         = 41
4015:             .Height        = 18
4016:             .FontName      = "Tahoma"
4017:             .FontSize      = 8
4018:             .SpecialEffect = 1
4019:             .Format        = "K"
4020:             .InputMask     = "999.99"
4021:             .Visible       = .T.
4022:         ENDWITH
4023: 
4024:         *-- Entrega - Bairro (top=252)
4025:         loc_oAba.AddObject("lbl_4c_Label27", "Label")
4026:         WITH loc_oAba.lbl_4c_Label27

*-- Linhas 4037 a 4055:
4037: 
4038:         loc_oAba.AddObject("txt_4c_EntBairL", "TextBox")
4039:         WITH loc_oAba.txt_4c_EntBairL
4040:             .ControlSource = "crSigCnFN2.lbaient"
4041:             .Top           = 264
4042:             .Left          = 149
4043:             .Width         = 41
4044:             .Height        = 18
4045:             .FontName      = "Tahoma"
4046:             .FontSize      = 8
4047:             .SpecialEffect = 1
4048:             .Format        = "K"
4049:             .InputMask     = "999.99"
4050:             .Visible       = .T.
4051:         ENDWITH
4052: 
4053:         loc_oAba.AddObject("lbl_4c_Label28", "Label")
4054:         WITH loc_oAba.lbl_4c_Label28
4055:             .Caption   = "x"

*-- Linhas 4065 a 4083:
4065: 
4066:         loc_oAba.AddObject("txt_4c_EntBairC", "TextBox")
4067:         WITH loc_oAba.txt_4c_EntBairC
4068:             .ControlSource = "crSigCnFN2.cbaient"
4069:             .Top           = 264
4070:             .Left          = 198
4071:             .Width         = 41
4072:             .Height        = 18
4073:             .FontName      = "Tahoma"
4074:             .FontSize      = 8
4075:             .SpecialEffect = 1
4076:             .Format        = "K"
4077:             .InputMask     = "999.99"
4078:             .Visible       = .T.
4079:         ENDWITH
4080: 
4081:         *-- Entrega - Municipio (top=252)
4082:         loc_oAba.AddObject("lbl_4c_Label31", "Label")
4083:         WITH loc_oAba.lbl_4c_Label31

*-- Linhas 4094 a 4112:
4094: 
4095:         loc_oAba.AddObject("txt_4c_EntMuniL", "TextBox")
4096:         WITH loc_oAba.txt_4c_EntMuniL
4097:             .ControlSource = "crSigCnFN2.lmunent"
4098:             .Top           = 264
4099:             .Left          = 257
4100:             .Width         = 41
4101:             .Height        = 18
4102:             .FontName      = "Tahoma"
4103:             .FontSize      = 8
4104:             .SpecialEffect = 1
4105:             .Format        = "K"
4106:             .InputMask     = "999.99"
4107:             .Visible       = .T.
4108:         ENDWITH
4109: 
4110:         loc_oAba.AddObject("lbl_4c_Label32", "Label")
4111:         WITH loc_oAba.lbl_4c_Label32
4112:             .Caption   = "x"

*-- Linhas 4122 a 4140:
4122: 
4123:         loc_oAba.AddObject("txt_4c_EntMuniC", "TextBox")
4124:         WITH loc_oAba.txt_4c_EntMuniC
4125:             .ControlSource = "crSigCnFN2.cmunent"
4126:             .Top           = 264
4127:             .Left          = 306
4128:             .Width         = 41
4129:             .Height        = 18
4130:             .FontName      = "Tahoma"
4131:             .FontSize      = 8
4132:             .SpecialEffect = 1
4133:             .Format        = "K"
4134:             .InputMask     = "999.99"
4135:             .Visible       = .T.
4136:         ENDWITH
4137: 
4138:         *-- Entrega - Estado (top=252)
4139:         loc_oAba.AddObject("lbl_4c_Label33", "Label")
4140:         WITH loc_oAba.lbl_4c_Label33

*-- Linhas 4151 a 4169:
4151: 
4152:         loc_oAba.AddObject("txt_4c_EntEstaL", "TextBox")
4153:         WITH loc_oAba.txt_4c_EntEstaL
4154:             .ControlSource = "crSigCnFN2.lestent"
4155:             .Top           = 264
4156:             .Left          = 365
4157:             .Width         = 41
4158:             .Height        = 18
4159:             .FontName      = "Tahoma"
4160:             .FontSize      = 8
4161:             .SpecialEffect = 1
4162:             .Format        = "K"
4163:             .InputMask     = "999.99"
4164:             .Visible       = .T.
4165:         ENDWITH
4166: 
4167:         loc_oAba.AddObject("lbl_4c_Label34", "Label")
4168:         WITH loc_oAba.lbl_4c_Label34
4169:             .Caption   = "x"

*-- Linhas 4179 a 4197:
4179: 
4180:         loc_oAba.AddObject("txt_4c_EntEstaC", "TextBox")
4181:         WITH loc_oAba.txt_4c_EntEstaC
4182:             .ControlSource = "crSigCnFN2.cestent"
4183:             .Top           = 264
4184:             .Left          = 414
4185:             .Width         = 41
4186:             .Height        = 18
4187:             .FontName      = "Tahoma"
4188:             .FontSize      = 8
4189:             .SpecialEffect = 1
4190:             .Format        = "K"
4191:             .InputMask     = "999.99"
4192:             .Visible       = .T.
4193:         ENDWITH
4194: 
4195:         *-- Entrega - CEP (top=282)
4196:         loc_oAba.AddObject("lbl_4c_Label29", "Label")
4197:         WITH loc_oAba.lbl_4c_Label29

*-- Linhas 4208 a 4226:
4208: 
4209:         loc_oAba.AddObject("txt_4c_EntCepL", "TextBox")
4210:         WITH loc_oAba.txt_4c_EntCepL
4211:             .ControlSource = "crSigCnFN2.lcepent"
4212:             .Top           = 294
4213:             .Left          = 41
4214:             .Width         = 41
4215:             .Height        = 18
4216:             .FontName      = "Tahoma"
4217:             .FontSize      = 8
4218:             .SpecialEffect = 1
4219:             .Format        = "K"
4220:             .InputMask     = "999.99"
4221:             .Visible       = .T.
4222:         ENDWITH
4223: 
4224:         loc_oAba.AddObject("lbl_4c_Label30", "Label")
4225:         WITH loc_oAba.lbl_4c_Label30
4226:             .Caption   = "x"

*-- Linhas 4236 a 4254:
4236: 
4237:         loc_oAba.AddObject("txt_4c_EntCepC", "TextBox")
4238:         WITH loc_oAba.txt_4c_EntCepC
4239:             .ControlSource = "crSigCnFN2.ccepent"
4240:             .Top           = 294
4241:             .Left          = 90
4242:             .Width         = 41
4243:             .Height        = 18
4244:             .FontName      = "Tahoma"
4245:             .FontSize      = 8
4246:             .SpecialEffect = 1
4247:             .Format        = "K"
4248:             .InputMask     = "999.99"
4249:             .Visible       = .T.
4250:         ENDWITH
4251: 
4252:         *-- Entrega - Fone/Fax (top=282)
4253:         loc_oAba.AddObject("lbl_4c_Label35", "Label")
4254:         WITH loc_oAba.lbl_4c_Label35

*-- Linhas 4265 a 4283:
4265: 
4266:         loc_oAba.AddObject("txt_4c_EntFoneL", "TextBox")
4267:         WITH loc_oAba.txt_4c_EntFoneL
4268:             .ControlSource = "crSigCnFN2.lfoneent"
4269:             .Top           = 294
4270:             .Left          = 149
4271:             .Width         = 41
4272:             .Height        = 18
4273:             .FontName      = "Tahoma"
4274:             .FontSize      = 8
4275:             .SpecialEffect = 1
4276:             .Format        = "K"
4277:             .InputMask     = "999.99"
4278:             .Visible       = .T.
4279:         ENDWITH
4280: 
4281:         loc_oAba.AddObject("lbl_4c_Label36", "Label")
4282:         WITH loc_oAba.lbl_4c_Label36
4283:             .Caption   = "x"

*-- Linhas 4293 a 4311:
4293: 
4294:         loc_oAba.AddObject("txt_4c_EntFoneC", "TextBox")
4295:         WITH loc_oAba.txt_4c_EntFoneC
4296:             .ControlSource = "crSigCnFN2.cfoneent"
4297:             .Top           = 294
4298:             .Left          = 198
4299:             .Width         = 41
4300:             .Height        = 18
4301:             .FontName      = "Tahoma"
4302:             .FontSize      = 8
4303:             .SpecialEffect = 1
4304:             .Format        = "K"
4305:             .InputMask     = "999.99"
4306:             .Visible       = .T.
4307:         ENDWITH
4308: 
4309:         *-- Entrega - Titulo de Impressao (top=282)
4310:         loc_oAba.AddObject("lbl_4c_Label39", "Label")
4311:         WITH loc_oAba.lbl_4c_Label39

*-- Linhas 4322 a 4340:
4322: 
4323:         loc_oAba.AddObject("txt_4c_EntTitEndL", "TextBox")
4324:         WITH loc_oAba.txt_4c_EntTitEndL
4325:             .ControlSource = "crSigCnFN2.lendtite"
4326:             .Top           = 294
4327:             .Left          = 257
4328:             .Width         = 41
4329:             .Height        = 18
4330:             .FontName      = "Tahoma"
4331:             .FontSize      = 8
4332:             .SpecialEffect = 1
4333:             .Format        = "K"
4334:             .InputMask     = "999.99"
4335:             .Visible       = .T.
4336:         ENDWITH
4337: 
4338:         loc_oAba.AddObject("lbl_4c_Label40", "Label")
4339:         WITH loc_oAba.lbl_4c_Label40
4340:             .Caption   = "x"

*-- Linhas 4350 a 4383:
4350: 
4351:         loc_oAba.AddObject("txt_4c_EntTitEndC", "TextBox")
4352:         WITH loc_oAba.txt_4c_EntTitEndC
4353:             .ControlSource = "crSigCnFN2.cendtite"
4354:             .Top           = 294
4355:             .Left          = 306
4356:             .Width         = 41
4357:             .Height        = 18
4358:             .FontName      = "Tahoma"
4359:             .FontSize      = 8
4360:             .SpecialEffect = 1
4361:             .Format        = "K"
4362:             .InputMask     = "999.99"
4363:             .Visible       = .T.
4364:         ENDWITH
4365: 
4366:         loc_oAba.AddObject("txt_4c_EntTitulo", "TextBox")
4367:         WITH loc_oAba.txt_4c_EntTitulo
4368:             .ControlSource = "crSigCnFN2.ctitent"
4369:             .Top           = 294
4370:             .Left          = 353
4371:             .Width         = 150
4372:             .Height        = 18
4373:             .MaxLength     = 20
4374:             .FontName      = "Tahoma"
4375:             .FontSize      = 8
4376:             .SpecialEffect = 1
4377:             .Format        = "K"
4378:             .InputMask     = ""
4379:             .Visible       = .T.
4380:         ENDWITH
4381: 
4382:         *-- Secao: Codigo Posto Fiscal / Codigo Suframa (top=313)
4383:         loc_oAba.AddObject("lbl_4c_Label11", "Label")

*-- Linhas 4395 a 4413:
4395: 
4396:         loc_oAba.AddObject("txt_4c_PosFisL", "TextBox")
4397:         WITH loc_oAba.txt_4c_PosFisL
4398:             .ControlSource = "crSigCnFNf.lposfis"
4399:             .Top           = 325
4400:             .Left          = 41
4401:             .Width         = 41
4402:             .Height        = 18
4403:             .FontName      = "Tahoma"
4404:             .FontSize      = 8
4405:             .SpecialEffect = 1
4406:             .Format        = "K"
4407:             .InputMask     = "999.99"
4408:             .Visible       = .T.
4409:         ENDWITH
4410: 
4411:         loc_oAba.AddObject("lbl_4c_Label12", "Label")
4412:         WITH loc_oAba.lbl_4c_Label12
4413:             .Caption   = "x"

*-- Linhas 4423 a 4441:
4423: 
4424:         loc_oAba.AddObject("txt_4c_PosFisC", "TextBox")
4425:         WITH loc_oAba.txt_4c_PosFisC
4426:             .ControlSource = "crSigCnFNf.cposfis"
4427:             .Top           = 325
4428:             .Left          = 90
4429:             .Width         = 41
4430:             .Height        = 18
4431:             .FontName      = "Tahoma"
4432:             .FontSize      = 8
4433:             .SpecialEffect = 1
4434:             .Format        = "K"
4435:             .InputMask     = "999.99"
4436:             .Visible       = .T.
4437:         ENDWITH
4438: 
4439:         loc_oAba.AddObject("lbl_4c_Label23", "Label")
4440:         WITH loc_oAba.lbl_4c_Label23
4441:             .Caption   = "C" + CHR(243) + "digo Suframa"

*-- Linhas 4451 a 4469:
4451: 
4452:         loc_oAba.AddObject("txt_4c_SuframaL", "TextBox")
4453:         WITH loc_oAba.txt_4c_SuframaL
4454:             .ControlSource = "crSigCnFNf.lsufras"
4455:             .Top           = 325
4456:             .Left          = 149
4457:             .Width         = 41
4458:             .Height        = 18
4459:             .FontName      = "Tahoma"
4460:             .FontSize      = 8
4461:             .SpecialEffect = 1
4462:             .Format        = "K"
4463:             .InputMask     = "999.99"
4464:             .Visible       = .T.
4465:         ENDWITH
4466: 
4467:         loc_oAba.AddObject("lbl_4c_Label24", "Label")
4468:         WITH loc_oAba.lbl_4c_Label24
4469:             .Caption   = "x"

*-- Linhas 4479 a 4497:
4479: 
4480:         loc_oAba.AddObject("txt_4c_SuframaC", "TextBox")
4481:         WITH loc_oAba.txt_4c_SuframaC
4482:             .ControlSource = "crSigCnFNf.csufras"
4483:             .Top           = 325
4484:             .Left          = 198
4485:             .Width         = 41
4486:             .Height        = 18
4487:             .FontName      = "Tahoma"
4488:             .FontSize      = 8
4489:             .SpecialEffect = 1
4490:             .Format        = "K"
4491:             .InputMask     = "999.99"
4492:             .Visible       = .T.
4493:         ENDWITH
4494:     ENDPROC
4495: 
4496:     *--------------------------------------------------------------------------
4497:     PROTECTED PROCEDURE ConfigurarDesdobramentoTab()

*-- Linhas 4554 a 4572:
4554:         ENDWITH
4555:         loc_oAba.AddObject("txt_4c_Fat1NumL", "TextBox")
4556:         WITH loc_oAba.txt_4c_Fat1NumL
4557:             .ControlSource = "crSigCnFNf.lfat1num"
4558:             .Top = 37
4559:             .Left = 58
4560:             .Width = 41
4561:             .Height = 18
4562:             .FontName = "Tahoma"
4563:             .FontSize = 8
4564:             .SpecialEffect = 1
4565:             .Format = "K"
4566:             .InputMask = "999.99"
4567:             .Visible = .T.
4568:         ENDWITH
4569:         loc_oAba.AddObject("lbl_4c_F1NX", "Label")
4570:         WITH loc_oAba.lbl_4c_F1NX
4571:             .Caption = "x"
4572:             .Top = 39

*-- Linhas 4580 a 4612:
4580:         ENDWITH
4581:         loc_oAba.AddObject("txt_4c_Fat1NumC", "TextBox")
4582:         WITH loc_oAba.txt_4c_Fat1NumC
4583:             .ControlSource = "crSigCnFNf.cfat1num"
4584:             .Top = 37
4585:             .Left = 107
4586:             .Width = 41
4587:             .Height = 18
4588:             .FontName = "Tahoma"
4589:             .FontSize = 8
4590:             .SpecialEffect = 1
4591:             .Format = "K"
4592:             .InputMask = "999.99"
4593:             .Visible = .T.
4594:         ENDWITH
4595:         loc_oAba.AddObject("txt_4c_Fat1ValL", "TextBox")
4596:         WITH loc_oAba.txt_4c_Fat1ValL
4597:             .ControlSource = "crSigCnFNf.lfat1val"
4598:             .Top = 37
4599:             .Left = 165
4600:             .Width = 41
4601:             .Height = 18
4602:             .FontName = "Tahoma"
4603:             .FontSize = 8
4604:             .SpecialEffect = 1
4605:             .Format = "K"
4606:             .InputMask = "999.99"
4607:             .Visible = .T.
4608:         ENDWITH
4609:         loc_oAba.AddObject("lbl_4c_F1VX", "Label")
4610:         WITH loc_oAba.lbl_4c_F1VX
4611:             .Caption = "x"
4612:             .Top = 39

*-- Linhas 4620 a 4652:
4620:         ENDWITH
4621:         loc_oAba.AddObject("txt_4c_Fat1ValC", "TextBox")
4622:         WITH loc_oAba.txt_4c_Fat1ValC
4623:             .ControlSource = "crSigCnFNf.cfat1val"
4624:             .Top = 37
4625:             .Left = 214
4626:             .Width = 41
4627:             .Height = 18
4628:             .FontName = "Tahoma"
4629:             .FontSize = 8
4630:             .SpecialEffect = 1
4631:             .Format = "K"
4632:             .InputMask = "999.99"
4633:             .Visible = .T.
4634:         ENDWITH
4635:         loc_oAba.AddObject("txt_4c_Fat1VecL", "TextBox")
4636:         WITH loc_oAba.txt_4c_Fat1VecL
4637:             .ControlSource = "crSigCnFNf.lfat1vec"
4638:             .Top = 37
4639:             .Left = 273
4640:             .Width = 41
4641:             .Height = 18
4642:             .FontName = "Tahoma"
4643:             .FontSize = 8
4644:             .SpecialEffect = 1
4645:             .Format = "K"
4646:             .InputMask = "999.99"
4647:             .Visible = .T.
4648:         ENDWITH
4649:         loc_oAba.AddObject("lbl_4c_F1EX", "Label")
4650:         WITH loc_oAba.lbl_4c_F1EX
4651:             .Caption = "x"
4652:             .Top = 39

*-- Linhas 4660 a 4678:
4660:         ENDWITH
4661:         loc_oAba.AddObject("txt_4c_Fat1VecC", "TextBox")
4662:         WITH loc_oAba.txt_4c_Fat1VecC
4663:             .ControlSource = "crSigCnFNf.cfat1vec"
4664:             .Top = 37
4665:             .Left = 322
4666:             .Width = 41
4667:             .Height = 18
4668:             .FontName = "Tahoma"
4669:             .FontSize = 8
4670:             .SpecialEffect = 1
4671:             .Format = "K"
4672:             .InputMask = "999.99"
4673:             .Visible = .T.
4674:         ENDWITH
4675: 
4676:         *-- Fatura 2 (top=56/58)
4677:         loc_oAba.AddObject("lbl_4c_Fat2", "Label")
4678:         WITH loc_oAba.lbl_4c_Fat2

*-- Linhas 4688 a 4706:
4688:         ENDWITH
4689:         loc_oAba.AddObject("txt_4c_Fat2NumL", "TextBox")
4690:         WITH loc_oAba.txt_4c_Fat2NumL
4691:             .ControlSource = "crSigCnFNf.lfat2num"
4692:             .Top = 56
4693:             .Left = 58
4694:             .Width = 41
4695:             .Height = 18
4696:             .FontName = "Tahoma"
4697:             .FontSize = 8
4698:             .SpecialEffect = 1
4699:             .Format = "K"
4700:             .InputMask = "999.99"
4701:             .Visible = .T.
4702:         ENDWITH
4703:         loc_oAba.AddObject("lbl_4c_F2NX", "Label")
4704:         WITH loc_oAba.lbl_4c_F2NX
4705:             .Caption = "x"
4706:             .Top = 58

*-- Linhas 4714 a 4746:
4714:         ENDWITH
4715:         loc_oAba.AddObject("txt_4c_Fat2NumC", "TextBox")
4716:         WITH loc_oAba.txt_4c_Fat2NumC
4717:             .ControlSource = "crSigCnFNf.cfat2num"
4718:             .Top = 56
4719:             .Left = 107
4720:             .Width = 41
4721:             .Height = 18
4722:             .FontName = "Tahoma"
4723:             .FontSize = 8
4724:             .SpecialEffect = 1
4725:             .Format = "K"
4726:             .InputMask = "999.99"
4727:             .Visible = .T.
4728:         ENDWITH
4729:         loc_oAba.AddObject("txt_4c_Fat2ValL", "TextBox")
4730:         WITH loc_oAba.txt_4c_Fat2ValL
4731:             .ControlSource = "crSigCnFNf.lfat2val"
4732:             .Top = 56
4733:             .Left = 165
4734:             .Width = 41
4735:             .Height = 18
4736:             .FontName = "Tahoma"
4737:             .FontSize = 8
4738:             .SpecialEffect = 1
4739:             .Format = "K"
4740:             .InputMask = "999.99"
4741:             .Visible = .T.
4742:         ENDWITH
4743:         loc_oAba.AddObject("lbl_4c_F2VX", "Label")
4744:         WITH loc_oAba.lbl_4c_F2VX
4745:             .Caption = "x"
4746:             .Top = 58

*-- Linhas 4754 a 4786:
4754:         ENDWITH
4755:         loc_oAba.AddObject("txt_4c_Fat2ValC", "TextBox")
4756:         WITH loc_oAba.txt_4c_Fat2ValC
4757:             .ControlSource = "crSigCnFNf.cfat2val"
4758:             .Top = 56
4759:             .Left = 214
4760:             .Width = 41
4761:             .Height = 18
4762:             .FontName = "Tahoma"
4763:             .FontSize = 8
4764:             .SpecialEffect = 1
4765:             .Format = "K"
4766:             .InputMask = "999.99"
4767:             .Visible = .T.
4768:         ENDWITH
4769:         loc_oAba.AddObject("txt_4c_Fat2VecL", "TextBox")
4770:         WITH loc_oAba.txt_4c_Fat2VecL
4771:             .ControlSource = "crSigCnFNf.lfat2vec"
4772:             .Top = 56
4773:             .Left = 273
4774:             .Width = 41
4775:             .Height = 18
4776:             .FontName = "Tahoma"
4777:             .FontSize = 8
4778:             .SpecialEffect = 1
4779:             .Format = "K"
4780:             .InputMask = "999.99"
4781:             .Visible = .T.
4782:         ENDWITH
4783:         loc_oAba.AddObject("lbl_4c_F2EX", "Label")
4784:         WITH loc_oAba.lbl_4c_F2EX
4785:             .Caption = "x"
4786:             .Top = 58

*-- Linhas 4794 a 4812:
4794:         ENDWITH
4795:         loc_oAba.AddObject("txt_4c_Fat2VecC", "TextBox")
4796:         WITH loc_oAba.txt_4c_Fat2VecC
4797:             .ControlSource = "crSigCnFNf.cfat2vec"
4798:             .Top = 56
4799:             .Left = 322
4800:             .Width = 41
4801:             .Height = 18
4802:             .FontName = "Tahoma"
4803:             .FontSize = 8
4804:             .SpecialEffect = 1
4805:             .Format = "K"
4806:             .InputMask = "999.99"
4807:             .Visible = .T.
4808:         ENDWITH
4809: 
4810:         *-- Fatura 3 (top=75/77)
4811:         loc_oAba.AddObject("lbl_4c_Fat3", "Label")
4812:         WITH loc_oAba.lbl_4c_Fat3

*-- Linhas 4822 a 4840:
4822:         ENDWITH
4823:         loc_oAba.AddObject("txt_4c_Fat3NumL", "TextBox")
4824:         WITH loc_oAba.txt_4c_Fat3NumL
4825:             .ControlSource = "crSigCnFNf.lfat3num"
4826:             .Top = 75
4827:             .Left = 58
4828:             .Width = 41
4829:             .Height = 18
4830:             .FontName = "Tahoma"
4831:             .FontSize = 8
4832:             .SpecialEffect = 1
4833:             .Format = "K"
4834:             .InputMask = "999.99"
4835:             .Visible = .T.
4836:         ENDWITH
4837:         loc_oAba.AddObject("lbl_4c_F3NX", "Label")
4838:         WITH loc_oAba.lbl_4c_F3NX
4839:             .Caption = "x"
4840:             .Top = 77

*-- Linhas 4848 a 4880:
4848:         ENDWITH
4849:         loc_oAba.AddObject("txt_4c_Fat3NumC", "TextBox")
4850:         WITH loc_oAba.txt_4c_Fat3NumC
4851:             .ControlSource = "crSigCnFNf.cfat3num"
4852:             .Top = 75
4853:             .Left = 107
4854:             .Width = 41
4855:             .Height = 18
4856:             .FontName = "Tahoma"
4857:             .FontSize = 8
4858:             .SpecialEffect = 1
4859:             .Format = "K"
4860:             .InputMask = "999.99"
4861:             .Visible = .T.
4862:         ENDWITH
4863:         loc_oAba.AddObject("txt_4c_Fat3ValL", "TextBox")
4864:         WITH loc_oAba.txt_4c_Fat3ValL
4865:             .ControlSource = "crSigCnFNf.lfat3val"
4866:             .Top = 75
4867:             .Left = 165
4868:             .Width = 41
4869:             .Height = 18
4870:             .FontName = "Tahoma"
4871:             .FontSize = 8
4872:             .SpecialEffect = 1
4873:             .Format = "K"
4874:             .InputMask = "999.99"
4875:             .Visible = .T.
4876:         ENDWITH
4877:         loc_oAba.AddObject("lbl_4c_F3VX", "Label")
4878:         WITH loc_oAba.lbl_4c_F3VX
4879:             .Caption = "x"
4880:             .Top = 77

*-- Linhas 4888 a 4920:
4888:         ENDWITH
4889:         loc_oAba.AddObject("txt_4c_Fat3ValC", "TextBox")
4890:         WITH loc_oAba.txt_4c_Fat3ValC
4891:             .ControlSource = "crSigCnFNf.cfat3val"
4892:             .Top = 75
4893:             .Left = 214
4894:             .Width = 41
4895:             .Height = 18
4896:             .FontName = "Tahoma"
4897:             .FontSize = 8
4898:             .SpecialEffect = 1
4899:             .Format = "K"
4900:             .InputMask = "999.99"
4901:             .Visible = .T.
4902:         ENDWITH
4903:         loc_oAba.AddObject("txt_4c_Fat3VecL", "TextBox")
4904:         WITH loc_oAba.txt_4c_Fat3VecL
4905:             .ControlSource = "crSigCnFNf.lfat3vec"
4906:             .Top = 75
4907:             .Left = 273
4908:             .Width = 41
4909:             .Height = 18
4910:             .FontName = "Tahoma"
4911:             .FontSize = 8
4912:             .SpecialEffect = 1
4913:             .Format = "K"
4914:             .InputMask = "999.99"
4915:             .Visible = .T.
4916:         ENDWITH
4917:         loc_oAba.AddObject("lbl_4c_F3EX", "Label")
4918:         WITH loc_oAba.lbl_4c_F3EX
4919:             .Caption = "x"
4920:             .Top = 77

*-- Linhas 4928 a 4946:
4928:         ENDWITH
4929:         loc_oAba.AddObject("txt_4c_Fat3VecC", "TextBox")
4930:         WITH loc_oAba.txt_4c_Fat3VecC
4931:             .ControlSource = "crSigCnFNf.cfat3vec"
4932:             .Top = 75
4933:             .Left = 322
4934:             .Width = 41
4935:             .Height = 18
4936:             .FontName = "Tahoma"
4937:             .FontSize = 8
4938:             .SpecialEffect = 1
4939:             .Format = "K"
4940:             .InputMask = "999.99"
4941:             .Visible = .T.
4942:         ENDWITH
4943: 
4944:         *-- Fatura 4 (top=94/96)
4945:         loc_oAba.AddObject("lbl_4c_Fat4", "Label")
4946:         WITH loc_oAba.lbl_4c_Fat4

*-- Linhas 4956 a 4974:
4956:         ENDWITH
4957:         loc_oAba.AddObject("txt_4c_Fat4NumL", "TextBox")
4958:         WITH loc_oAba.txt_4c_Fat4NumL
4959:             .ControlSource = "crSigCnFNf.lfat4num"
4960:             .Top = 94
4961:             .Left = 58
4962:             .Width = 41
4963:             .Height = 18
4964:             .FontName = "Tahoma"
4965:             .FontSize = 8
4966:             .SpecialEffect = 1
4967:             .Format = "K"
4968:             .InputMask = "999.99"
4969:             .Visible = .T.
4970:         ENDWITH
4971:         loc_oAba.AddObject("lbl_4c_F4NX", "Label")
4972:         WITH loc_oAba.lbl_4c_F4NX
4973:             .Caption = "x"
4974:             .Top = 96

*-- Linhas 4982 a 5014:
4982:         ENDWITH
4983:         loc_oAba.AddObject("txt_4c_Fat4NumC", "TextBox")
4984:         WITH loc_oAba.txt_4c_Fat4NumC
4985:             .ControlSource = "crSigCnFNf.cfat4num"
4986:             .Top = 94
4987:             .Left = 107
4988:             .Width = 41
4989:             .Height = 18
4990:             .FontName = "Tahoma"
4991:             .FontSize = 8
4992:             .SpecialEffect = 1
4993:             .Format = "K"
4994:             .InputMask = "999.99"
4995:             .Visible = .T.
4996:         ENDWITH
4997:         loc_oAba.AddObject("txt_4c_Fat4ValL", "TextBox")
4998:         WITH loc_oAba.txt_4c_Fat4ValL
4999:             .ControlSource = "crSigCnFNf.lfat4val"
5000:             .Top = 94
5001:             .Left = 165
5002:             .Width = 41
5003:             .Height = 18
5004:             .FontName = "Tahoma"
5005:             .FontSize = 8
5006:             .SpecialEffect = 1
5007:             .Format = "K"
5008:             .InputMask = "999.99"
5009:             .Visible = .T.
5010:         ENDWITH
5011:         loc_oAba.AddObject("lbl_4c_F4VX", "Label")
5012:         WITH loc_oAba.lbl_4c_F4VX
5013:             .Caption = "x"
5014:             .Top = 96

*-- Linhas 5022 a 5054:
5022:         ENDWITH
5023:         loc_oAba.AddObject("txt_4c_Fat4ValC", "TextBox")
5024:         WITH loc_oAba.txt_4c_Fat4ValC
5025:             .ControlSource = "crSigCnFNf.cfat4val"
5026:             .Top = 94
5027:             .Left = 214
5028:             .Width = 41
5029:             .Height = 18
5030:             .FontName = "Tahoma"
5031:             .FontSize = 8
5032:             .SpecialEffect = 1
5033:             .Format = "K"
5034:             .InputMask = "999.99"
5035:             .Visible = .T.
5036:         ENDWITH
5037:         loc_oAba.AddObject("txt_4c_Fat4VecL", "TextBox")
5038:         WITH loc_oAba.txt_4c_Fat4VecL
5039:             .ControlSource = "crSigCnFNf.lfat4vec"
5040:             .Top = 94
5041:             .Left = 273
5042:             .Width = 41
5043:             .Height = 18
5044:             .FontName = "Tahoma"
5045:             .FontSize = 8
5046:             .SpecialEffect = 1
5047:             .Format = "K"
5048:             .InputMask = "999.99"
5049:             .Visible = .T.
5050:         ENDWITH
5051:         loc_oAba.AddObject("lbl_4c_F4EX", "Label")
5052:         WITH loc_oAba.lbl_4c_F4EX
5053:             .Caption = "x"
5054:             .Top = 96

*-- Linhas 5062 a 5080:
5062:         ENDWITH
5063:         loc_oAba.AddObject("txt_4c_Fat4VecC", "TextBox")
5064:         WITH loc_oAba.txt_4c_Fat4VecC
5065:             .ControlSource = "crSigCnFNf.cfat4vec"
5066:             .Top = 94
5067:             .Left = 322
5068:             .Width = 41
5069:             .Height = 18
5070:             .FontName = "Tahoma"
5071:             .FontSize = 8
5072:             .SpecialEffect = 1
5073:             .Format = "K"
5074:             .InputMask = "999.99"
5075:             .Visible = .T.
5076:         ENDWITH
5077: 
5078:         *-- Fatura 5 (top=113/115)
5079:         loc_oAba.AddObject("lbl_4c_Fat5", "Label")
5080:         WITH loc_oAba.lbl_4c_Fat5

*-- Linhas 5090 a 5108:
5090:         ENDWITH
5091:         loc_oAba.AddObject("txt_4c_Fat5NumL", "TextBox")
5092:         WITH loc_oAba.txt_4c_Fat5NumL
5093:             .ControlSource = "crSigCnFNf.lfat5num"
5094:             .Top = 113
5095:             .Left = 58
5096:             .Width = 41
5097:             .Height = 18
5098:             .FontName = "Tahoma"
5099:             .FontSize = 8
5100:             .SpecialEffect = 1
5101:             .Format = "K"
5102:             .InputMask = "999.99"
5103:             .Visible = .T.
5104:         ENDWITH
5105:         loc_oAba.AddObject("lbl_4c_F5NX", "Label")
5106:         WITH loc_oAba.lbl_4c_F5NX
5107:             .Caption = "x"
5108:             .Top = 115

*-- Linhas 5116 a 5148:
5116:         ENDWITH
5117:         loc_oAba.AddObject("txt_4c_Fat5NumC", "TextBox")
5118:         WITH loc_oAba.txt_4c_Fat5NumC
5119:             .ControlSource = "crSigCnFNf.cfat5num"
5120:             .Top = 113
5121:             .Left = 107
5122:             .Width = 41
5123:             .Height = 18
5124:             .FontName = "Tahoma"
5125:             .FontSize = 8
5126:             .SpecialEffect = 1
5127:             .Format = "K"
5128:             .InputMask = "999.99"
5129:             .Visible = .T.
5130:         ENDWITH
5131:         loc_oAba.AddObject("txt_4c_Fat5ValL", "TextBox")
5132:         WITH loc_oAba.txt_4c_Fat5ValL
5133:             .ControlSource = "crSigCnFNf.lfat5val"
5134:             .Top = 113
5135:             .Left = 165
5136:             .Width = 41
5137:             .Height = 18
5138:             .FontName = "Tahoma"
5139:             .FontSize = 8
5140:             .SpecialEffect = 1
5141:             .Format = "K"
5142:             .InputMask = "999.99"
5143:             .Visible = .T.
5144:         ENDWITH
5145:         loc_oAba.AddObject("lbl_4c_F5VX", "Label")
5146:         WITH loc_oAba.lbl_4c_F5VX
5147:             .Caption = "x"
5148:             .Top = 115

*-- Linhas 5156 a 5188:
5156:         ENDWITH
5157:         loc_oAba.AddObject("txt_4c_Fat5ValC", "TextBox")
5158:         WITH loc_oAba.txt_4c_Fat5ValC
5159:             .ControlSource = "crSigCnFNf.cfat5val"
5160:             .Top = 113
5161:             .Left = 214
5162:             .Width = 41
5163:             .Height = 18
5164:             .FontName = "Tahoma"
5165:             .FontSize = 8
5166:             .SpecialEffect = 1
5167:             .Format = "K"
5168:             .InputMask = "999.99"
5169:             .Visible = .T.
5170:         ENDWITH
5171:         loc_oAba.AddObject("txt_4c_Fat5VecL", "TextBox")
5172:         WITH loc_oAba.txt_4c_Fat5VecL
5173:             .ControlSource = "crSigCnFNf.lfat5vec"
5174:             .Top = 113
5175:             .Left = 273
5176:             .Width = 41
5177:             .Height = 18
5178:             .FontName = "Tahoma"
5179:             .FontSize = 8
5180:             .SpecialEffect = 1
5181:             .Format = "K"
5182:             .InputMask = "999.99"
5183:             .Visible = .T.
5184:         ENDWITH
5185:         loc_oAba.AddObject("lbl_4c_F5EX", "Label")
5186:         WITH loc_oAba.lbl_4c_F5EX
5187:             .Caption = "x"
5188:             .Top = 115

*-- Linhas 5196 a 5214:
5196:         ENDWITH
5197:         loc_oAba.AddObject("txt_4c_Fat5VecC", "TextBox")
5198:         WITH loc_oAba.txt_4c_Fat5VecC
5199:             .ControlSource = "crSigCnFNf.cfat5vec"
5200:             .Top = 113
5201:             .Left = 322
5202:             .Width = 41
5203:             .Height = 18
5204:             .FontName = "Tahoma"
5205:             .FontSize = 8
5206:             .SpecialEffect = 1
5207:             .Format = "K"
5208:             .InputMask = "999.99"
5209:             .Visible = .T.
5210:         ENDWITH
5211: 
5212:         *-- Fatura 6 (top=132/134)
5213:         loc_oAba.AddObject("lbl_4c_Fat6", "Label")
5214:         WITH loc_oAba.lbl_4c_Fat6

*-- Linhas 5224 a 5242:
5224:         ENDWITH
5225:         loc_oAba.AddObject("txt_4c_Fat6NumL", "TextBox")
5226:         WITH loc_oAba.txt_4c_Fat6NumL
5227:             .ControlSource = "crSigCnFNf.lfat6num"
5228:             .Top = 132
5229:             .Left = 58
5230:             .Width = 41
5231:             .Height = 18
5232:             .FontName = "Tahoma"
5233:             .FontSize = 8
5234:             .SpecialEffect = 1
5235:             .Format = "K"
5236:             .InputMask = "999.99"
5237:             .Visible = .T.
5238:         ENDWITH
5239:         loc_oAba.AddObject("lbl_4c_F6NX", "Label")
5240:         WITH loc_oAba.lbl_4c_F6NX
5241:             .Caption = "x"
5242:             .Top = 134

*-- Linhas 5250 a 5282:
5250:         ENDWITH
5251:         loc_oAba.AddObject("txt_4c_Fat6NumC", "TextBox")
5252:         WITH loc_oAba.txt_4c_Fat6NumC
5253:             .ControlSource = "crSigCnFNf.cfat6num"
5254:             .Top = 132
5255:             .Left = 107
5256:             .Width = 41
5257:             .Height = 18
5258:             .FontName = "Tahoma"
5259:             .FontSize = 8
5260:             .SpecialEffect = 1
5261:             .Format = "K"
5262:             .InputMask = "999.99"
5263:             .Visible = .T.
5264:         ENDWITH
5265:         loc_oAba.AddObject("txt_4c_Fat6ValL", "TextBox")
5266:         WITH loc_oAba.txt_4c_Fat6ValL
5267:             .ControlSource = "crSigCnFNf.lfat6val"
5268:             .Top = 132
5269:             .Left = 165
5270:             .Width = 41
5271:             .Height = 18
5272:             .FontName = "Tahoma"
5273:             .FontSize = 8
5274:             .SpecialEffect = 1
5275:             .Format = "K"
5276:             .InputMask = "999.99"
5277:             .Visible = .T.
5278:         ENDWITH
5279:         loc_oAba.AddObject("lbl_4c_F6VX", "Label")
5280:         WITH loc_oAba.lbl_4c_F6VX
5281:             .Caption = "x"
5282:             .Top = 134

*-- Linhas 5290 a 5322:
5290:         ENDWITH
5291:         loc_oAba.AddObject("txt_4c_Fat6ValC", "TextBox")
5292:         WITH loc_oAba.txt_4c_Fat6ValC
5293:             .ControlSource = "crSigCnFNf.cfat6val"
5294:             .Top = 132
5295:             .Left = 214
5296:             .Width = 41
5297:             .Height = 18
5298:             .FontName = "Tahoma"
5299:             .FontSize = 8
5300:             .SpecialEffect = 1
5301:             .Format = "K"
5302:             .InputMask = "999.99"
5303:             .Visible = .T.
5304:         ENDWITH
5305:         loc_oAba.AddObject("txt_4c_Fat6VecL", "TextBox")
5306:         WITH loc_oAba.txt_4c_Fat6VecL
5307:             .ControlSource = "crSigCnFNf.lfat6vec"
5308:             .Top = 132
5309:             .Left = 273
5310:             .Width = 41
5311:             .Height = 18
5312:             .FontName = "Tahoma"
5313:             .FontSize = 8
5314:             .SpecialEffect = 1
5315:             .Format = "K"
5316:             .InputMask = "999.99"
5317:             .Visible = .T.
5318:         ENDWITH
5319:         loc_oAba.AddObject("lbl_4c_F6EX", "Label")
5320:         WITH loc_oAba.lbl_4c_F6EX
5321:             .Caption = "x"
5322:             .Top = 134

*-- Linhas 5330 a 5348:
5330:         ENDWITH
5331:         loc_oAba.AddObject("txt_4c_Fat6VecC", "TextBox")
5332:         WITH loc_oAba.txt_4c_Fat6VecC
5333:             .ControlSource = "crSigCnFNf.cfat6vec"
5334:             .Top = 132
5335:             .Left = 322
5336:             .Width = 41
5337:             .Height = 18
5338:             .FontName = "Tahoma"
5339:             .FontSize = 8
5340:             .SpecialEffect = 1
5341:             .Format = "K"
5342:             .InputMask = "999.99"
5343:             .Visible = .T.
5344:         ENDWITH
5345: 
5346:         *-- Fatura 7 (top=151/153)
5347:         loc_oAba.AddObject("lbl_4c_Fat7", "Label")
5348:         WITH loc_oAba.lbl_4c_Fat7

*-- Linhas 5358 a 5376:
5358:         ENDWITH
5359:         loc_oAba.AddObject("txt_4c_Fat7NumL", "TextBox")
5360:         WITH loc_oAba.txt_4c_Fat7NumL
5361:             .ControlSource = "crSigCnFNf.lfat7num"
5362:             .Top = 151
5363:             .Left = 58
5364:             .Width = 41
5365:             .Height = 18
5366:             .FontName = "Tahoma"
5367:             .FontSize = 8
5368:             .SpecialEffect = 1
5369:             .Format = "K"
5370:             .InputMask = "999.99"
5371:             .Visible = .T.
5372:         ENDWITH
5373:         loc_oAba.AddObject("lbl_4c_F7NX", "Label")
5374:         WITH loc_oAba.lbl_4c_F7NX
5375:             .Caption = "x"
5376:             .Top = 153

*-- Linhas 5384 a 5416:
5384:         ENDWITH
5385:         loc_oAba.AddObject("txt_4c_Fat7NumC", "TextBox")
5386:         WITH loc_oAba.txt_4c_Fat7NumC
5387:             .ControlSource = "crSigCnFNf.cfat7num"
5388:             .Top = 151
5389:             .Left = 107
5390:             .Width = 41
5391:             .Height = 18
5392:             .FontName = "Tahoma"
5393:             .FontSize = 8
5394:             .SpecialEffect = 1
5395:             .Format = "K"
5396:             .InputMask = "999.99"
5397:             .Visible = .T.
5398:         ENDWITH
5399:         loc_oAba.AddObject("txt_4c_Fat7ValL", "TextBox")
5400:         WITH loc_oAba.txt_4c_Fat7ValL
5401:             .ControlSource = "crSigCnFNf.lfat7val"
5402:             .Top = 151
5403:             .Left = 165
5404:             .Width = 41
5405:             .Height = 18
5406:             .FontName = "Tahoma"
5407:             .FontSize = 8
5408:             .SpecialEffect = 1
5409:             .Format = "K"
5410:             .InputMask = "999.99"
5411:             .Visible = .T.
5412:         ENDWITH
5413:         loc_oAba.AddObject("lbl_4c_F7VX", "Label")
5414:         WITH loc_oAba.lbl_4c_F7VX
5415:             .Caption = "x"
5416:             .Top = 153

*-- Linhas 5424 a 5456:
5424:         ENDWITH
5425:         loc_oAba.AddObject("txt_4c_Fat7ValC", "TextBox")
5426:         WITH loc_oAba.txt_4c_Fat7ValC
5427:             .ControlSource = "crSigCnFNf.cfat7val"
5428:             .Top = 151
5429:             .Left = 214
5430:             .Width = 41
5431:             .Height = 18
5432:             .FontName = "Tahoma"
5433:             .FontSize = 8
5434:             .SpecialEffect = 1
5435:             .Format = "K"
5436:             .InputMask = "999.99"
5437:             .Visible = .T.
5438:         ENDWITH
5439:         loc_oAba.AddObject("txt_4c_Fat7VecL", "TextBox")
5440:         WITH loc_oAba.txt_4c_Fat7VecL
5441:             .ControlSource = "crSigCnFNf.lfat7vec"
5442:             .Top = 151
5443:             .Left = 273
5444:             .Width = 41
5445:             .Height = 18
5446:             .FontName = "Tahoma"
5447:             .FontSize = 8
5448:             .SpecialEffect = 1
5449:             .Format = "K"
5450:             .InputMask = "999.99"
5451:             .Visible = .T.
5452:         ENDWITH
5453:         loc_oAba.AddObject("lbl_4c_F7EX", "Label")
5454:         WITH loc_oAba.lbl_4c_F7EX
5455:             .Caption = "x"
5456:             .Top = 153

*-- Linhas 5464 a 5482:
5464:         ENDWITH
5465:         loc_oAba.AddObject("txt_4c_Fat7VecC", "TextBox")
5466:         WITH loc_oAba.txt_4c_Fat7VecC
5467:             .ControlSource = "crSigCnFNf.cfat7vec"
5468:             .Top = 151
5469:             .Left = 322
5470:             .Width = 41
5471:             .Height = 18
5472:             .FontName = "Tahoma"
5473:             .FontSize = 8
5474:             .SpecialEffect = 1
5475:             .Format = "K"
5476:             .InputMask = "999.99"
5477:             .Visible = .T.
5478:         ENDWITH
5479: 
5480:         *-- Fatura 8 (top=170/172)
5481:         loc_oAba.AddObject("lbl_4c_Fat8", "Label")
5482:         WITH loc_oAba.lbl_4c_Fat8

*-- Linhas 5492 a 5510:
5492:         ENDWITH
5493:         loc_oAba.AddObject("txt_4c_Fat8NumL", "TextBox")
5494:         WITH loc_oAba.txt_4c_Fat8NumL
5495:             .ControlSource = "crSigCnFNf.lfat8num"
5496:             .Top = 170
5497:             .Left = 58
5498:             .Width = 41
5499:             .Height = 18
5500:             .FontName = "Tahoma"
5501:             .FontSize = 8
5502:             .SpecialEffect = 1
5503:             .Format = "K"
5504:             .InputMask = "999.99"
5505:             .Visible = .T.
5506:         ENDWITH
5507:         loc_oAba.AddObject("lbl_4c_F8NX", "Label")
5508:         WITH loc_oAba.lbl_4c_F8NX
5509:             .Caption = "x"
5510:             .Top = 172

*-- Linhas 5518 a 5550:
5518:         ENDWITH
5519:         loc_oAba.AddObject("txt_4c_Fat8NumC", "TextBox")
5520:         WITH loc_oAba.txt_4c_Fat8NumC
5521:             .ControlSource = "crSigCnFNf.cfat8num"
5522:             .Top = 170
5523:             .Left = 107
5524:             .Width = 41
5525:             .Height = 18
5526:             .FontName = "Tahoma"
5527:             .FontSize = 8
5528:             .SpecialEffect = 1
5529:             .Format = "K"
5530:             .InputMask = "999.99"
5531:             .Visible = .T.
5532:         ENDWITH
5533:         loc_oAba.AddObject("txt_4c_Fat8ValL", "TextBox")
5534:         WITH loc_oAba.txt_4c_Fat8ValL
5535:             .ControlSource = "crSigCnFNf.lfat8val"
5536:             .Top = 170
5537:             .Left = 165
5538:             .Width = 41
5539:             .Height = 18
5540:             .FontName = "Tahoma"
5541:             .FontSize = 8
5542:             .SpecialEffect = 1
5543:             .Format = "K"
5544:             .InputMask = "999.99"
5545:             .Visible = .T.
5546:         ENDWITH
5547:         loc_oAba.AddObject("lbl_4c_F8VX", "Label")
5548:         WITH loc_oAba.lbl_4c_F8VX
5549:             .Caption = "x"
5550:             .Top = 172

*-- Linhas 5558 a 5590:
5558:         ENDWITH
5559:         loc_oAba.AddObject("txt_4c_Fat8ValC", "TextBox")
5560:         WITH loc_oAba.txt_4c_Fat8ValC
5561:             .ControlSource = "crSigCnFNf.cfat8val"
5562:             .Top = 170
5563:             .Left = 214
5564:             .Width = 41
5565:             .Height = 18
5566:             .FontName = "Tahoma"
5567:             .FontSize = 8
5568:             .SpecialEffect = 1
5569:             .Format = "K"
5570:             .InputMask = "999.99"
5571:             .Visible = .T.
5572:         ENDWITH
5573:         loc_oAba.AddObject("txt_4c_Fat8VecL", "TextBox")
5574:         WITH loc_oAba.txt_4c_Fat8VecL
5575:             .ControlSource = "crSigCnFNf.lfat8vec"
5576:             .Top = 170
5577:             .Left = 273
5578:             .Width = 41
5579:             .Height = 18
5580:             .FontName = "Tahoma"
5581:             .FontSize = 8
5582:             .SpecialEffect = 1
5583:             .Format = "K"
5584:             .InputMask = "999.99"
5585:             .Visible = .T.
5586:         ENDWITH
5587:         loc_oAba.AddObject("lbl_4c_F8EX", "Label")
5588:         WITH loc_oAba.lbl_4c_F8EX
5589:             .Caption = "x"
5590:             .Top = 172

*-- Linhas 5598 a 5616:
5598:         ENDWITH
5599:         loc_oAba.AddObject("txt_4c_Fat8VecC", "TextBox")
5600:         WITH loc_oAba.txt_4c_Fat8VecC
5601:             .ControlSource = "crSigCnFNf.cfat8vec"
5602:             .Top = 170
5603:             .Left = 322
5604:             .Width = 41
5605:             .Height = 18
5606:             .FontName = "Tahoma"
5607:             .FontSize = 8
5608:             .SpecialEffect = 1
5609:             .Format = "K"
5610:             .InputMask = "999.99"
5611:             .Visible = .T.
5612:         ENDWITH
5613: 
5614:         *-- Fatura 9 (top=189/191)
5615:         loc_oAba.AddObject("lbl_4c_Fat9", "Label")
5616:         WITH loc_oAba.lbl_4c_Fat9

*-- Linhas 5626 a 5644:
5626:         ENDWITH
5627:         loc_oAba.AddObject("txt_4c_Fat9NumL", "TextBox")
5628:         WITH loc_oAba.txt_4c_Fat9NumL
5629:             .ControlSource = "crSigCnFNf.lfat9num"
5630:             .Top = 189
5631:             .Left = 58
5632:             .Width = 41
5633:             .Height = 18
5634:             .FontName = "Tahoma"
5635:             .FontSize = 8
5636:             .SpecialEffect = 1
5637:             .Format = "K"
5638:             .InputMask = "999.99"
5639:             .Visible = .T.
5640:         ENDWITH
5641:         loc_oAba.AddObject("lbl_4c_F9NX", "Label")
5642:         WITH loc_oAba.lbl_4c_F9NX
5643:             .Caption = "x"
5644:             .Top = 191

*-- Linhas 5652 a 5684:
5652:         ENDWITH
5653:         loc_oAba.AddObject("txt_4c_Fat9NumC", "TextBox")
5654:         WITH loc_oAba.txt_4c_Fat9NumC
5655:             .ControlSource = "crSigCnFNf.cfat9num"
5656:             .Top = 189
5657:             .Left = 107
5658:             .Width = 41
5659:             .Height = 18
5660:             .FontName = "Tahoma"
5661:             .FontSize = 8
5662:             .SpecialEffect = 1
5663:             .Format = "K"
5664:             .InputMask = "999.99"
5665:             .Visible = .T.
5666:         ENDWITH
5667:         loc_oAba.AddObject("txt_4c_Fat9ValL", "TextBox")
5668:         WITH loc_oAba.txt_4c_Fat9ValL
5669:             .ControlSource = "crSigCnFNf.lfat9val"
5670:             .Top = 189
5671:             .Left = 165
5672:             .Width = 41
5673:             .Height = 18
5674:             .FontName = "Tahoma"
5675:             .FontSize = 8
5676:             .SpecialEffect = 1
5677:             .Format = "K"
5678:             .InputMask = "999.99"
5679:             .Visible = .T.
5680:         ENDWITH
5681:         loc_oAba.AddObject("lbl_4c_F9VX", "Label")
5682:         WITH loc_oAba.lbl_4c_F9VX
5683:             .Caption = "x"
5684:             .Top = 191

*-- Linhas 5692 a 5724:
5692:         ENDWITH
5693:         loc_oAba.AddObject("txt_4c_Fat9ValC", "TextBox")
5694:         WITH loc_oAba.txt_4c_Fat9ValC
5695:             .ControlSource = "crSigCnFNf.cfat9val"
5696:             .Top = 189
5697:             .Left = 214
5698:             .Width = 41
5699:             .Height = 18
5700:             .FontName = "Tahoma"
5701:             .FontSize = 8
5702:             .SpecialEffect = 1
5703:             .Format = "K"
5704:             .InputMask = "999.99"
5705:             .Visible = .T.
5706:         ENDWITH
5707:         loc_oAba.AddObject("txt_4c_Fat9VecL", "TextBox")
5708:         WITH loc_oAba.txt_4c_Fat9VecL
5709:             .ControlSource = "crSigCnFNf.lfat9vec"
5710:             .Top = 189
5711:             .Left = 273
5712:             .Width = 41
5713:             .Height = 18
5714:             .FontName = "Tahoma"
5715:             .FontSize = 8
5716:             .SpecialEffect = 1
5717:             .Format = "K"
5718:             .InputMask = "999.99"
5719:             .Visible = .T.
5720:         ENDWITH
5721:         loc_oAba.AddObject("lbl_4c_F9EX", "Label")
5722:         WITH loc_oAba.lbl_4c_F9EX
5723:             .Caption = "x"
5724:             .Top = 191

*-- Linhas 5732 a 5750:
5732:         ENDWITH
5733:         loc_oAba.AddObject("txt_4c_Fat9VecC", "TextBox")
5734:         WITH loc_oAba.txt_4c_Fat9VecC
5735:             .ControlSource = "crSigCnFNf.cfat9vec"
5736:             .Top = 189
5737:             .Left = 322
5738:             .Width = 41
5739:             .Height = 18
5740:             .FontName = "Tahoma"
5741:             .FontSize = 8
5742:             .SpecialEffect = 1
5743:             .Format = "K"
5744:             .InputMask = "999.99"
5745:             .Visible = .T.
5746:         ENDWITH
5747: 
5748:         *-- Fatura 10 (top=208/210)
5749:         loc_oAba.AddObject("lbl_4c_Fat10", "Label")
5750:         WITH loc_oAba.lbl_4c_Fat10

*-- Linhas 5760 a 5778:
5760:         ENDWITH
5761:         loc_oAba.AddObject("txt_4c_Fat10NumL", "TextBox")
5762:         WITH loc_oAba.txt_4c_Fat10NumL
5763:             .ControlSource = "crSigCnFNf.lfat10num"
5764:             .Top = 208
5765:             .Left = 58
5766:             .Width = 41
5767:             .Height = 18
5768:             .FontName = "Tahoma"
5769:             .FontSize = 8
5770:             .SpecialEffect = 1
5771:             .Format = "K"
5772:             .InputMask = "999.99"
5773:             .Visible = .T.
5774:         ENDWITH
5775:         loc_oAba.AddObject("lbl_4c_F10NX", "Label")
5776:         WITH loc_oAba.lbl_4c_F10NX
5777:             .Caption = "x"
5778:             .Top = 210

*-- Linhas 5786 a 5818:
5786:         ENDWITH
5787:         loc_oAba.AddObject("txt_4c_Fat10NumC", "TextBox")
5788:         WITH loc_oAba.txt_4c_Fat10NumC
5789:             .ControlSource = "crSigCnFNf.cfat10num"
5790:             .Top = 208
5791:             .Left = 107
5792:             .Width = 41
5793:             .Height = 18
5794:             .FontName = "Tahoma"
5795:             .FontSize = 8
5796:             .SpecialEffect = 1
5797:             .Format = "K"
5798:             .InputMask = "999.99"
5799:             .Visible = .T.
5800:         ENDWITH
5801:         loc_oAba.AddObject("txt_4c_Fat10ValL", "TextBox")
5802:         WITH loc_oAba.txt_4c_Fat10ValL
5803:             .ControlSource = "crSigCnFNf.lfat10val"
5804:             .Top = 208
5805:             .Left = 165
5806:             .Width = 41
5807:             .Height = 18
5808:             .FontName = "Tahoma"
5809:             .FontSize = 8
5810:             .SpecialEffect = 1
5811:             .Format = "K"
5812:             .InputMask = "999.99"
5813:             .Visible = .T.
5814:         ENDWITH
5815:         loc_oAba.AddObject("lbl_4c_F10VX", "Label")
5816:         WITH loc_oAba.lbl_4c_F10VX
5817:             .Caption = "x"
5818:             .Top = 210

*-- Linhas 5826 a 5858:
5826:         ENDWITH
5827:         loc_oAba.AddObject("txt_4c_Fat10ValC", "TextBox")
5828:         WITH loc_oAba.txt_4c_Fat10ValC
5829:             .ControlSource = "crSigCnFNf.cfat10val"
5830:             .Top = 208
5831:             .Left = 214
5832:             .Width = 41
5833:             .Height = 18
5834:             .FontName = "Tahoma"
5835:             .FontSize = 8
5836:             .SpecialEffect = 1
5837:             .Format = "K"
5838:             .InputMask = "999.99"
5839:             .Visible = .T.
5840:         ENDWITH
5841:         loc_oAba.AddObject("txt_4c_Fat10VecL", "TextBox")
5842:         WITH loc_oAba.txt_4c_Fat10VecL
5843:             .ControlSource = "crSigCnFNf.lfat10vec"
5844:             .Top = 208
5845:             .Left = 273
5846:             .Width = 41
5847:             .Height = 18
5848:             .FontName = "Tahoma"
5849:             .FontSize = 8
5850:             .SpecialEffect = 1
5851:             .Format = "K"
5852:             .InputMask = "999.99"
5853:             .Visible = .T.
5854:         ENDWITH
5855:         loc_oAba.AddObject("lbl_4c_F10EX", "Label")
5856:         WITH loc_oAba.lbl_4c_F10EX
5857:             .Caption = "x"
5858:             .Top = 210

*-- Linhas 5866 a 5884:
5866:         ENDWITH
5867:         loc_oAba.AddObject("txt_4c_Fat10VecC", "TextBox")
5868:         WITH loc_oAba.txt_4c_Fat10VecC
5869:             .ControlSource = "crSigCnFNf.cfat10vec"
5870:             .Top = 208
5871:             .Left = 322
5872:             .Width = 41
5873:             .Height = 18
5874:             .FontName = "Tahoma"
5875:             .FontSize = 8
5876:             .SpecialEffect = 1
5877:             .Format = "K"
5878:             .InputMask = "999.99"
5879:             .Visible = .T.
5880:         ENDWITH
5881: 
5882:         *-- Endereco de Cobranca (right side, top=25 label at left=395)
5883:         loc_oAba.AddObject("lbl_4c_LblEndCob", "Label")
5884:         WITH loc_oAba.lbl_4c_LblEndCob

*-- Linhas 5895 a 5913:
5895: 
5896:         loc_oAba.AddObject("txt_4c_CobEnderL", "TextBox")
5897:         WITH loc_oAba.txt_4c_CobEnderL
5898:             .ControlSource = "crSigCnFNf.lendcob"
5899:             .Top = 37
5900:             .Left = 395
5901:             .Width = 41
5902:             .Height = 18
5903:             .FontName = "Tahoma"
5904:             .FontSize = 8
5905:             .SpecialEffect = 1
5906:             .Format = "K"
5907:             .InputMask = "999.99"
5908:             .Visible = .T.
5909:         ENDWITH
5910: 
5911:         loc_oAba.AddObject("lbl_4c_CobEX1", "Label")
5912:         WITH loc_oAba.lbl_4c_CobEX1
5913:             .Caption = "x"

*-- Linhas 5923 a 5941:
5923: 
5924:         loc_oAba.AddObject("txt_4c_CobEnderC", "TextBox")
5925:         WITH loc_oAba.txt_4c_CobEnderC
5926:             .ControlSource = "crSigCnFNf.cendcob"
5927:             .Top = 37
5928:             .Left = 444
5929:             .Width = 41
5930:             .Height = 18
5931:             .FontName = "Tahoma"
5932:             .FontSize = 8
5933:             .SpecialEffect = 1
5934:             .Format = "K"
5935:             .InputMask = "999.99"
5936:             .Visible = .T.
5937:         ENDWITH
5938: 
5939:         *-- Cobranca - Bairro (top=25, left=495)
5940:         loc_oAba.AddObject("lbl_4c_LblCobBai", "Label")
5941:         WITH loc_oAba.lbl_4c_LblCobBai

*-- Linhas 5952 a 5970:
5952: 
5953:         loc_oAba.AddObject("txt_4c_CobBairL", "TextBox")
5954:         WITH loc_oAba.txt_4c_CobBairL
5955:             .ControlSource = "crSigCnFNf.lbaicob"
5956:             .Top = 37
5957:             .Left = 495
5958:             .Width = 41
5959:             .Height = 18
5960:             .FontName = "Tahoma"
5961:             .FontSize = 8
5962:             .SpecialEffect = 1
5963:             .Format = "K"
5964:             .InputMask = "999.99"
5965:             .Visible = .T.
5966:         ENDWITH
5967: 
5968:         loc_oAba.AddObject("lbl_4c_CobBX", "Label")
5969:         WITH loc_oAba.lbl_4c_CobBX
5970:             .Caption = "x"

*-- Linhas 5980 a 5998:
5980: 
5981:         loc_oAba.AddObject("txt_4c_CobBairC", "TextBox")
5982:         WITH loc_oAba.txt_4c_CobBairC
5983:             .ControlSource = "crSigCnFNf.cbaicob"
5984:             .Top = 37
5985:             .Left = 544
5986:             .Width = 41
5987:             .Height = 18
5988:             .FontName = "Tahoma"
5989:             .FontSize = 8
5990:             .SpecialEffect = 1
5991:             .Format = "K"
5992:             .InputMask = "999.99"
5993:             .Visible = .T.
5994:         ENDWITH
5995: 
5996:         *-- Cobranca - Municipio (top=61, left=394)
5997:         loc_oAba.AddObject("lbl_4c_LblCobMun", "Label")
5998:         WITH loc_oAba.lbl_4c_LblCobMun

*-- Linhas 6009 a 6027:
6009: 
6010:         loc_oAba.AddObject("txt_4c_CobMuniL", "TextBox")
6011:         WITH loc_oAba.txt_4c_CobMuniL
6012:             .ControlSource = "crSigCnFNf.lmuncob"
6013:             .Top = 73
6014:             .Left = 394
6015:             .Width = 41
6016:             .Height = 18
6017:             .FontName = "Tahoma"
6018:             .FontSize = 8
6019:             .SpecialEffect = 1
6020:             .Format = "K"
6021:             .InputMask = "999.99"
6022:             .Visible = .T.
6023:         ENDWITH
6024: 
6025:         loc_oAba.AddObject("lbl_4c_CobMX", "Label")
6026:         WITH loc_oAba.lbl_4c_CobMX
6027:             .Caption = "x"

*-- Linhas 6037 a 6055:
6037: 
6038:         loc_oAba.AddObject("txt_4c_CobMuniC", "TextBox")
6039:         WITH loc_oAba.txt_4c_CobMuniC
6040:             .ControlSource = "crSigCnFNf.cmuncob"
6041:             .Top = 73
6042:             .Left = 443
6043:             .Width = 41
6044:             .Height = 18
6045:             .FontName = "Tahoma"
6046:             .FontSize = 8
6047:             .SpecialEffect = 1
6048:             .Format = "K"
6049:             .InputMask = "999.99"
6050:             .Visible = .T.
6051:         ENDWITH
6052: 
6053:         *-- Cobranca - Estado (top=61, left=495)
6054:         loc_oAba.AddObject("lbl_4c_LblCobEst", "Label")
6055:         WITH loc_oAba.lbl_4c_LblCobEst

*-- Linhas 6066 a 6084:
6066: 
6067:         loc_oAba.AddObject("txt_4c_CobEstL", "TextBox")
6068:         WITH loc_oAba.txt_4c_CobEstL
6069:             .ControlSource = "crSigCnFNf.lestcob"
6070:             .Top = 73
6071:             .Left = 495
6072:             .Width = 41
6073:             .Height = 18
6074:             .FontName = "Tahoma"
6075:             .FontSize = 8
6076:             .SpecialEffect = 1
6077:             .Format = "K"
6078:             .InputMask = "999.99"
6079:             .Visible = .T.
6080:         ENDWITH
6081: 
6082:         loc_oAba.AddObject("lbl_4c_CobEstX", "Label")
6083:         WITH loc_oAba.lbl_4c_CobEstX
6084:             .Caption = "x"

*-- Linhas 6094 a 6112:
6094: 
6095:         loc_oAba.AddObject("txt_4c_CobEstC", "TextBox")
6096:         WITH loc_oAba.txt_4c_CobEstC
6097:             .ControlSource = "crSigCnFNf.cestcob"
6098:             .Top = 73
6099:             .Left = 544
6100:             .Width = 41
6101:             .Height = 18
6102:             .FontName = "Tahoma"
6103:             .FontSize = 8
6104:             .SpecialEffect = 1
6105:             .Format = "K"
6106:             .InputMask = "999.99"
6107:             .Visible = .T.
6108:         ENDWITH
6109: 
6110:         *-- Cobranca - CEP (top=97, left=394)
6111:         loc_oAba.AddObject("lbl_4c_LblCobCep", "Label")
6112:         WITH loc_oAba.lbl_4c_LblCobCep

*-- Linhas 6123 a 6141:
6123: 
6124:         loc_oAba.AddObject("txt_4c_CobCepL", "TextBox")
6125:         WITH loc_oAba.txt_4c_CobCepL
6126:             .ControlSource = "crSigCnFNf.lcepcob"
6127:             .Top = 109
6128:             .Left = 394
6129:             .Width = 41
6130:             .Height = 18
6131:             .FontName = "Tahoma"
6132:             .FontSize = 8
6133:             .SpecialEffect = 1
6134:             .Format = "K"
6135:             .InputMask = "999.99"
6136:             .Visible = .T.
6137:         ENDWITH
6138: 
6139:         loc_oAba.AddObject("lbl_4c_CobCepX", "Label")
6140:         WITH loc_oAba.lbl_4c_CobCepX
6141:             .Caption = "x"

*-- Linhas 6151 a 6169:
6151: 
6152:         loc_oAba.AddObject("txt_4c_CobCepC", "TextBox")
6153:         WITH loc_oAba.txt_4c_CobCepC
6154:             .ControlSource = "crSigCnFNf.ccepcob"
6155:             .Top = 109
6156:             .Left = 443
6157:             .Width = 41
6158:             .Height = 18
6159:             .FontName = "Tahoma"
6160:             .FontSize = 8
6161:             .SpecialEffect = 1
6162:             .Format = "K"
6163:             .InputMask = "999.99"
6164:             .Visible = .T.
6165:         ENDWITH
6166:     ENDPROC
6167: 
6168:     *--------------------------------------------------------------------------
6169:     PROTECTED PROCEDURE ConfigurarProdutosTab()

*-- Linhas 6186 a 6204:
6186: 
6187:         loc_oAba.AddObject("txt_4c_LinIni", "TextBox")
6188:         WITH loc_oAba.txt_4c_LinIni
6189:             .ControlSource = "crSigCnFNf.linprod"
6190:             .Top           = 24
6191:             .Left          = 153
6192:             .Width         = 41
6193:             .Height        = 18
6194:             .FontName      = "Tahoma"
6195:             .FontSize      = 8
6196:             .SpecialEffect = 1
6197:             .Format        = "K"
6198:             .InputMask     = "999.99"
6199:             .Visible       = .T.
6200:         ENDWITH
6201: 
6202:         *-- Codigo (top=50)
6203:         loc_oAba.AddObject("lbl_4c_LblCodigo", "Label")
6204:         WITH loc_oAba.lbl_4c_LblCodigo

*-- Linhas 6215 a 6233:
6215: 
6216:         loc_oAba.AddObject("txt_4c_ProdCodL", "TextBox")
6217:         WITH loc_oAba.txt_4c_ProdCodL
6218:             .ControlSource = "crSigCnFNf.lcodpro"
6219:             .Top           = 62
6220:             .Left          = 32
6221:             .Width         = 38
6222:             .Height        = 18
6223:             .FontName      = "Tahoma"
6224:             .FontSize      = 8
6225:             .SpecialEffect = 1
6226:             .Format        = "K"
6227:             .InputMask     = "999.99"
6228:             .Visible       = .T.
6229:         ENDWITH
6230: 
6231:         *-- Descricao (top=50)
6232:         loc_oAba.AddObject("lbl_4c_LblDescr", "Label")
6233:         WITH loc_oAba.lbl_4c_LblDescr

*-- Linhas 6244 a 6262:
6244: 
6245:         loc_oAba.AddObject("txt_4c_ProdDescL", "TextBox")
6246:         WITH loc_oAba.txt_4c_ProdDescL
6247:             .ControlSource = "crSigCnFNf.ldescpro"
6248:             .Top           = 62
6249:             .Left          = 75
6250:             .Width         = 38
6251:             .Height        = 18
6252:             .FontName      = "Tahoma"
6253:             .FontSize      = 8
6254:             .SpecialEffect = 1
6255:             .Format        = "K"
6256:             .InputMask     = "999.99"
6257:             .Visible       = .T.
6258:         ENDWITH
6259: 
6260:         *-- Peso (top=50)
6261:         loc_oAba.AddObject("lbl_4c_LblPeso", "Label")
6262:         WITH loc_oAba.lbl_4c_LblPeso

*-- Linhas 6273 a 6291:
6273: 
6274:         loc_oAba.AddObject("txt_4c_ProdPesoL", "TextBox")
6275:         WITH loc_oAba.txt_4c_ProdPesoL
6276:             .ControlSource = "crSigCnFNf.cpespro"
6277:             .Top           = 62
6278:             .Left          = 118
6279:             .Width         = 38
6280:             .Height        = 18
6281:             .FontName      = "Tahoma"
6282:             .FontSize      = 8
6283:             .SpecialEffect = 1
6284:             .Format        = "K"
6285:             .InputMask     = "999.99"
6286:             .Visible       = .T.
6287:         ENDWITH
6288: 
6289:         *-- Tipo (top=50)
6290:         loc_oAba.AddObject("lbl_4c_LblTipo", "Label")
6291:         WITH loc_oAba.lbl_4c_LblTipo

*-- Linhas 6302 a 6320:
6302: 
6303:         loc_oAba.AddObject("txt_4c_ProdTipoL", "TextBox")
6304:         WITH loc_oAba.txt_4c_ProdTipoL
6305:             .ControlSource = "crSigCnFNf.ltprod"
6306:             .Top           = 62
6307:             .Left          = 161
6308:             .Width         = 38
6309:             .Height        = 18
6310:             .FontName      = "Tahoma"
6311:             .FontSize      = 8
6312:             .SpecialEffect = 1
6313:             .Format        = "K"
6314:             .InputMask     = "999.99"
6315:             .Visible       = .T.
6316:         ENDWITH
6317: 
6318:         *-- Metal (top=50)
6319:         loc_oAba.AddObject("lbl_4c_LblMetal", "Label")
6320:         WITH loc_oAba.lbl_4c_LblMetal

*-- Linhas 6331 a 6349:
6331: 
6332:         loc_oAba.AddObject("txt_4c_ProdMetalL", "TextBox")
6333:         WITH loc_oAba.txt_4c_ProdMetalL
6334:             .ControlSource = "crSigCnFNf.cmarca"
6335:             .Top           = 62
6336:             .Left          = 204
6337:             .Width         = 38
6338:             .Height        = 18
6339:             .FontName      = "Tahoma"
6340:             .FontSize      = 8
6341:             .SpecialEffect = 1
6342:             .Format        = "K"
6343:             .InputMask     = "999.99"
6344:             .Visible       = .T.
6345:         ENDWITH
6346: 
6347:         *-- Teor (top=50)
6348:         loc_oAba.AddObject("lbl_4c_LblTeor", "Label")
6349:         WITH loc_oAba.lbl_4c_LblTeor

*-- Linhas 6360 a 6378:
6360: 
6361:         loc_oAba.AddObject("txt_4c_ProdTeorL", "TextBox")
6362:         WITH loc_oAba.txt_4c_ProdTeorL
6363:             .ControlSource = "crSigCnFNf.cticm"
6364:             .Top           = 62
6365:             .Left          = 247
6366:             .Width         = 41
6367:             .Height        = 18
6368:             .FontName      = "Tahoma"
6369:             .FontSize      = 8
6370:             .SpecialEffect = 1
6371:             .Format        = "K"
6372:             .InputMask     = "999.99"
6373:             .Visible       = .T.
6374:         ENDWITH
6375: 
6376:         *-- Cl.Fiscal (top=50)
6377:         loc_oAba.AddObject("lbl_4c_LblClFis", "Label")
6378:         WITH loc_oAba.lbl_4c_LblClFis

*-- Linhas 6389 a 6407:
6389: 
6390:         loc_oAba.AddObject("txt_4c_ProdClFisL", "TextBox")
6391:         WITH loc_oAba.txt_4c_ProdClFisL
6392:             .ControlSource = "crSigCnFNf.lcclas1"
6393:             .Top           = 62
6394:             .Left          = 293
6395:             .Width         = 38
6396:             .Height        = 18
6397:             .FontName      = "Tahoma"
6398:             .FontSize      = 8
6399:             .SpecialEffect = 1
6400:             .Format        = "K"
6401:             .InputMask     = "999.99"
6402:             .Visible       = .T.
6403:         ENDWITH
6404: 
6405:         *-- Sit.Trib (top=50)
6406:         loc_oAba.AddObject("lbl_4c_LblSitTrib", "Label")
6407:         WITH loc_oAba.lbl_4c_LblSitTrib

*-- Linhas 6418 a 6436:
6418: 
6419:         loc_oAba.AddObject("txt_4c_ProdSitTribL", "TextBox")
6420:         WITH loc_oAba.txt_4c_ProdSitTribL
6421:             .ControlSource = "crSigCnFNf.lstrib"
6422:             .Top           = 62
6423:             .Left          = 336
6424:             .Width         = 38
6425:             .Height        = 18
6426:             .FontName      = "Tahoma"
6427:             .FontSize      = 8
6428:             .SpecialEffect = 1
6429:             .Format        = "K"
6430:             .InputMask     = "999.99"
6431:             .Visible       = .T.
6432:         ENDWITH
6433: 
6434:         *-- Origem (top=50)
6435:         loc_oAba.AddObject("lbl_4c_LblOrigem", "Label")
6436:         WITH loc_oAba.lbl_4c_LblOrigem

*-- Linhas 6447 a 6465:
6447: 
6448:         loc_oAba.AddObject("txt_4c_ProdOrigemL", "TextBox")
6449:         WITH loc_oAba.txt_4c_ProdOrigemL
6450:             .ControlSource = "crSigCnFNf.corigem"
6451:             .Top           = 62
6452:             .Left          = 379
6453:             .Width         = 38
6454:             .Height        = 18
6455:             .FontName      = "Tahoma"
6456:             .FontSize      = 8
6457:             .SpecialEffect = 1
6458:             .Format        = "K"
6459:             .InputMask     = "999.99"
6460:             .Visible       = .T.
6461:         ENDWITH
6462: 
6463:         *-- Unidade (top=50)
6464:         loc_oAba.AddObject("lbl_4c_LblUnid", "Label")
6465:         WITH loc_oAba.lbl_4c_LblUnid

*-- Linhas 6476 a 6494:
6476: 
6477:         loc_oAba.AddObject("txt_4c_ProdUnidL", "TextBox")
6478:         WITH loc_oAba.txt_4c_ProdUnidL
6479:             .ControlSource = "crSigCnFNf.lunid"
6480:             .Top           = 62
6481:             .Left          = 422
6482:             .Width         = 38
6483:             .Height        = 18
6484:             .FontName      = "Tahoma"
6485:             .FontSize      = 8
6486:             .SpecialEffect = 1
6487:             .Format        = "K"
6488:             .InputMask     = "999.99"
6489:             .Visible       = .T.
6490:         ENDWITH
6491: 
6492:         *-- Quant (top=50)
6493:         loc_oAba.AddObject("lbl_4c_LblQtde", "Label")
6494:         WITH loc_oAba.lbl_4c_LblQtde

*-- Linhas 6505 a 6523:
6505: 
6506:         loc_oAba.AddObject("txt_4c_ProdQtdeL", "TextBox")
6507:         WITH loc_oAba.txt_4c_ProdQtdeL
6508:             .ControlSource = "crSigCnFNf.lqtde"
6509:             .Top           = 62
6510:             .Left          = 466
6511:             .Width         = 38
6512:             .Height        = 18
6513:             .FontName      = "Tahoma"
6514:             .FontSize      = 8
6515:             .SpecialEffect = 1
6516:             .Format        = "K"
6517:             .InputMask     = "999.99"
6518:             .Visible       = .T.
6519:         ENDWITH
6520: 
6521:         *-- Vlr Unit (top=85)
6522:         loc_oAba.AddObject("lbl_4c_LblVlUnit", "Label")
6523:         WITH loc_oAba.lbl_4c_LblVlUnit

*-- Linhas 6534 a 6552:
6534: 
6535:         loc_oAba.AddObject("txt_4c_ProdVlUnitL", "TextBox")
6536:         WITH loc_oAba.txt_4c_ProdVlUnitL
6537:             .ControlSource = "crSigCnFNf.lvluni"
6538:             .Top           = 97
6539:             .Left          = 32
6540:             .Width         = 38
6541:             .Height        = 18
6542:             .FontName      = "Tahoma"
6543:             .FontSize      = 8
6544:             .SpecialEffect = 1
6545:             .Format        = "K"
6546:             .InputMask     = "999.99"
6547:             .Visible       = .T.
6548:         ENDWITH
6549: 
6550:         *-- Vlr Total (top=85)
6551:         loc_oAba.AddObject("lbl_4c_LblVlTot", "Label")
6552:         WITH loc_oAba.lbl_4c_LblVlTot

*-- Linhas 6563 a 6581:
6563: 
6564:         loc_oAba.AddObject("txt_4c_ProdVlTotL", "TextBox")
6565:         WITH loc_oAba.txt_4c_ProdVlTotL
6566:             .ControlSource = "crSigCnFNf.lvltot"
6567:             .Top           = 97
6568:             .Left          = 75
6569:             .Width         = 38
6570:             .Height        = 18
6571:             .FontName      = "Tahoma"
6572:             .FontSize      = 8
6573:             .SpecialEffect = 1
6574:             .Format        = "K"
6575:             .InputMask     = "999.99"
6576:             .Visible       = .T.
6577:         ENDWITH
6578: 
6579:         *-- Al ICMS (top=85)
6580:         loc_oAba.AddObject("lbl_4c_LblAlICMS", "Label")
6581:         WITH loc_oAba.lbl_4c_LblAlICMS

*-- Linhas 6592 a 6610:
6592: 
6593:         loc_oAba.AddObject("txt_4c_ProdAlICMSL", "TextBox")
6594:         WITH loc_oAba.txt_4c_ProdAlICMSL
6595:             .ControlSource = "crSigCnFNf.lbicm"
6596:             .Top           = 97
6597:             .Left          = 118
6598:             .Width         = 38
6599:             .Height        = 18
6600:             .FontName      = "Tahoma"
6601:             .FontSize      = 8
6602:             .SpecialEffect = 1
6603:             .Format        = "K"
6604:             .InputMask     = "999.99"
6605:             .Visible       = .T.
6606:         ENDWITH
6607: 
6608:         *-- Al IPI (top=85)
6609:         loc_oAba.AddObject("lbl_4c_LblAlIPI", "Label")
6610:         WITH loc_oAba.lbl_4c_LblAlIPI

*-- Linhas 6621 a 6639:
6621: 
6622:         loc_oAba.AddObject("txt_4c_ProdAlIPIL", "TextBox")
6623:         WITH loc_oAba.txt_4c_ProdAlIPIL
6624:             .ControlSource = "crSigCnFNf.ltipi"
6625:             .Top           = 97
6626:             .Left          = 161
6627:             .Width         = 38
6628:             .Height        = 18
6629:             .FontName      = "Tahoma"
6630:             .FontSize      = 8
6631:             .SpecialEffect = 1
6632:             .Format        = "K"
6633:             .InputMask     = "999.99"
6634:             .Visible       = .T.
6635:         ENDWITH
6636: 
6637:         *-- Valor IPI (top=85)
6638:         loc_oAba.AddObject("lbl_4c_LblValIPI", "Label")
6639:         WITH loc_oAba.lbl_4c_LblValIPI

*-- Linhas 6650 a 6668:
6650: 
6651:         loc_oAba.AddObject("txt_4c_ProdValIPIL", "TextBox")
6652:         WITH loc_oAba.txt_4c_ProdValIPIL
6653:             .ControlSource = "crSigCnFNf.cvipi"
6654:             .Top           = 97
6655:             .Left          = 203
6656:             .Width         = 41
6657:             .Height        = 18
6658:             .FontName      = "Tahoma"
6659:             .FontSize      = 8
6660:             .SpecialEffect = 1
6661:             .Format        = "K"
6662:             .InputMask     = "999.99"
6663:             .Visible       = .T.
6664:         ENDWITH
6665: 
6666:         *-- CFOP (top=85)
6667:         loc_oAba.AddObject("lbl_4c_LblCFOP", "Label")
6668:         WITH loc_oAba.lbl_4c_LblCFOP

*-- Linhas 6679 a 6697:
6679: 
6680:         loc_oAba.AddObject("txt_4c_ProdCFOPL", "TextBox")
6681:         WITH loc_oAba.txt_4c_ProdCFOPL
6682:             .ControlSource = "crSigCnFNf.lcfop"
6683:             .Top           = 97
6684:             .Left          = 248
6685:             .Width         = 41
6686:             .Height        = 18
6687:             .FontName      = "Tahoma"
6688:             .FontSize      = 8
6689:             .SpecialEffect = 1
6690:             .Format        = "K"
6691:             .InputMask     = "999.99"
6692:             .Visible       = .T.
6693:         ENDWITH
6694: 
6695:         *-- Peso Metal (top=85)
6696:         loc_oAba.AddObject("lbl_4c_LblPesoMet", "Label")
6697:         WITH loc_oAba.lbl_4c_LblPesoMet

*-- Linhas 6708 a 6726:
6708: 
6709:         loc_oAba.AddObject("txt_4c_ProdPesoMetL", "TextBox")
6710:         WITH loc_oAba.txt_4c_ProdPesoMetL
6711:             .ControlSource = "crSigCnFNf.cpbru"
6712:             .Top           = 97
6713:             .Left          = 293
6714:             .Width         = 41
6715:             .Height        = 18
6716:             .FontName      = "Tahoma"
6717:             .FontSize      = 8
6718:             .SpecialEffect = 1
6719:             .Format        = "K"
6720:             .InputMask     = "999.99"
6721:             .Visible       = .T.
6722:         ENDWITH
6723: 
6724:         *-- Config. Descricao Produto (shape + labels, top=125-248)
6725:         loc_oAba.AddObject("shp_4c_Shape1", "Shape")
6726:         WITH loc_oAba.shp_4c_Shape1

*-- Linhas 6770 a 6788:
6770: 
6771:         loc_oAba.AddObject("txt_4c_QtMaxCarL", "TextBox")
6772:         WITH loc_oAba.txt_4c_QtMaxCarL
6773:             .ControlSource = "crSigCnFNf.tamdesc"
6774:             .Top           = 138
6775:             .Left          = 143
6776:             .Width         = 27
6777:             .Height        = 18
6778:             .FontName      = "Tahoma"
6779:             .FontSize      = 8
6780:             .SpecialEffect = 1
6781:             .Format        = "K"
6782:             .InputMask     = "999.99"
6783:             .Visible       = .T.
6784:         ENDWITH
6785: 
6786:         *-- Descricao Original (top=162)
6787:         loc_oAba.AddObject("lbl_4c_LblDescOrig", "Label")
6788:         WITH loc_oAba.lbl_4c_LblDescOrig

*-- Linhas 6799 a 6817:
6799: 
6800:         loc_oAba.AddObject("txt_4c_DescOrigL", "TextBox")
6801:         WITH loc_oAba.txt_4c_DescOrigL
6802:             .ControlSource = "crSigCnFNf.ldescpro"
6803:             .Top           = 159
6804:             .Left          = 143
6805:             .Width         = 27
6806:             .Height        = 18
6807:             .FontName      = "Tahoma"
6808:             .FontSize      = 8
6809:             .SpecialEffect = 1
6810:             .Format        = "K"
6811:             .InputMask     = "999.99"
6812:             .Visible       = .T.
6813:         ENDWITH
6814: 
6815:         *-- Adendo Tp. Fatura (top=180)
6816:         loc_oAba.AddObject("lbl_4c_LblAdendo", "Label")
6817:         WITH loc_oAba.lbl_4c_LblAdendo

*-- Linhas 6828 a 6846:
6828: 
6829:         loc_oAba.AddObject("txt_4c_AdendoL", "TextBox")
6830:         WITH loc_oAba.txt_4c_AdendoL
6831:             .ControlSource = "crSigCnFNf.ltipi"
6832:             .Top           = 177
6833:             .Left          = 143
6834:             .Width         = 27
6835:             .Height        = 18
6836:             .FontName      = "Tahoma"
6837:             .FontSize      = 8
6838:             .SpecialEffect = 1
6839:             .Format        = "K"
6840:             .InputMask     = "999.99"
6841:             .Visible       = .T.
6842:         ENDWITH
6843: 
6844:         *-- Cor (top=198)
6845:         loc_oAba.AddObject("lbl_4c_LblCor", "Label")
6846:         WITH loc_oAba.lbl_4c_LblCor

*-- Linhas 6857 a 6875:
6857: 
6858:         loc_oAba.AddObject("txt_4c_CorL", "TextBox")
6859:         WITH loc_oAba.txt_4c_CorL
6860:             .ControlSource = "crSigCnFNf.ocor"
6861:             .Top           = 195
6862:             .Left          = 143
6863:             .Width         = 27
6864:             .Height        = 18
6865:             .FontName      = "Tahoma"
6866:             .FontSize      = 8
6867:             .SpecialEffect = 1
6868:             .Format        = "K"
6869:             .InputMask     = "999.99"
6870:             .Visible       = .T.
6871:         ENDWITH
6872: 
6873:         *-- Embalagem (top=216)
6874:         loc_oAba.AddObject("lbl_4c_LblEmb", "Label")
6875:         WITH loc_oAba.lbl_4c_LblEmb

*-- Linhas 6886 a 6904:
6886: 
6887:         loc_oAba.AddObject("txt_4c_EmbL", "TextBox")
6888:         WITH loc_oAba.txt_4c_EmbL
6889:             .ControlSource = "crSigCnFNf.oemb"
6890:             .Top           = 213
6891:             .Left          = 143
6892:             .Width         = 27
6893:             .Height        = 18
6894:             .FontName      = "Tahoma"
6895:             .FontSize      = 8
6896:             .SpecialEffect = 1
6897:             .Format        = "K"
6898:             .InputMask     = "999.99"
6899:             .Visible       = .T.
6900:         ENDWITH
6901: 
6902:         *-- Tamanho (top=234)
6903:         loc_oAba.AddObject("lbl_4c_LblTamanho", "Label")
6904:         WITH loc_oAba.lbl_4c_LblTamanho

*-- Linhas 6915 a 6933:
6915: 
6916:         loc_oAba.AddObject("txt_4c_TamL", "TextBox")
6917:         WITH loc_oAba.txt_4c_TamL
6918:             .ControlSource = "crSigCnFNf.otam"
6919:             .Top           = 231
6920:             .Left          = 143
6921:             .Width         = 27
6922:             .Height        = 18
6923:             .FontName      = "Tahoma"
6924:             .FontSize      = 8
6925:             .SpecialEffect = 1
6926:             .Format        = "K"
6927:             .InputMask     = "999.99"
6928:             .Visible       = .T.
6929:         ENDWITH
6930: 
6931:         *-- Coluna Obs (top=137, right side)
6932:         loc_oAba.AddObject("lbl_4c_LblColObs", "Label")
6933:         WITH loc_oAba.lbl_4c_LblColObs

*-- Linhas 6944 a 6962:
6944: 
6945:         loc_oAba.AddObject("txt_4c_ColObsL", "TextBox")
6946:         WITH loc_oAba.txt_4c_ColObsL
6947:             .ControlSource = "crSigCnFNf.tamcolobs"
6948:             .Top           = 149
6949:             .Left          = 207
6950:             .Width         = 41
6951:             .Height        = 18
6952:             .FontName      = "Tahoma"
6953:             .FontSize      = 8
6954:             .SpecialEffect = 1
6955:             .Format        = "K"
6956:             .InputMask     = "999.99"
6957:             .Visible       = .T.
6958:         ENDWITH
6959: 
6960:         *-- No. Colunas (top=137)
6961:         loc_oAba.AddObject("lbl_4c_LblNoCols", "Label")
6962:         WITH loc_oAba.lbl_4c_LblNoCols

*-- Linhas 6973 a 6991:
6973: 
6974:         loc_oAba.AddObject("txt_4c_NoColsL", "TextBox")
6975:         WITH loc_oAba.txt_4c_NoColsL
6976:             .ControlSource = "crSigCnFNf.nldser"
6977:             .Top           = 149
6978:             .Left          = 279
6979:             .Width         = 41
6980:             .Height        = 18
6981:             .FontName      = "Tahoma"
6982:             .FontSize      = 8
6983:             .SpecialEffect = 1
6984:             .Format        = "K"
6985:             .InputMask     = "999.99"
6986:             .Visible       = .T.
6987:         ENDWITH
6988: 
6989:         *-- No. Linhas (top=137)
6990:         loc_oAba.AddObject("lbl_4c_LblNoLins", "Label")
6991:         WITH loc_oAba.lbl_4c_LblNoLins

*-- Linhas 7002 a 7020:
7002: 
7003:         loc_oAba.AddObject("txt_4c_NoLinsL", "TextBox")
7004:         WITH loc_oAba.txt_4c_NoLinsL
7005:             .ControlSource = "crSigCnFNf.ncdser"
7006:             .Top           = 149
7007:             .Left          = 348
7008:             .Width         = 41
7009:             .Height        = 18
7010:             .FontName      = "Tahoma"
7011:             .FontSize      = 8
7012:             .SpecialEffect = 1
7013:             .Format        = "K"
7014:             .InputMask     = "999.99"
7015:             .Visible       = .T.
7016:         ENDWITH
7017: 
7018:         *-- Total de Quantidade (top=136)
7019:         loc_oAba.AddObject("lbl_4c_LblTotQtd", "Label")
7020:         WITH loc_oAba.lbl_4c_LblTotQtd

*-- Linhas 7031 a 7049:
7031: 
7032:         loc_oAba.AddObject("txt_4c_TotQtdL", "TextBox")
7033:         WITH loc_oAba.txt_4c_TotQtdL
7034:             .ControlSource = "crSigCnFNf.ltqtde"
7035:             .Top           = 148
7036:             .Left          = 419
7037:             .Width         = 41
7038:             .Height        = 18
7039:             .FontName      = "Tahoma"
7040:             .FontSize      = 8
7041:             .SpecialEffect = 1
7042:             .Format        = "K"
7043:             .InputMask     = "999.99"
7044:             .Visible       = .T.
7045:         ENDWITH
7046: 
7047:         loc_oAba.AddObject("lbl_4c_TotQtdX", "Label")
7048:         WITH loc_oAba.lbl_4c_TotQtdX
7049:             .Caption   = "x"

*-- Linhas 7059 a 7077:
7059: 
7060:         loc_oAba.AddObject("txt_4c_TotQtdC", "TextBox")
7061:         WITH loc_oAba.txt_4c_TotQtdC
7062:             .ControlSource = "crSigCnFNf.ctqtde"
7063:             .Top           = 148
7064:             .Left          = 468
7065:             .Width         = 41
7066:             .Height        = 18
7067:             .FontName      = "Tahoma"
7068:             .FontSize      = 8
7069:             .SpecialEffect = 1
7070:             .Format        = "K"
7071:             .InputMask     = "999.99"
7072:             .Visible       = .T.
7073:         ENDWITH
7074: 
7075:         *-- Desconto/Acrescimo (top=193)
7076:         loc_oAba.AddObject("lbl_4c_LblDescAcr", "Label")
7077:         WITH loc_oAba.lbl_4c_LblDescAcr

*-- Linhas 7088 a 7106:
7088: 
7089:         loc_oAba.AddObject("txt_4c_DescAcrL", "TextBox")
7090:         WITH loc_oAba.txt_4c_DescAcrL
7091:             .ControlSource = "crSigCnFNf.cdesconto"
7092:             .Top           = 205
7093:             .Left          = 250
7094:             .Width         = 41
7095:             .Height        = 18
7096:             .FontName      = "Tahoma"
7097:             .FontSize      = 8
7098:             .SpecialEffect = 1
7099:             .Format        = "K"
7100:             .InputMask     = "999.99"
7101:             .Visible       = .T.
7102:         ENDWITH
7103: 
7104:         loc_oAba.AddObject("lbl_4c_DescAcrX", "Label")
7105:         WITH loc_oAba.lbl_4c_DescAcrX
7106:             .Caption   = "x"

*-- Linhas 7116 a 7134:
7116: 
7117:         loc_oAba.AddObject("txt_4c_DescAcrC", "TextBox")
7118:         WITH loc_oAba.txt_4c_DescAcrC
7119:             .ControlSource = "crSigCnFNf.cdesconto"
7120:             .Top           = 205
7121:             .Left          = 299
7122:             .Width         = 41
7123:             .Height        = 18
7124:             .FontName      = "Tahoma"
7125:             .FontSize      = 8
7126:             .SpecialEffect = 1
7127:             .Format        = "K"
7128:             .InputMask     = "999.99"
7129:             .Visible       = .T.
7130:         ENDWITH
7131: 
7132:         *-- Shape para Descricao 3D border (top=134)
7133:         loc_oAba.AddObject("shp_4c_Shape3", "Shape")
7134:         WITH loc_oAba.shp_4c_Shape3

*-- Linhas 7161 a 7179:
7161: 
7162:         loc_oAba.AddObject("txt_4c_BcICMSL", "TextBox")
7163:         WITH loc_oAba.txt_4c_BcICMSL
7164:             .ControlSource = "crSigCnFNf.lbicm"
7165:             .Top = 31
7166:             .Left = 39
7167:             .Width = 41
7168:             .Height = 18
7169:             .FontName = "Tahoma"
7170:             .FontSize = 8
7171:             .SpecialEffect = 1
7172:             .Format = "K"
7173:             .InputMask = "999.99"
7174:             .Visible = .T.
7175:         ENDWITH
7176: 
7177:         loc_oAba.AddObject("lbl_4c_BcICMSX", "Label")
7178:         WITH loc_oAba.lbl_4c_BcICMSX
7179:             .Caption = "x"

*-- Linhas 7189 a 7207:
7189: 
7190:         loc_oAba.AddObject("txt_4c_BcICMSC", "TextBox")
7191:         WITH loc_oAba.txt_4c_BcICMSC
7192:             .ControlSource = "crSigCnFNf.cbicm"
7193:             .Top = 31
7194:             .Left = 88
7195:             .Width = 41
7196:             .Height = 18
7197:             .FontName = "Tahoma"
7198:             .FontSize = 8
7199:             .SpecialEffect = 1
7200:             .Format = "K"
7201:             .InputMask = "999.99"
7202:             .Visible = .T.
7203:         ENDWITH
7204: 
7205:         *-- Valor do ICMS (top=19)
7206:         loc_oAba.AddObject("lbl_4c_LblValICMS", "Label")
7207:         WITH loc_oAba.lbl_4c_LblValICMS

*-- Linhas 7218 a 7236:
7218: 
7219:         loc_oAba.AddObject("txt_4c_ValICMSL", "TextBox")
7220:         WITH loc_oAba.txt_4c_ValICMSL
7221:             .ControlSource = "crSigCnFNf.lticm"
7222:             .Top = 31
7223:             .Left = 147
7224:             .Width = 41
7225:             .Height = 18
7226:             .FontName = "Tahoma"
7227:             .FontSize = 8
7228:             .SpecialEffect = 1
7229:             .Format = "K"
7230:             .InputMask = "999.99"
7231:             .Visible = .T.
7232:         ENDWITH
7233: 
7234:         loc_oAba.AddObject("lbl_4c_ValICMSX", "Label")
7235:         WITH loc_oAba.lbl_4c_ValICMSX
7236:             .Caption = "x"

*-- Linhas 7246 a 7264:
7246: 
7247:         loc_oAba.AddObject("txt_4c_ValICMSC", "TextBox")
7248:         WITH loc_oAba.txt_4c_ValICMSC
7249:             .ControlSource = "crSigCnFNf.cticm"
7250:             .Top = 31
7251:             .Left = 196
7252:             .Width = 41
7253:             .Height = 18
7254:             .FontName = "Tahoma"
7255:             .FontSize = 8
7256:             .SpecialEffect = 1
7257:             .Format = "K"
7258:             .InputMask = "999.99"
7259:             .Visible = .T.
7260:         ENDWITH
7261: 
7262:         *-- Valor do Frete (top=53)
7263:         loc_oAba.AddObject("lbl_4c_LblValFret", "Label")
7264:         WITH loc_oAba.lbl_4c_LblValFret

*-- Linhas 7275 a 7293:
7275: 
7276:         loc_oAba.AddObject("txt_4c_ValFretL", "TextBox")
7277:         WITH loc_oAba.txt_4c_ValFretL
7278:             .ControlSource = "crSigCnFNf.lfrete"
7279:             .Top = 65
7280:             .Left = 39
7281:             .Width = 41
7282:             .Height = 18
7283:             .FontName = "Tahoma"
7284:             .FontSize = 8
7285:             .SpecialEffect = 1
7286:             .Format = "K"
7287:             .InputMask = "999.99"
7288:             .Visible = .T.
7289:         ENDWITH
7290: 
7291:         loc_oAba.AddObject("lbl_4c_ValFretX", "Label")
7292:         WITH loc_oAba.lbl_4c_ValFretX
7293:             .Caption = "x"

*-- Linhas 7303 a 7321:
7303: 
7304:         loc_oAba.AddObject("txt_4c_ValFretC", "TextBox")
7305:         WITH loc_oAba.txt_4c_ValFretC
7306:             .ControlSource = "crSigCnFNf.cfrete"
7307:             .Top = 65
7308:             .Left = 88
7309:             .Width = 41
7310:             .Height = 18
7311:             .FontName = "Tahoma"
7312:             .FontSize = 8
7313:             .SpecialEffect = 1
7314:             .Format = "K"
7315:             .InputMask = "999.99"
7316:             .Visible = .T.
7317:         ENDWITH
7318: 
7319:         *-- Valor do Seguro (top=53)
7320:         loc_oAba.AddObject("lbl_4c_LblValSeg", "Label")
7321:         WITH loc_oAba.lbl_4c_LblValSeg

*-- Linhas 7332 a 7350:
7332: 
7333:         loc_oAba.AddObject("txt_4c_ValSegL", "TextBox")
7334:         WITH loc_oAba.txt_4c_ValSegL
7335:             .ControlSource = "crSigCnFNf.lseguro"
7336:             .Top = 65
7337:             .Left = 147
7338:             .Width = 41
7339:             .Height = 18
7340:             .FontName = "Tahoma"
7341:             .FontSize = 8
7342:             .SpecialEffect = 1
7343:             .Format = "K"
7344:             .InputMask = "999.99"
7345:             .Visible = .T.
7346:         ENDWITH
7347: 
7348:         loc_oAba.AddObject("lbl_4c_ValSegX", "Label")
7349:         WITH loc_oAba.lbl_4c_ValSegX
7350:             .Caption = "x"

*-- Linhas 7360 a 7378:
7360: 
7361:         loc_oAba.AddObject("txt_4c_ValSegC", "TextBox")
7362:         WITH loc_oAba.txt_4c_ValSegC
7363:             .ControlSource = "crSigCnFNf.cseguro"
7364:             .Top = 65
7365:             .Left = 196
7366:             .Width = 41
7367:             .Height = 18
7368:             .FontName = "Tahoma"
7369:             .FontSize = 8
7370:             .SpecialEffect = 1
7371:             .Format = "K"
7372:             .InputMask = "999.99"
7373:             .Visible = .T.
7374:         ENDWITH
7375: 
7376:         *-- Outras Despesas (top=53)
7377:         loc_oAba.AddObject("lbl_4c_LblOutDesp", "Label")
7378:         WITH loc_oAba.lbl_4c_LblOutDesp

*-- Linhas 7389 a 7407:
7389: 
7390:         loc_oAba.AddObject("txt_4c_OutDespL", "TextBox")
7391:         WITH loc_oAba.txt_4c_OutDespL
7392:             .ControlSource = "crSigCnFNf.coutras"
7393:             .Top = 65
7394:             .Left = 255
7395:             .Width = 41
7396:             .Height = 18
7397:             .FontName = "Tahoma"
7398:             .FontSize = 8
7399:             .SpecialEffect = 1
7400:             .Format = "K"
7401:             .InputMask = "999.99"
7402:             .Visible = .T.
7403:         ENDWITH
7404: 
7405:         loc_oAba.AddObject("lbl_4c_OutDespX", "Label")
7406:         WITH loc_oAba.lbl_4c_OutDespX
7407:             .Caption = "x"

*-- Linhas 7417 a 7435:
7417: 
7418:         loc_oAba.AddObject("txt_4c_OutDespC", "TextBox")
7419:         WITH loc_oAba.txt_4c_OutDespC
7420:             .ControlSource = "crSigCnFNf.coutras"
7421:             .Top = 65
7422:             .Left = 304
7423:             .Width = 41
7424:             .Height = 18
7425:             .FontName = "Tahoma"
7426:             .FontSize = 8
7427:             .SpecialEffect = 1
7428:             .Format = "K"
7429:             .InputMask = "999.99"
7430:             .Visible = .T.
7431:         ENDWITH
7432: 
7433:         *-- Valor dos Produtos (top=89)
7434:         loc_oAba.AddObject("lbl_4c_LblValProd", "Label")
7435:         WITH loc_oAba.lbl_4c_LblValProd

*-- Linhas 7446 a 7464:
7446: 
7447:         loc_oAba.AddObject("txt_4c_ValProdL", "TextBox")
7448:         WITH loc_oAba.txt_4c_ValProdL
7449:             .ControlSource = "crSigCnFNf.lvltot"
7450:             .Top = 101
7451:             .Left = 39
7452:             .Width = 41
7453:             .Height = 18
7454:             .FontName = "Tahoma"
7455:             .FontSize = 8
7456:             .SpecialEffect = 1
7457:             .Format = "K"
7458:             .InputMask = "999.99"
7459:             .Visible = .T.
7460:         ENDWITH
7461: 
7462:         loc_oAba.AddObject("lbl_4c_ValProdX", "Label")
7463:         WITH loc_oAba.lbl_4c_ValProdX
7464:             .Caption = "x"

*-- Linhas 7474 a 7492:
7474: 
7475:         loc_oAba.AddObject("txt_4c_ValProdC", "TextBox")
7476:         WITH loc_oAba.txt_4c_ValProdC
7477:             .ControlSource = "crSigCnFNf.cvltot"
7478:             .Top = 101
7479:             .Left = 88
7480:             .Width = 41
7481:             .Height = 18
7482:             .FontName = "Tahoma"
7483:             .FontSize = 8
7484:             .SpecialEffect = 1
7485:             .Format = "K"
7486:             .InputMask = "999.99"
7487:             .Visible = .T.
7488:         ENDWITH
7489: 
7490:         *-- Base de Calculo do IPI (top=89)
7491:         loc_oAba.AddObject("lbl_4c_LblBcIPI", "Label")
7492:         WITH loc_oAba.lbl_4c_LblBcIPI

*-- Linhas 7503 a 7521:
7503: 
7504:         loc_oAba.AddObject("txt_4c_BcIPIL", "TextBox")
7505:         WITH loc_oAba.txt_4c_BcIPIL
7506:             .ControlSource = "crSigCnFNf.lbicm"
7507:             .Top = 101
7508:             .Left = 147
7509:             .Width = 41
7510:             .Height = 18
7511:             .FontName = "Tahoma"
7512:             .FontSize = 8
7513:             .SpecialEffect = 1
7514:             .Format = "K"
7515:             .InputMask = "999.99"
7516:             .Visible = .T.
7517:         ENDWITH
7518: 
7519:         loc_oAba.AddObject("lbl_4c_BcIPIX", "Label")
7520:         WITH loc_oAba.lbl_4c_BcIPIX
7521:             .Caption = "x"

*-- Linhas 7531 a 7549:
7531: 
7532:         loc_oAba.AddObject("txt_4c_BcIPIC", "TextBox")
7533:         WITH loc_oAba.txt_4c_BcIPIC
7534:             .ControlSource = "crSigCnFNf.cbicm"
7535:             .Top = 101
7536:             .Left = 196
7537:             .Width = 41
7538:             .Height = 18
7539:             .FontName = "Tahoma"
7540:             .FontSize = 8
7541:             .SpecialEffect = 1
7542:             .Format = "K"
7543:             .InputMask = "999.99"
7544:             .Visible = .T.
7545:         ENDWITH
7546: 
7547:         *-- Valor Total do IPI (top=89)
7548:         loc_oAba.AddObject("lbl_4c_LblVlTIPI", "Label")
7549:         WITH loc_oAba.lbl_4c_LblVlTIPI

*-- Linhas 7560 a 7578:
7560: 
7561:         loc_oAba.AddObject("txt_4c_VlTIPIL", "TextBox")
7562:         WITH loc_oAba.txt_4c_VlTIPIL
7563:             .ControlSource = "crSigCnFNf.ctipi"
7564:             .Top = 101
7565:             .Left = 255
7566:             .Width = 41
7567:             .Height = 18
7568:             .FontName = "Tahoma"
7569:             .FontSize = 8
7570:             .SpecialEffect = 1
7571:             .Format = "K"
7572:             .InputMask = "999.99"
7573:             .Visible = .T.
7574:         ENDWITH
7575: 
7576:         loc_oAba.AddObject("lbl_4c_VlTIPIX", "Label")
7577:         WITH loc_oAba.lbl_4c_VlTIPIX
7578:             .Caption = "x"

*-- Linhas 7588 a 7606:
7588: 
7589:         loc_oAba.AddObject("txt_4c_VlTIPIC", "TextBox")
7590:         WITH loc_oAba.txt_4c_VlTIPIC
7591:             .ControlSource = "crSigCnFNf.ctipi"
7592:             .Top = 101
7593:             .Left = 304
7594:             .Width = 41
7595:             .Height = 18
7596:             .FontName = "Tahoma"
7597:             .FontSize = 8
7598:             .SpecialEffect = 1
7599:             .Format = "K"
7600:             .InputMask = "999.99"
7601:             .Visible = .T.
7602:         ENDWITH
7603: 
7604:         *-- Valor Total da Nota (top=89)
7605:         loc_oAba.AddObject("lbl_4c_LblVlTNota", "Label")
7606:         WITH loc_oAba.lbl_4c_LblVlTNota

*-- Linhas 7617 a 7635:
7617: 
7618:         loc_oAba.AddObject("txt_4c_VlTNotaL", "TextBox")
7619:         WITH loc_oAba.txt_4c_VlTNotaL
7620:             .ControlSource = "crSigCnFNf.ltnota"
7621:             .Top = 101
7622:             .Left = 363
7623:             .Width = 41
7624:             .Height = 18
7625:             .FontName = "Tahoma"
7626:             .FontSize = 8
7627:             .SpecialEffect = 1
7628:             .Format = "K"
7629:             .InputMask = "999.99"
7630:             .Visible = .T.
7631:         ENDWITH
7632: 
7633:         loc_oAba.AddObject("lbl_4c_VlTNotaX", "Label")
7634:         WITH loc_oAba.lbl_4c_VlTNotaX
7635:             .Caption = "x"

*-- Linhas 7645 a 7663:
7645: 
7646:         loc_oAba.AddObject("txt_4c_VlTNotaC", "TextBox")
7647:         WITH loc_oAba.txt_4c_VlTNotaC
7648:             .ControlSource = "crSigCnFNf.ctnota"
7649:             .Top = 101
7650:             .Left = 412
7651:             .Width = 41
7652:             .Height = 18
7653:             .FontName = "Tahoma"
7654:             .FontSize = 8
7655:             .SpecialEffect = 1
7656:             .Format = "K"
7657:             .InputMask = "999.99"
7658:             .Visible = .T.
7659:         ENDWITH
7660: 
7661:         *-- Fonte (top=89)
7662:         loc_oAba.AddObject("lbl_4c_LblFonte", "Label")
7663:         WITH loc_oAba.lbl_4c_LblFonte

*-- Linhas 7674 a 7692:
7674: 
7675:         loc_oAba.AddObject("txt_4c_FonteL", "TextBox")
7676:         WITH loc_oAba.txt_4c_FonteL
7677:             .ControlSource = "crSigCnFNf.ltpfrete"
7678:             .Top = 101
7679:             .Left = 461
7680:             .Width = 23
7681:             .Height = 18
7682:             .FontName = "Tahoma"
7683:             .FontSize = 8
7684:             .SpecialEffect = 1
7685:             .Format = "K"
7686:             .InputMask = "999.99"
7687:             .Visible = .T.
7688:         ENDWITH
7689: 
7690:         *-- Base do ICMS ST (top=125)
7691:         loc_oAba.AddObject("lbl_4c_LblBcST", "Label")
7692:         WITH loc_oAba.lbl_4c_LblBcST

*-- Linhas 7703 a 7721:
7703: 
7704:         loc_oAba.AddObject("txt_4c_BcSTL", "TextBox")
7705:         WITH loc_oAba.txt_4c_BcSTL
7706:             .ControlSource = "crSigCnFNf.lbicm"
7707:             .Top = 137
7708:             .Left = 39
7709:             .Width = 41
7710:             .Height = 18
7711:             .FontName = "Tahoma"
7712:             .FontSize = 8
7713:             .SpecialEffect = 1
7714:             .Format = "K"
7715:             .InputMask = "999.99"
7716:             .Visible = .T.
7717:         ENDWITH
7718: 
7719:         loc_oAba.AddObject("lbl_4c_BcSTX", "Label")
7720:         WITH loc_oAba.lbl_4c_BcSTX
7721:             .Caption = "x"

*-- Linhas 7731 a 7749:
7731: 
7732:         loc_oAba.AddObject("txt_4c_BcSTC", "TextBox")
7733:         WITH loc_oAba.txt_4c_BcSTC
7734:             .ControlSource = "crSigCnFNf.cbicm"
7735:             .Top = 137
7736:             .Left = 88
7737:             .Width = 41
7738:             .Height = 18
7739:             .FontName = "Tahoma"
7740:             .FontSize = 8
7741:             .SpecialEffect = 1
7742:             .Format = "K"
7743:             .InputMask = "999.99"
7744:             .Visible = .T.
7745:         ENDWITH
7746: 
7747:         *-- Valor do ICMS ST (top=125)
7748:         loc_oAba.AddObject("lbl_4c_LblValST", "Label")
7749:         WITH loc_oAba.lbl_4c_LblValST

*-- Linhas 7760 a 7778:
7760: 
7761:         loc_oAba.AddObject("txt_4c_ValSTL", "TextBox")
7762:         WITH loc_oAba.txt_4c_ValSTL
7763:             .ControlSource = "crSigCnFNf.lticm"
7764:             .Top = 137
7765:             .Left = 147
7766:             .Width = 41
7767:             .Height = 18
7768:             .FontName = "Tahoma"
7769:             .FontSize = 8
7770:             .SpecialEffect = 1
7771:             .Format = "K"
7772:             .InputMask = "999.99"
7773:             .Visible = .T.
7774:         ENDWITH
7775: 
7776:         loc_oAba.AddObject("lbl_4c_ValSTX", "Label")
7777:         WITH loc_oAba.lbl_4c_ValSTX
7778:             .Caption = "x"

*-- Linhas 7788 a 7806:
7788: 
7789:         loc_oAba.AddObject("txt_4c_ValSTC", "TextBox")
7790:         WITH loc_oAba.txt_4c_ValSTC
7791:             .ControlSource = "crSigCnFNf.cticm"
7792:             .Top = 137
7793:             .Left = 196
7794:             .Width = 41
7795:             .Height = 18
7796:             .FontName = "Tahoma"
7797:             .FontSize = 8
7798:             .SpecialEffect = 1
7799:             .Format = "K"
7800:             .InputMask = "999.99"
7801:             .Visible = .T.
7802:         ENDWITH
7803: 
7804:         *-- IR e ISS (top=180 shape, top=166 %, top=180 labels)
7805:         loc_oAba.AddObject("shp_4c_IRShape", "Shape")
7806:         WITH loc_oAba.shp_4c_IRShape

*-- Linhas 7839 a 7857:
7839: 
7840:         loc_oAba.AddObject("txt_4c_IRVal", "TextBox")
7841:         WITH loc_oAba.txt_4c_IRVal
7842:             .ControlSource = "crSigCnFNf.pirs"
7843:             .Top = 193
7844:             .Left = 44
7845:             .Width = 46
7846:             .Height = 18
7847:             .FontName = "Tahoma"
7848:             .FontSize = 8
7849:             .SpecialEffect = 1
7850:             .Format = "K"
7851:             .InputMask = "999.99"
7852:             .Visible = .T.
7853:         ENDWITH
7854: 
7855:         loc_oAba.AddObject("lbl_4c_LblISS", "Label")
7856:         WITH loc_oAba.lbl_4c_LblISS
7857:             .Caption = "I.S.S."

*-- Linhas 7867 a 7885:
7867: 
7868:         loc_oAba.AddObject("txt_4c_ISSVal", "TextBox")
7869:         WITH loc_oAba.txt_4c_ISSVal
7870:             .ControlSource = "crSigCnFNf.piss"
7871:             .Top = 193
7872:             .Left = 93
7873:             .Width = 46
7874:             .Height = 18
7875:             .FontName = "Tahoma"
7876:             .FontSize = 8
7877:             .SpecialEffect = 1
7878:             .Format = "K"
7879:             .InputMask = "999.99"
7880:             .Visible = .T.
7881:         ENDWITH
7882:     ENDPROC
7883: 
7884:     *--------------------------------------------------------------------------
7885:     PROTECTED PROCEDURE ConfigurarTransporteTab()

*-- Linhas 7925 a 7943:
7925: 
7926:         loc_oAba.AddObject("txt_4c_TrNomeL", "TextBox")
7927:         WITH loc_oAba.txt_4c_TrNomeL
7928:             .ControlSource = "crSigCnFNf.ltrnome"
7929:             .Top = 36
7930:             .Left = 17
7931:             .Width = 41
7932:             .Height = 18
7933:             .FontName = "Tahoma"
7934:             .FontSize = 8
7935:             .SpecialEffect = 1
7936:             .Format = "K"
7937:             .InputMask = "999.99"
7938:             .Visible = .T.
7939:         ENDWITH
7940: 
7941:         loc_oAba.AddObject("lbl_4c_TrNomeX", "Label")
7942:         WITH loc_oAba.lbl_4c_TrNomeX
7943:             .Caption = "x"

*-- Linhas 7953 a 7971:
7953: 
7954:         loc_oAba.AddObject("txt_4c_TrNomeC", "TextBox")
7955:         WITH loc_oAba.txt_4c_TrNomeC
7956:             .ControlSource = "crSigCnFNf.ctrnome"
7957:             .Top = 36
7958:             .Left = 66
7959:             .Width = 41
7960:             .Height = 18
7961:             .FontName = "Tahoma"
7962:             .FontSize = 8
7963:             .SpecialEffect = 1
7964:             .Format = "K"
7965:             .InputMask = "999.99"
7966:             .Visible = .T.
7967:         ENDWITH
7968: 
7969:         *-- CGC/CPF transportador (top=24)
7970:         loc_oAba.AddObject("lbl_4c_LblTrCgc", "Label")
7971:         WITH loc_oAba.lbl_4c_LblTrCgc

*-- Linhas 7982 a 8000:
7982: 
7983:         loc_oAba.AddObject("txt_4c_TrCgcL", "TextBox")
7984:         WITH loc_oAba.txt_4c_TrCgcL
7985:             .ControlSource = "crSigCnFNf.ltrcgc"
7986:             .Top = 36
7987:             .Left = 125
7988:             .Width = 41
7989:             .Height = 18
7990:             .FontName = "Tahoma"
7991:             .FontSize = 8
7992:             .SpecialEffect = 1
7993:             .Format = "K"
7994:             .InputMask = "999.99"
7995:             .Visible = .T.
7996:         ENDWITH
7997: 
7998:         loc_oAba.AddObject("lbl_4c_TrCgcX", "Label")
7999:         WITH loc_oAba.lbl_4c_TrCgcX
8000:             .Caption = "x"

*-- Linhas 8010 a 8028:
8010: 
8011:         loc_oAba.AddObject("txt_4c_TrCgcC", "TextBox")
8012:         WITH loc_oAba.txt_4c_TrCgcC
8013:             .ControlSource = "crSigCnFNf.ctrcgc"
8014:             .Top = 36
8015:             .Left = 174
8016:             .Width = 41
8017:             .Height = 18
8018:             .FontName = "Tahoma"
8019:             .FontSize = 8
8020:             .SpecialEffect = 1
8021:             .Format = "K"
8022:             .InputMask = "999.99"
8023:             .Visible = .T.
8024:         ENDWITH
8025: 
8026:         *-- Insc.Estadual transportador (top=24)
8027:         loc_oAba.AddObject("lbl_4c_LblTrIest", "Label")
8028:         WITH loc_oAba.lbl_4c_LblTrIest

*-- Linhas 8039 a 8057:
8039: 
8040:         loc_oAba.AddObject("txt_4c_TrIestL", "TextBox")
8041:         WITH loc_oAba.txt_4c_TrIestL
8042:             .ControlSource = "crSigCnFNf.ltrie"
8043:             .Top = 36
8044:             .Left = 233
8045:             .Width = 41
8046:             .Height = 18
8047:             .FontName = "Tahoma"
8048:             .FontSize = 8
8049:             .SpecialEffect = 1
8050:             .Format = "K"
8051:             .InputMask = "999.99"
8052:             .Visible = .T.
8053:         ENDWITH
8054: 
8055:         loc_oAba.AddObject("lbl_4c_TrIestX", "Label")
8056:         WITH loc_oAba.lbl_4c_TrIestX
8057:             .Caption = "x"

*-- Linhas 8067 a 8085:
8067: 
8068:         loc_oAba.AddObject("txt_4c_TrIestC", "TextBox")
8069:         WITH loc_oAba.txt_4c_TrIestC
8070:             .ControlSource = "crSigCnFNf.ctrie"
8071:             .Top = 36
8072:             .Left = 282
8073:             .Width = 41
8074:             .Height = 18
8075:             .FontName = "Tahoma"
8076:             .FontSize = 8
8077:             .SpecialEffect = 1
8078:             .Format = "K"
8079:             .InputMask = "999.99"
8080:             .Visible = .T.
8081:         ENDWITH
8082: 
8083:         *-- Endereco transportador (top=57)
8084:         loc_oAba.AddObject("lbl_4c_LblTrEnder", "Label")
8085:         WITH loc_oAba.lbl_4c_LblTrEnder

*-- Linhas 8096 a 8114:
8096: 
8097:         loc_oAba.AddObject("txt_4c_TrEnderL", "TextBox")
8098:         WITH loc_oAba.txt_4c_TrEnderL
8099:             .ControlSource = "crSigCnFNf.ltrend"
8100:             .Top = 69
8101:             .Left = 17
8102:             .Width = 41
8103:             .Height = 18
8104:             .FontName = "Tahoma"
8105:             .FontSize = 8
8106:             .SpecialEffect = 1
8107:             .Format = "K"
8108:             .InputMask = "999.99"
8109:             .Visible = .T.
8110:         ENDWITH
8111: 
8112:         loc_oAba.AddObject("lbl_4c_TrEnderX", "Label")
8113:         WITH loc_oAba.lbl_4c_TrEnderX
8114:             .Caption = "x"

*-- Linhas 8124 a 8142:
8124: 
8125:         loc_oAba.AddObject("txt_4c_TrEnderC", "TextBox")
8126:         WITH loc_oAba.txt_4c_TrEnderC
8127:             .ControlSource = "crSigCnFNf.ctrend"
8128:             .Top = 69
8129:             .Left = 66
8130:             .Width = 41
8131:             .Height = 18
8132:             .FontName = "Tahoma"
8133:             .FontSize = 8
8134:             .SpecialEffect = 1
8135:             .Format = "K"
8136:             .InputMask = "999.99"
8137:             .Visible = .T.
8138:         ENDWITH
8139: 
8140:         *-- Municipio transportador (top=57)
8141:         loc_oAba.AddObject("lbl_4c_LblTrMuni", "Label")
8142:         WITH loc_oAba.lbl_4c_LblTrMuni

*-- Linhas 8153 a 8171:
8153: 
8154:         loc_oAba.AddObject("txt_4c_TrMuniL", "TextBox")
8155:         WITH loc_oAba.txt_4c_TrMuniL
8156:             .ControlSource = "crSigCnFNf.ltrmun"
8157:             .Top = 69
8158:             .Left = 124
8159:             .Width = 41
8160:             .Height = 18
8161:             .FontName = "Tahoma"
8162:             .FontSize = 8
8163:             .SpecialEffect = 1
8164:             .Format = "K"
8165:             .InputMask = "999.99"
8166:             .Visible = .T.
8167:         ENDWITH
8168: 
8169:         loc_oAba.AddObject("lbl_4c_TrMuniX", "Label")
8170:         WITH loc_oAba.lbl_4c_TrMuniX
8171:             .Caption = "x"

*-- Linhas 8181 a 8199:
8181: 
8182:         loc_oAba.AddObject("txt_4c_TrMuniC", "TextBox")
8183:         WITH loc_oAba.txt_4c_TrMuniC
8184:             .ControlSource = "crSigCnFNf.ctrmun"
8185:             .Top = 69
8186:             .Left = 173
8187:             .Width = 41
8188:             .Height = 18
8189:             .FontName = "Tahoma"
8190:             .FontSize = 8
8191:             .SpecialEffect = 1
8192:             .Format = "K"
8193:             .InputMask = "999.99"
8194:             .Visible = .T.
8195:         ENDWITH
8196: 
8197:         *-- Estado transportador (top=57)
8198:         loc_oAba.AddObject("lbl_4c_LblTrEst", "Label")
8199:         WITH loc_oAba.lbl_4c_LblTrEst

*-- Linhas 8210 a 8228:
8210: 
8211:         loc_oAba.AddObject("txt_4c_TrEstL", "TextBox")
8212:         WITH loc_oAba.txt_4c_TrEstL
8213:             .ControlSource = "crSigCnFNf.ltrest"
8214:             .Top = 69
8215:             .Left = 232
8216:             .Width = 41
8217:             .Height = 18
8218:             .FontName = "Tahoma"
8219:             .FontSize = 8
8220:             .SpecialEffect = 1
8221:             .Format = "K"
8222:             .InputMask = "999.99"
8223:             .Visible = .T.
8224:         ENDWITH
8225: 
8226:         loc_oAba.AddObject("lbl_4c_TrEstX", "Label")
8227:         WITH loc_oAba.lbl_4c_TrEstX
8228:             .Caption = "x"

*-- Linhas 8238 a 8256:
8238: 
8239:         loc_oAba.AddObject("txt_4c_TrEstC", "TextBox")
8240:         WITH loc_oAba.txt_4c_TrEstC
8241:             .ControlSource = "crSigCnFNf.ctrest"
8242:             .Top = 69
8243:             .Left = 281
8244:             .Width = 41
8245:             .Height = 18
8246:             .FontName = "Tahoma"
8247:             .FontSize = 8
8248:             .SpecialEffect = 1
8249:             .Format = "K"
8250:             .InputMask = "999.99"
8251:             .Visible = .T.
8252:         ENDWITH
8253: 
8254:         *-- Tipo de Frete (top=91)
8255:         loc_oAba.AddObject("lbl_4c_LblTpFret", "Label")
8256:         WITH loc_oAba.lbl_4c_LblTpFret

*-- Linhas 8267 a 8285:
8267: 
8268:         loc_oAba.AddObject("txt_4c_TpFretL", "TextBox")
8269:         WITH loc_oAba.txt_4c_TpFretL
8270:             .ControlSource = "crSigCnFNf.ltpfrete"
8271:             .Top = 103
8272:             .Left = 17
8273:             .Width = 41
8274:             .Height = 18
8275:             .FontName = "Tahoma"
8276:             .FontSize = 8
8277:             .SpecialEffect = 1
8278:             .Format = "K"
8279:             .InputMask = "999.99"
8280:             .Visible = .T.
8281:         ENDWITH
8282: 
8283:         loc_oAba.AddObject("lbl_4c_TpFretX", "Label")
8284:         WITH loc_oAba.lbl_4c_TpFretX
8285:             .Caption = "x"

*-- Linhas 8295 a 8313:
8295: 
8296:         loc_oAba.AddObject("txt_4c_TpFretC", "TextBox")
8297:         WITH loc_oAba.txt_4c_TpFretC
8298:             .ControlSource = "crSigCnFNf.ctpfrete"
8299:             .Top = 103
8300:             .Left = 66
8301:             .Width = 41
8302:             .Height = 18
8303:             .FontName = "Tahoma"
8304:             .FontSize = 8
8305:             .SpecialEffect = 1
8306:             .Format = "K"
8307:             .InputMask = "999.99"
8308:             .Visible = .T.
8309:         ENDWITH
8310: 
8311:         *-- Placa do Veiculo (top=91)
8312:         loc_oAba.AddObject("lbl_4c_LblPlaca", "Label")
8313:         WITH loc_oAba.lbl_4c_LblPlaca

*-- Linhas 8324 a 8342:
8324: 
8325:         loc_oAba.AddObject("txt_4c_PlacaL", "TextBox")
8326:         WITH loc_oAba.txt_4c_PlacaL
8327:             .ControlSource = "crSigCnFNf.lplaca"
8328:             .Top = 103
8329:             .Left = 124
8330:             .Width = 41
8331:             .Height = 18
8332:             .FontName = "Tahoma"
8333:             .FontSize = 8
8334:             .SpecialEffect = 1
8335:             .Format = "K"
8336:             .InputMask = "999.99"
8337:             .Visible = .T.
8338:         ENDWITH
8339: 
8340:         loc_oAba.AddObject("lbl_4c_PlacaX", "Label")
8341:         WITH loc_oAba.lbl_4c_PlacaX
8342:             .Caption = "x"

*-- Linhas 8352 a 8370:
8352: 
8353:         loc_oAba.AddObject("txt_4c_PlacaC", "TextBox")
8354:         WITH loc_oAba.txt_4c_PlacaC
8355:             .ControlSource = "crSigCnFNf.cplaca"
8356:             .Top = 103
8357:             .Left = 173
8358:             .Width = 41
8359:             .Height = 18
8360:             .FontName = "Tahoma"
8361:             .FontSize = 8
8362:             .SpecialEffect = 1
8363:             .Format = "K"
8364:             .InputMask = "999.99"
8365:             .Visible = .T.
8366:         ENDWITH
8367: 
8368:         *-- Estado do Veiculo (top=91)
8369:         loc_oAba.AddObject("lbl_4c_LblEstVeic", "Label")
8370:         WITH loc_oAba.lbl_4c_LblEstVeic

*-- Linhas 8381 a 8399:
8381: 
8382:         loc_oAba.AddObject("txt_4c_EstVeicL", "TextBox")
8383:         WITH loc_oAba.txt_4c_EstVeicL
8384:             .ControlSource = "crSigCnFNf.lplacauf"
8385:             .Top = 103
8386:             .Left = 232
8387:             .Width = 41
8388:             .Height = 18
8389:             .FontName = "Tahoma"
8390:             .FontSize = 8
8391:             .SpecialEffect = 1
8392:             .Format = "K"
8393:             .InputMask = "999.99"
8394:             .Visible = .T.
8395:         ENDWITH
8396: 
8397:         loc_oAba.AddObject("lbl_4c_EstVeicX", "Label")
8398:         WITH loc_oAba.lbl_4c_EstVeicX
8399:             .Caption = "x"

*-- Linhas 8409 a 8427:
8409: 
8410:         loc_oAba.AddObject("txt_4c_EstVeicC", "TextBox")
8411:         WITH loc_oAba.txt_4c_EstVeicC
8412:             .ControlSource = "crSigCnFNf.cplacauf"
8413:             .Top = 103
8414:             .Left = 281
8415:             .Width = 41
8416:             .Height = 18
8417:             .FontName = "Tahoma"
8418:             .FontSize = 8
8419:             .SpecialEffect = 1
8420:             .Format = "K"
8421:             .InputMask = "999.99"
8422:             .Visible = .T.
8423:         ENDWITH
8424: 
8425:         *-- Shape Volumes Transportados (top=132)
8426:         loc_oAba.AddObject("shp_4c_Vols", "Shape")
8427:         WITH loc_oAba.shp_4c_Vols

*-- Linhas 8461 a 8479:
8461: 
8462:         loc_oAba.AddObject("txt_4c_QtVolL", "TextBox")
8463:         WITH loc_oAba.txt_4c_QtVolL
8464:             .ControlSource = "crSigCnFNf.lqtvol"
8465:             .Top = 161
8466:             .Left = 17
8467:             .Width = 41
8468:             .Height = 18
8469:             .FontName = "Tahoma"
8470:             .FontSize = 8
8471:             .SpecialEffect = 1
8472:             .Format = "K"
8473:             .InputMask = "999.99"
8474:             .Visible = .T.
8475:         ENDWITH
8476: 
8477:         loc_oAba.AddObject("lbl_4c_QtVolX", "Label")
8478:         WITH loc_oAba.lbl_4c_QtVolX
8479:             .Caption = "x"

*-- Linhas 8489 a 8507:
8489: 
8490:         loc_oAba.AddObject("txt_4c_QtVolC", "TextBox")
8491:         WITH loc_oAba.txt_4c_QtVolC
8492:             .ControlSource = "crSigCnFNf.cqtvol"
8493:             .Top = 161
8494:             .Left = 66
8495:             .Width = 41
8496:             .Height = 18
8497:             .FontName = "Tahoma"
8498:             .FontSize = 8
8499:             .SpecialEffect = 1
8500:             .Format = "K"
8501:             .InputMask = "999.99"
8502:             .Visible = .T.
8503:         ENDWITH
8504: 
8505:         *-- Especie (top=149)
8506:         loc_oAba.AddObject("lbl_4c_LblEsp", "Label")
8507:         WITH loc_oAba.lbl_4c_LblEsp

*-- Linhas 8518 a 8536:
8518: 
8519:         loc_oAba.AddObject("txt_4c_EspL", "TextBox")
8520:         WITH loc_oAba.txt_4c_EspL
8521:             .ControlSource = "crSigCnFNf.lesp"
8522:             .Top = 161
8523:             .Left = 124
8524:             .Width = 41
8525:             .Height = 18
8526:             .FontName = "Tahoma"
8527:             .FontSize = 8
8528:             .SpecialEffect = 1
8529:             .Format = "K"
8530:             .InputMask = "999.99"
8531:             .Visible = .T.
8532:         ENDWITH
8533: 
8534:         loc_oAba.AddObject("lbl_4c_EspX", "Label")
8535:         WITH loc_oAba.lbl_4c_EspX
8536:             .Caption = "x"

*-- Linhas 8546 a 8564:
8546: 
8547:         loc_oAba.AddObject("txt_4c_EspC", "TextBox")
8548:         WITH loc_oAba.txt_4c_EspC
8549:             .ControlSource = "crSigCnFNf.cesp"
8550:             .Top = 161
8551:             .Left = 173
8552:             .Width = 41
8553:             .Height = 18
8554:             .FontName = "Tahoma"
8555:             .FontSize = 8
8556:             .SpecialEffect = 1
8557:             .Format = "K"
8558:             .InputMask = "999.99"
8559:             .Visible = .T.
8560:         ENDWITH
8561: 
8562:         *-- Marca (top=149)
8563:         loc_oAba.AddObject("lbl_4c_LblMarca", "Label")
8564:         WITH loc_oAba.lbl_4c_LblMarca

*-- Linhas 8575 a 8593:
8575: 
8576:         loc_oAba.AddObject("txt_4c_MarcaL", "TextBox")
8577:         WITH loc_oAba.txt_4c_MarcaL
8578:             .ControlSource = "crSigCnFNf.lmarca"
8579:             .Top = 161
8580:             .Left = 232
8581:             .Width = 41
8582:             .Height = 18
8583:             .FontName = "Tahoma"
8584:             .FontSize = 8
8585:             .SpecialEffect = 1
8586:             .Format = "K"
8587:             .InputMask = "999.99"
8588:             .Visible = .T.
8589:         ENDWITH
8590: 
8591:         loc_oAba.AddObject("lbl_4c_MarcaX", "Label")
8592:         WITH loc_oAba.lbl_4c_MarcaX
8593:             .Caption = "x"

*-- Linhas 8603 a 8621:
8603: 
8604:         loc_oAba.AddObject("txt_4c_MarcaC", "TextBox")
8605:         WITH loc_oAba.txt_4c_MarcaC
8606:             .ControlSource = "crSigCnFNf.cmarca"
8607:             .Top = 161
8608:             .Left = 281
8609:             .Width = 41
8610:             .Height = 18
8611:             .FontName = "Tahoma"
8612:             .FontSize = 8
8613:             .SpecialEffect = 1
8614:             .Format = "K"
8615:             .InputMask = "999.99"
8616:             .Visible = .T.
8617:         ENDWITH
8618: 
8619:         *-- Numero (top=183)
8620:         loc_oAba.AddObject("lbl_4c_LblNumVol", "Label")
8621:         WITH loc_oAba.lbl_4c_LblNumVol

*-- Linhas 8632 a 8650:
8632: 
8633:         loc_oAba.AddObject("txt_4c_NumVolL", "TextBox")
8634:         WITH loc_oAba.txt_4c_NumVolL
8635:             .ControlSource = "crSigCnFNf.lnumero"
8636:             .Top = 195
8637:             .Left = 17
8638:             .Width = 41
8639:             .Height = 18
8640:             .FontName = "Tahoma"
8641:             .FontSize = 8
8642:             .SpecialEffect = 1
8643:             .Format = "K"
8644:             .InputMask = "999.99"
8645:             .Visible = .T.
8646:         ENDWITH
8647: 
8648:         loc_oAba.AddObject("lbl_4c_NumVolX", "Label")
8649:         WITH loc_oAba.lbl_4c_NumVolX
8650:             .Caption = "x"

*-- Linhas 8660 a 8678:
8660: 
8661:         loc_oAba.AddObject("txt_4c_NumVolC", "TextBox")
8662:         WITH loc_oAba.txt_4c_NumVolC
8663:             .ControlSource = "crSigCnFNf.cnumero"
8664:             .Top = 195
8665:             .Left = 66
8666:             .Width = 41
8667:             .Height = 18
8668:             .FontName = "Tahoma"
8669:             .FontSize = 8
8670:             .SpecialEffect = 1
8671:             .Format = "K"
8672:             .InputMask = "999.99"
8673:             .Visible = .T.
8674:         ENDWITH
8675: 
8676:         *-- Peso Bruto (top=183)
8677:         loc_oAba.AddObject("lbl_4c_LblPBru", "Label")
8678:         WITH loc_oAba.lbl_4c_LblPBru

*-- Linhas 8689 a 8707:
8689: 
8690:         loc_oAba.AddObject("txt_4c_PBruL", "TextBox")
8691:         WITH loc_oAba.txt_4c_PBruL
8692:             .ControlSource = "crSigCnFNf.lpbru"
8693:             .Top = 195
8694:             .Left = 124
8695:             .Width = 41
8696:             .Height = 18
8697:             .FontName = "Tahoma"
8698:             .FontSize = 8
8699:             .SpecialEffect = 1
8700:             .Format = "K"
8701:             .InputMask = "999.99"
8702:             .Visible = .T.
8703:         ENDWITH
8704: 
8705:         loc_oAba.AddObject("lbl_4c_PBruX", "Label")
8706:         WITH loc_oAba.lbl_4c_PBruX
8707:             .Caption = "x"

*-- Linhas 8717 a 8735:
8717: 
8718:         loc_oAba.AddObject("txt_4c_PBruC", "TextBox")
8719:         WITH loc_oAba.txt_4c_PBruC
8720:             .ControlSource = "crSigCnFNf.cpbru"
8721:             .Top = 195
8722:             .Left = 173
8723:             .Width = 41
8724:             .Height = 18
8725:             .FontName = "Tahoma"
8726:             .FontSize = 8
8727:             .SpecialEffect = 1
8728:             .Format = "K"
8729:             .InputMask = "999.99"
8730:             .Visible = .T.
8731:         ENDWITH
8732: 
8733:         *-- Peso Liquido (top=183)
8734:         loc_oAba.AddObject("lbl_4c_LblPLiq", "Label")
8735:         WITH loc_oAba.lbl_4c_LblPLiq

*-- Linhas 8746 a 8764:
8746: 
8747:         loc_oAba.AddObject("txt_4c_PLiqL", "TextBox")
8748:         WITH loc_oAba.txt_4c_PLiqL
8749:             .ControlSource = "crSigCnFNf.lpliq"
8750:             .Top = 195
8751:             .Left = 232
8752:             .Width = 41
8753:             .Height = 18
8754:             .FontName = "Tahoma"
8755:             .FontSize = 8
8756:             .SpecialEffect = 1
8757:             .Format = "K"
8758:             .InputMask = "999.99"
8759:             .Visible = .T.
8760:         ENDWITH
8761: 
8762:         loc_oAba.AddObject("lbl_4c_PLiqX", "Label")
8763:         WITH loc_oAba.lbl_4c_PLiqX
8764:             .Caption = "x"

*-- Linhas 8774 a 8792:
8774: 
8775:         loc_oAba.AddObject("txt_4c_PLiqC", "TextBox")
8776:         WITH loc_oAba.txt_4c_PLiqC
8777:             .ControlSource = "crSigCnFNf.cpliq"
8778:             .Top = 195
8779:             .Left = 281
8780:             .Width = 41
8781:             .Height = 18
8782:             .FontName = "Tahoma"
8783:             .FontSize = 8
8784:             .SpecialEffect = 1
8785:             .Format = "K"
8786:             .InputMask = "999.99"
8787:             .Visible = .T.
8788:         ENDWITH
8789: 
8790:         *-- Un Pesos (top=221)
8791:         loc_oAba.AddObject("lbl_4c_LblUnPesos", "Label")
8792:         WITH loc_oAba.lbl_4c_LblUnPesos

*-- Linhas 8803 a 8821:
8803: 
8804:         loc_oAba.AddObject("txt_4c_UnPesos", "TextBox")
8805:         WITH loc_oAba.txt_4c_UnPesos
8806:             .ControlSource = "crSigCnFNf.pesovols"
8807:             .Top = 219
8808:             .Left = 66
8809:             .Width = 41
8810:             .Height = 18
8811:             .FontName = "Tahoma"
8812:             .FontSize = 8
8813:             .SpecialEffect = 1
8814:             .Format = "K"
8815:             .InputMask = "999.99"
8816:             .Visible = .T.
8817:         ENDWITH
8818:     ENDPROC
8819: 
8820:     *--------------------------------------------------------------------------
8821:     PROTECTED PROCEDURE ConfigurarRodapeTab()

*-- Linhas 8952 a 8970:
8952: 
8953:             loc_oAba.AddObject("txt_4c_ClsL" + loc_cFat, "TextBox")
8954:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
8955:                 .ControlSource = "crSigCnFNf.lclas" + loc_cFat
8956:                 .Top = loc_nTop
8957:                 .Left = 80
8958:                 .Width = 41
8959:                 .Height = 18
8960:                 .FontName = "Tahoma"
8961:                 .FontSize = 8
8962:                 .SpecialEffect = 1
8963:                 .Format = "K"
8964:                 .InputMask = "999.99"
8965:                 .Visible = .T.
8966:             ENDWITH
8967: 
8968:             loc_oAba.AddObject("lbl_4c_ClsX" + loc_cFat, "Label")
8969:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
8970:                 .Caption = "x"

*-- Linhas 8980 a 8998:
8980: 
8981:             loc_oAba.AddObject("txt_4c_ClsC" + loc_cFat, "TextBox")
8982:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
8983:                 .ControlSource = "crSigCnFNf.cclas" + loc_cFat
8984:                 .Top = loc_nTop
8985:                 .Left = 129
8986:                 .Width = 41
8987:                 .Height = 18
8988:                 .FontName = "Tahoma"
8989:                 .FontSize = 8
8990:                 .SpecialEffect = 1
8991:                 .Format = "K"
8992:                 .InputMask = "999.99"
8993:                 .Visible = .T.
8994:             ENDWITH
8995: 
8996:             loc_oAba.AddObject("cbo_4c_Ang" + loc_cFat, "ComboBox")
8997:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
8998:                 .Top = loc_nTop

*-- Linhas 9008 a 9041:
9008: 
9009:             loc_oAba.AddObject("txt_4c_CodImp" + loc_cFat, "TextBox")
9010:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9011:                 .ControlSource = "crSigCnFNf.impclas" + loc_cFat
9012:                 .Top = loc_nTop
9013:                 .Left = 221
9014:                 .Width = 100
9015:                 .Height = 18
9016:                 .FontName = "Tahoma"
9017:                 .FontSize = 8
9018:                 .SpecialEffect = 1
9019:                 .Format = "K"
9020:                 .InputMask = ""
9021:                 .Visible = .T.
9022:             ENDWITH
9023: 
9024:             loc_oAba.AddObject("chk_4c_Imp" + loc_cFat, "CheckBox")
9025:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9026:                 .ControlSource = "crSigCnFNf.impc" + loc_cFat
9027:                 .Caption = ""
9028:                 .Top = loc_nTop
9029:                 .Left = 329
9030:                 .Width = 19
9031:                 .Height = 16
9032:                 .FontName = "Tahoma"
9033:                 .FontSize = 7
9034:                 .Visible = .T.
9035:                 .Sparse = .F.
9036:                 .Alignment = 0
9037:                 .ReadOnly = .F.
9038:             ENDWITH
9039: 
9040:             loc_nFat = loc_nFat + 1
9041:         ENDFOR

*-- Linhas 9123 a 9141:
9123: 
9124:             loc_oAba.AddObject("txt_4c_ClsLB" + loc_cFatB, "TextBox")
9125:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9126:                 .ControlSource = "crSigCnFN2.lclas" + loc_cFatB
9127:                 .Top = loc_nTopB
9128:                 .Left = 436
9129:                 .Width = 41
9130:                 .Height = 18
9131:                 .FontName = "Tahoma"
9132:                 .FontSize = 8
9133:                 .SpecialEffect = 1
9134:                 .Format = "K"
9135:                 .InputMask = "999.99"
9136:                 .Visible = .T.
9137:             ENDWITH
9138: 
9139:             loc_oAba.AddObject("lbl_4c_ClsXB" + loc_cFatB, "Label")
9140:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9141:                 .Caption = "x"

*-- Linhas 9151 a 9169:
9151: 
9152:             loc_oAba.AddObject("txt_4c_ClsCB" + loc_cFatB, "TextBox")
9153:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9154:                 .ControlSource = "crSigCnFN2.cclas" + loc_cFatB
9155:                 .Top = loc_nTopB
9156:                 .Left = 485
9157:                 .Width = 41
9158:                 .Height = 18
9159:                 .FontName = "Tahoma"
9160:                 .FontSize = 8
9161:                 .SpecialEffect = 1
9162:                 .Format = "K"
9163:                 .InputMask = "999.99"
9164:                 .Visible = .T.
9165:             ENDWITH
9166: 
9167:             loc_oAba.AddObject("cbo_4c_AngB" + loc_cFatB, "ComboBox")
9168:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9169:                 .Top = loc_nTopB

*-- Linhas 9179 a 9213:
9179: 
9180:             loc_oAba.AddObject("txt_4c_CodImpB" + loc_cFatB, "TextBox")
9181:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9182:                 .ControlSource = "crSigCnFN2.impclas" + loc_cFatB
9183:                 .Top = loc_nTopB
9184:                 .Left = 577
9185:                 .Width = 100
9186:                 .Height = 18
9187:                 .FontName = "Tahoma"
9188:                 .FontSize = 8
9189:                 .SpecialEffect = 1
9190:                 .Format = "K"
9191:                 .InputMask = ""
9192:                 .Visible = .T.
9193:             ENDWITH
9194: 
9195:             IF loc_nFatB <= 12
9196:                 loc_oAba.AddObject("chk_4c_ImpB" + loc_cFatB, "CheckBox")
9197:                 WITH loc_oAba.Controls(loc_oAba.ControlCount)
9198:                     .ControlSource = "crSigCnFN2.impc" + loc_cFatB
9199:                     .Caption = ""
9200:                     .Top = loc_nTopB
9201:                     .Left = 687
9202:                     .Width = 19
9203:                     .Height = 16
9204:                     .FontName = "Tahoma"
9205:                     .FontSize = 7
9206:                     .Visible = .T.
9207:                     .Sparse = .F.
9208:                     .Alignment = 0
9209:                     .ReadOnly = .F.
9210:                 ENDWITH
9211:             ENDIF
9212: 
9213:             loc_nFatB = loc_nFatB + 1

*-- Linhas 9229 a 9247:
9229: 
9230:         loc_oAba.AddObject("txt_4c_NoNFL", "TextBox")
9231:         WITH loc_oAba.txt_4c_NoNFL
9232:             .ControlSource = "crSigCnFNf.lnfsai"
9233:             .Top = 213
9234:             .Left = 36
9235:             .Width = 41
9236:             .Height = 18
9237:             .FontName = "Tahoma"
9238:             .FontSize = 8
9239:             .SpecialEffect = 1
9240:             .Format = "K"
9241:             .InputMask = "999.99"
9242:             .Visible = .T.
9243:         ENDWITH
9244: 
9245:         loc_oAba.AddObject("lbl_4c_NoNFX", "Label")
9246:         WITH loc_oAba.lbl_4c_NoNFX
9247:             .Caption = "x"

*-- Linhas 9257 a 9275:
9257: 
9258:         loc_oAba.AddObject("txt_4c_NoNFC", "TextBox")
9259:         WITH loc_oAba.txt_4c_NoNFC
9260:             .ControlSource = "crSigCnFNf.cnfsai"
9261:             .Top = 213
9262:             .Left = 85
9263:             .Width = 41
9264:             .Height = 18
9265:             .FontName = "Tahoma"
9266:             .FontSize = 8
9267:             .SpecialEffect = 1
9268:             .Format = "K"
9269:             .InputMask = "999.99"
9270:             .Visible = .T.
9271:         ENDWITH
9272: 
9273:         *-- Angulo NF (top=202)
9274:         loc_oAba.AddObject("cbo_4c_AngNF", "ComboBox")
9275:         WITH loc_oAba.cbo_4c_AngNF

*-- Linhas 9313 a 9331:
9313: 
9314:         loc_oAba.AddObject("txt_4c_VlNotaRL", "TextBox")
9315:         WITH loc_oAba.txt_4c_VlNotaRL
9316:             .ControlSource = "crSigCnFNf.ltnota"
9317:             .Top = 213
9318:             .Left = 186
9319:             .Width = 41
9320:             .Height = 18
9321:             .FontName = "Tahoma"
9322:             .FontSize = 8
9323:             .SpecialEffect = 1
9324:             .Format = "K"
9325:             .InputMask = "999.99"
9326:             .Visible = .T.
9327:         ENDWITH
9328: 
9329:         loc_oAba.AddObject("lbl_4c_VlNotaRX", "Label")
9330:         WITH loc_oAba.lbl_4c_VlNotaRX
9331:             .Caption = "x"

*-- Linhas 9341 a 9359:
9341: 
9342:         loc_oAba.AddObject("txt_4c_VlNotaRC", "TextBox")
9343:         WITH loc_oAba.txt_4c_VlNotaRC
9344:             .ControlSource = "crSigCnFNf.ctnota"
9345:             .Top = 213
9346:             .Left = 235
9347:             .Width = 41
9348:             .Height = 18
9349:             .FontName = "Tahoma"
9350:             .FontSize = 8
9351:             .SpecialEffect = 1
9352:             .Format = "K"
9353:             .InputMask = "999.99"
9354:             .Visible = .T.
9355:         ENDWITH
9356: 
9357:         loc_oAba.AddObject("cbo_4c_AngVlNota", "ComboBox")
9358:         WITH loc_oAba.cbo_4c_AngVlNota
9359:             .Top = 213

*-- Linhas 9396 a 9414:
9396: 
9397:         loc_oAba.AddObject("txt_4c_NoSeloL", "TextBox")
9398:         WITH loc_oAba.txt_4c_NoSeloL
9399:             .ControlSource = "crSigCnFNf.lcnfselo"
9400:             .Top = 213
9401:             .Left = 343
9402:             .Width = 41
9403:             .Height = 18
9404:             .FontName = "Tahoma"
9405:             .FontSize = 8
9406:             .SpecialEffect = 1
9407:             .Format = "K"
9408:             .InputMask = "999.99"
9409:             .Visible = .T.
9410:         ENDWITH
9411: 
9412:         loc_oAba.AddObject("lbl_4c_NoSeloX", "Label")
9413:         WITH loc_oAba.lbl_4c_NoSeloX
9414:             .Caption = "x"

*-- Linhas 9424 a 9442:
9424: 
9425:         loc_oAba.AddObject("txt_4c_NoSeloC", "TextBox")
9426:         WITH loc_oAba.txt_4c_NoSeloC
9427:             .ControlSource = "crSigCnFNf.lcselo"
9428:             .Top = 213
9429:             .Left = 392
9430:             .Width = 41
9431:             .Height = 18
9432:             .FontName = "Tahoma"
9433:             .FontSize = 8
9434:             .SpecialEffect = 1
9435:             .Format = "K"
9436:             .InputMask = "999.99"
9437:             .Visible = .T.
9438:         ENDWITH
9439: 
9440:         loc_oAba.AddObject("cbo_4c_AngSelo", "ComboBox")
9441:         WITH loc_oAba.cbo_4c_AngSelo
9442:             .Top = 213

*-- Linhas 9479 a 9497:
9479: 
9480:         loc_oAba.AddObject("txt_4c_NFSeloL", "TextBox")
9481:         WITH loc_oAba.txt_4c_NFSeloL
9482:             .ControlSource = "crSigCnFNf.lnfsai"
9483:             .Top = 213
9484:             .Left = 499
9485:             .Width = 41
9486:             .Height = 18
9487:             .FontName = "Tahoma"
9488:             .FontSize = 8
9489:             .SpecialEffect = 1
9490:             .Format = "K"
9491:             .InputMask = "999.99"
9492:             .Visible = .T.
9493:         ENDWITH
9494: 
9495:         loc_oAba.AddObject("lbl_4c_NFSeloX", "Label")
9496:         WITH loc_oAba.lbl_4c_NFSeloX
9497:             .Caption = "x"

*-- Linhas 9507 a 9525:
9507: 
9508:         loc_oAba.AddObject("txt_4c_NFSeloC", "TextBox")
9509:         WITH loc_oAba.txt_4c_NFSeloC
9510:             .ControlSource = "crSigCnFNf.cnfsai"
9511:             .Top = 213
9512:             .Left = 548
9513:             .Width = 41
9514:             .Height = 18
9515:             .FontName = "Tahoma"
9516:             .FontSize = 8
9517:             .SpecialEffect = 1
9518:             .Format = "K"
9519:             .InputMask = "999.99"
9520:             .Visible = .T.
9521:         ENDWITH
9522: 
9523:         loc_oAba.AddObject("cbo_4c_AngNFSelo", "ComboBox")
9524:         WITH loc_oAba.cbo_4c_AngNFSelo
9525:             .Top = 213

*-- Linhas 9571 a 9589:
9571: 
9572:         loc_oAba.AddObject("txt_4c_ObsL", "TextBox")
9573:         WITH loc_oAba.txt_4c_ObsL
9574:             .ControlSource = "crSigCnFNf.tamlinobs"
9575:             .Top = 254
9576:             .Left = 44
9577:             .Width = 41
9578:             .Height = 18
9579:             .FontName = "Tahoma"
9580:             .FontSize = 8
9581:             .SpecialEffect = 1
9582:             .Format = "K"
9583:             .InputMask = "999.99"
9584:             .Visible = .T.
9585:         ENDWITH
9586: 
9587:         loc_oAba.AddObject("lbl_4c_ObsX", "Label")
9588:         WITH loc_oAba.lbl_4c_ObsX
9589:             .Caption = "x"

*-- Linhas 9599 a 9617:
9599: 
9600:         loc_oAba.AddObject("txt_4c_ObsC", "TextBox")
9601:         WITH loc_oAba.txt_4c_ObsC
9602:             .ControlSource = "crSigCnFNf.tamcolobs"
9603:             .Top = 254
9604:             .Left = 93
9605:             .Width = 41
9606:             .Height = 18
9607:             .FontName = "Tahoma"
9608:             .FontSize = 8
9609:             .SpecialEffect = 1
9610:             .Format = "K"
9611:             .InputMask = "999.99"
9612:             .Visible = .T.
9613:         ENDWITH
9614: 
9615:         loc_oAba.AddObject("lbl_4c_LblNoCols2", "Label")
9616:         WITH loc_oAba.lbl_4c_LblNoCols2
9617:             .Caption = "No. Colunas"

*-- Linhas 9627 a 9645:
9627: 
9628:         loc_oAba.AddObject("txt_4c_ObsNoCol", "TextBox")
9629:         WITH loc_oAba.txt_4c_ObsNoCol
9630:             .ControlSource = "crSigCnFNf.nldser"
9631:             .Top = 254
9632:             .Left = 194
9633:             .Width = 41
9634:             .Height = 18
9635:             .FontName = "Tahoma"
9636:             .FontSize = 8
9637:             .SpecialEffect = 1
9638:             .Format = "K"
9639:             .InputMask = "999.99"
9640:             .Visible = .T.
9641:         ENDWITH
9642: 
9643:         loc_oAba.AddObject("lbl_4c_LblNoLins2", "Label")
9644:         WITH loc_oAba.lbl_4c_LblNoLins2
9645:             .Caption = "No. Linhas"

*-- Linhas 9655 a 9673:
9655: 
9656:         loc_oAba.AddObject("txt_4c_ObsNoLin", "TextBox")
9657:         WITH loc_oAba.txt_4c_ObsNoLin
9658:             .ControlSource = "crSigCnFNf.ncdser"
9659:             .Top = 254
9660:             .Left = 256
9661:             .Width = 41
9662:             .Height = 18
9663:             .FontName = "Tahoma"
9664:             .FontSize = 8
9665:             .SpecialEffect = 1
9666:             .Format = "K"
9667:             .InputMask = "999.99"
9668:             .Visible = .T.
9669:         ENDWITH
9670: 
9671:         *-- Angulo obs
9672:         loc_oAba.AddObject("cbo_4c_AngObs", "ComboBox")
9673:         WITH loc_oAba.cbo_4c_AngObs

*-- Linhas 9711 a 9729:
9711: 
9712:         loc_oAba.AddObject("txt_4c_NPedSubL1", "TextBox")
9713:         WITH loc_oAba.txt_4c_NPedSubL1
9714:             .ControlSource = "crSigCnFNf.ldupnum"
9715:             .Top = 254
9716:             .Left = 332
9717:             .Width = 41
9718:             .Height = 18
9719:             .FontName = "Tahoma"
9720:             .FontSize = 8
9721:             .SpecialEffect = 1
9722:             .Format = "K"
9723:             .InputMask = "999.99"
9724:             .Visible = .T.
9725:         ENDWITH
9726: 
9727:         loc_oAba.AddObject("lbl_4c_NPedSubX1", "Label")
9728:         WITH loc_oAba.lbl_4c_NPedSubX1
9729:             .Caption = "x"

*-- Linhas 9739 a 9757:
9739: 
9740:         loc_oAba.AddObject("txt_4c_NPedSubC1", "TextBox")
9741:         WITH loc_oAba.txt_4c_NPedSubC1
9742:             .ControlSource = "crSigCnFNf.cdupnum"
9743:             .Top = 254
9744:             .Left = 381
9745:             .Width = 41
9746:             .Height = 18
9747:             .FontName = "Tahoma"
9748:             .FontSize = 8
9749:             .SpecialEffect = 1
9750:             .Format = "K"
9751:             .InputMask = "999.99"
9752:             .Visible = .T.
9753:         ENDWITH
9754: 
9755:         loc_oAba.AddObject("lbl_4c_LblNPedSub2", "Label")
9756:         WITH loc_oAba.lbl_4c_LblNPedSub2
9757:             .Caption = "N" + CHR(186) + " Pedidos (SubNivel)"

*-- Linhas 9767 a 9785:
9767: 
9768:         loc_oAba.AddObject("txt_4c_NPedSubL2", "TextBox")
9769:         WITH loc_oAba.txt_4c_NPedSubL2
9770:             .ControlSource = "crSigCnFNf.ldupnum"
9771:             .Top = 254
9772:             .Left = 499
9773:             .Width = 41
9774:             .Height = 18
9775:             .FontName = "Tahoma"
9776:             .FontSize = 8
9777:             .SpecialEffect = 1
9778:             .Format = "K"
9779:             .InputMask = "999.99"
9780:             .Visible = .T.
9781:         ENDWITH
9782: 
9783:         loc_oAba.AddObject("lbl_4c_NPedSubX2", "Label")
9784:         WITH loc_oAba.lbl_4c_NPedSubX2
9785:             .Caption = "x"

*-- Linhas 9795 a 9813:
9795: 
9796:         loc_oAba.AddObject("txt_4c_NPedSubC2", "TextBox")
9797:         WITH loc_oAba.txt_4c_NPedSubC2
9798:             .ControlSource = "crSigCnFNf.cdupnum"
9799:             .Top = 254
9800:             .Left = 548
9801:             .Width = 41
9802:             .Height = 18
9803:             .FontName = "Tahoma"
9804:             .FontSize = 8
9805:             .SpecialEffect = 1
9806:             .Format = "K"
9807:             .InputMask = "999.99"
9808:             .Visible = .T.
9809:         ENDWITH
9810: 
9811:         loc_oAba.AddObject("cbo_4c_AngNPed2", "ComboBox")
9812:         WITH loc_oAba.cbo_4c_AngNPed2
9813:             .Top = 254

*-- Linhas 9856 a 9874:
9856: 
9857:         loc_oAba.AddObject("txt_4c_FatDtEmiL", "TextBox")
9858:         WITH loc_oAba.txt_4c_FatDtEmiL
9859:             .ControlSource = "crSigCnFNf.ldtemi"
9860:             .Top = 43
9861:             .Left = 99
9862:             .Width = 41
9863:             .Height = 18
9864:             .FontName = "Tahoma"
9865:             .FontSize = 8
9866:             .SpecialEffect = 1
9867:             .Format = "K"
9868:             .InputMask = "999.99"
9869:             .Visible = .T.
9870:         ENDWITH
9871: 
9872:         loc_oAba.AddObject("lbl_4c_FatDtEmiX", "Label")
9873:         WITH loc_oAba.lbl_4c_FatDtEmiX
9874:             .Caption = "x"

*-- Linhas 9884 a 9902:
9884: 
9885:         loc_oAba.AddObject("txt_4c_FatDtEmiC", "TextBox")
9886:         WITH loc_oAba.txt_4c_FatDtEmiC
9887:             .ControlSource = "crSigCnFNf.cdtemi"
9888:             .Top = 43
9889:             .Left = 148
9890:             .Width = 41
9891:             .Height = 18
9892:             .FontName = "Tahoma"
9893:             .FontSize = 8
9894:             .SpecialEffect = 1
9895:             .Format = "K"
9896:             .InputMask = "999.99"
9897:             .Visible = .T.
9898:         ENDWITH
9899: 
9900:         *-- No NF Fatura (top=31)
9901:         loc_oAba.AddObject("lbl_4c_LblNFatNum", "Label")
9902:         WITH loc_oAba.lbl_4c_LblNFatNum

*-- Linhas 9913 a 9931:
9913: 
9914:         loc_oAba.AddObject("txt_4c_NFatNumL", "TextBox")
9915:         WITH loc_oAba.txt_4c_NFatNumL
9916:             .ControlSource = "crSigCnFNf.lfatnum"
9917:             .Top = 43
9918:             .Left = 231
9919:             .Width = 41
9920:             .Height = 18
9921:             .FontName = "Tahoma"
9922:             .FontSize = 8
9923:             .SpecialEffect = 1
9924:             .Format = "K"
9925:             .InputMask = "999.99"
9926:             .Visible = .T.
9927:         ENDWITH
9928: 
9929:         loc_oAba.AddObject("lbl_4c_NFatNumX", "Label")
9930:         WITH loc_oAba.lbl_4c_NFatNumX
9931:             .Caption = "x"

*-- Linhas 9941 a 9959:
9941: 
9942:         loc_oAba.AddObject("txt_4c_NFatNumC", "TextBox")
9943:         WITH loc_oAba.txt_4c_NFatNumC
9944:             .ControlSource = "crSigCnFNf.cfatnum"
9945:             .Top = 43
9946:             .Left = 280
9947:             .Width = 41
9948:             .Height = 18
9949:             .FontName = "Tahoma"
9950:             .FontSize = 8
9951:             .SpecialEffect = 1
9952:             .Format = "K"
9953:             .InputMask = "999.99"
9954:             .Visible = .T.
9955:         ENDWITH
9956: 
9957:         *-- Data de Saida (top=67)
9958:         loc_oAba.AddObject("lbl_4c_LblFatDtSai", "Label")
9959:         WITH loc_oAba.lbl_4c_LblFatDtSai

*-- Linhas 9970 a 9988:
9970: 
9971:         loc_oAba.AddObject("txt_4c_FatDtSaiL", "TextBox")
9972:         WITH loc_oAba.txt_4c_FatDtSaiL
9973:             .ControlSource = "crSigCnFNf.ldtsaidas"
9974:             .Top = 79
9975:             .Left = 98
9976:             .Width = 41
9977:             .Height = 18
9978:             .FontName = "Tahoma"
9979:             .FontSize = 8
9980:             .SpecialEffect = 1
9981:             .Format = "K"
9982:             .InputMask = "999.99"
9983:             .Visible = .T.
9984:         ENDWITH
9985: 
9986:         loc_oAba.AddObject("lbl_4c_FatDtSaiX", "Label")
9987:         WITH loc_oAba.lbl_4c_FatDtSaiX
9988:             .Caption = "x"

*-- Linhas 9998 a 10016:
9998: 
9999:         loc_oAba.AddObject("txt_4c_FatDtSaiC", "TextBox")
10000:         WITH loc_oAba.txt_4c_FatDtSaiC
10001:             .ControlSource = "crSigCnFNf.cdtsaidas"
10002:             .Top = 79
10003:             .Left = 147
10004:             .Width = 41
10005:             .Height = 18
10006:             .FontName = "Tahoma"
10007:             .FontSize = 8
10008:             .SpecialEffect = 1
10009:             .Format = "K"
10010:             .InputMask = "999.99"
10011:             .Visible = .T.
10012:         ENDWITH
10013: 
10014:         *-- Numero Duplicata (top=67)
10015:         loc_oAba.AddObject("lbl_4c_LblDuplNum", "Label")
10016:         WITH loc_oAba.lbl_4c_LblDuplNum

*-- Linhas 10027 a 10045:
10027: 
10028:         loc_oAba.AddObject("txt_4c_DuplNumL", "TextBox")
10029:         WITH loc_oAba.txt_4c_DuplNumL
10030:             .ControlSource = "crSigCnFNf.ldupnum"
10031:             .Top = 79
10032:             .Left = 231
10033:             .Width = 41
10034:             .Height = 18
10035:             .FontName = "Tahoma"
10036:             .FontSize = 8
10037:             .SpecialEffect = 1
10038:             .Format = "K"
10039:             .InputMask = "999.99"
10040:             .Visible = .T.
10041:         ENDWITH
10042: 
10043:         loc_oAba.AddObject("lbl_4c_DuplNumX", "Label")
10044:         WITH loc_oAba.lbl_4c_DuplNumX
10045:             .Caption = "x"

*-- Linhas 10055 a 10073:
10055: 
10056:         loc_oAba.AddObject("txt_4c_DuplNumC", "TextBox")
10057:         WITH loc_oAba.txt_4c_DuplNumC
10058:             .ControlSource = "crSigCnFNf.cdupnum"
10059:             .Top = 79
10060:             .Left = 280
10061:             .Width = 41
10062:             .Height = 18
10063:             .FontName = "Tahoma"
10064:             .FontSize = 8
10065:             .SpecialEffect = 1
10066:             .Format = "K"
10067:             .InputMask = "999.99"
10068:             .Visible = .T.
10069:         ENDWITH
10070: 
10071:         *-- Valor Total da Nota (top=103)
10072:         loc_oAba.AddObject("lbl_4c_LblFatVlNota", "Label")
10073:         WITH loc_oAba.lbl_4c_LblFatVlNota

*-- Linhas 10084 a 10102:
10084: 
10085:         loc_oAba.AddObject("txt_4c_FatVlNotaL", "TextBox")
10086:         WITH loc_oAba.txt_4c_FatVlNotaL
10087:             .ControlSource = "crSigCnFNf.ltnota"
10088:             .Top = 115
10089:             .Left = 99
10090:             .Width = 41
10091:             .Height = 18
10092:             .FontName = "Tahoma"
10093:             .FontSize = 8
10094:             .SpecialEffect = 1
10095:             .Format = "K"
10096:             .InputMask = "999.99"
10097:             .Visible = .T.
10098:         ENDWITH
10099: 
10100:         loc_oAba.AddObject("lbl_4c_FatVlNotaX", "Label")
10101:         WITH loc_oAba.lbl_4c_FatVlNotaX
10102:             .Caption = "x"

*-- Linhas 10112 a 10130:
10112: 
10113:         loc_oAba.AddObject("txt_4c_FatVlNotaC", "TextBox")
10114:         WITH loc_oAba.txt_4c_FatVlNotaC
10115:             .ControlSource = "crSigCnFNf.ctnota"
10116:             .Top = 115
10117:             .Left = 148
10118:             .Width = 41
10119:             .Height = 18
10120:             .FontName = "Tahoma"
10121:             .FontSize = 8
10122:             .SpecialEffect = 1
10123:             .Format = "K"
10124:             .InputMask = "999.99"
10125:             .Visible = .T.
10126:         ENDWITH
10127: 
10128:         *-- Valor por Extenso (top=103)
10129:         loc_oAba.AddObject("lbl_4c_LblValExt", "Label")
10130:         WITH loc_oAba.lbl_4c_LblValExt

*-- Linhas 10141 a 10159:
10141: 
10142:         loc_oAba.AddObject("txt_4c_ValExtL", "TextBox")
10143:         WITH loc_oAba.txt_4c_ValExtL
10144:             .ControlSource = "crSigCnFNf.lvalext"
10145:             .Top = 115
10146:             .Left = 231
10147:             .Width = 41
10148:             .Height = 18
10149:             .FontName = "Tahoma"
10150:             .FontSize = 8
10151:             .SpecialEffect = 1
10152:             .Format = "K"
10153:             .InputMask = "999.99"
10154:             .Visible = .T.
10155:         ENDWITH
10156: 
10157:         loc_oAba.AddObject("lbl_4c_ValExtX", "Label")
10158:         WITH loc_oAba.lbl_4c_ValExtX
10159:             .Caption = "x"

*-- Linhas 10169 a 10187:
10169: 
10170:         loc_oAba.AddObject("txt_4c_ValExtC", "TextBox")
10171:         WITH loc_oAba.txt_4c_ValExtC
10172:             .ControlSource = "crSigCnFNf.cvalext"
10173:             .Top = 115
10174:             .Left = 280
10175:             .Width = 41
10176:             .Height = 18
10177:             .FontName = "Tahoma"
10178:             .FontSize = 8
10179:             .SpecialEffect = 1
10180:             .Format = "K"
10181:             .InputMask = "999.99"
10182:             .Visible = .T.
10183:         ENDWITH
10184: 
10185:         *-- Vencimento (top=138)
10186:         loc_oAba.AddObject("lbl_4c_LblFatVecto", "Label")
10187:         WITH loc_oAba.lbl_4c_LblFatVecto

*-- Linhas 10198 a 10216:
10198: 
10199:         loc_oAba.AddObject("txt_4c_FatVectoL", "TextBox")
10200:         WITH loc_oAba.txt_4c_FatVectoL
10201:             .ControlSource = "crSigCnFNf.lfatvec"
10202:             .Top = 150
10203:             .Left = 99
10204:             .Width = 41
10205:             .Height = 18
10206:             .FontName = "Tahoma"
10207:             .FontSize = 8
10208:             .SpecialEffect = 1
10209:             .Format = "K"
10210:             .InputMask = "999.99"
10211:             .Visible = .T.
10212:         ENDWITH
10213: 
10214:         loc_oAba.AddObject("lbl_4c_FatVectoX", "Label")
10215:         WITH loc_oAba.lbl_4c_FatVectoX
10216:             .Caption = "x"

*-- Linhas 10226 a 10244:
10226: 
10227:         loc_oAba.AddObject("txt_4c_FatVectoC", "TextBox")
10228:         WITH loc_oAba.txt_4c_FatVectoC
10229:             .ControlSource = "crSigCnFNf.cfatvec"
10230:             .Top = 150
10231:             .Left = 148
10232:             .Width = 41
10233:             .Height = 18
10234:             .FontName = "Tahoma"
10235:             .FontSize = 8
10236:             .SpecialEffect = 1
10237:             .Format = "K"
10238:             .InputMask = "999.99"
10239:             .Visible = .T.
10240:         ENDWITH
10241:     ENDPROC
10242: 
10243:     *--------------------------------------------------------------------------
10244:     PROTECTED PROCEDURE ConfigurarServicosTab()

*-- Linhas 10261 a 10279:
10261: 
10262:         loc_oAba.AddObject("txt_4c_SrvDescL", "TextBox")
10263:         WITH loc_oAba.txt_4c_SrvDescL
10264:             .ControlSource = "crSigCnFNf.ldescser"
10265:             .Top = 43
10266:             .Left = 107
10267:             .Width = 41
10268:             .Height = 18
10269:             .FontName = "Tahoma"
10270:             .FontSize = 8
10271:             .SpecialEffect = 1
10272:             .Format = "K"
10273:             .InputMask = "999.99"
10274:             .Visible = .T.
10275:         ENDWITH
10276: 
10277:         loc_oAba.AddObject("lbl_4c_SrvDescX", "Label")
10278:         WITH loc_oAba.lbl_4c_SrvDescX
10279:             .Caption = "x"

*-- Linhas 10289 a 10307:
10289: 
10290:         loc_oAba.AddObject("txt_4c_SrvDescC", "TextBox")
10291:         WITH loc_oAba.txt_4c_SrvDescC
10292:             .ControlSource = "crSigCnFNf.cdescser"
10293:             .Top = 43
10294:             .Left = 156
10295:             .Width = 41
10296:             .Height = 18
10297:             .FontName = "Tahoma"
10298:             .FontSize = 8
10299:             .SpecialEffect = 1
10300:             .Format = "K"
10301:             .InputMask = "999.99"
10302:             .Visible = .T.
10303:         ENDWITH
10304: 
10305:         *-- No. Colunas (top=31)
10306:         loc_oAba.AddObject("lbl_4c_LblSrvNoCols", "Label")
10307:         WITH loc_oAba.lbl_4c_LblSrvNoCols

*-- Linhas 10318 a 10336:
10318: 
10319:         loc_oAba.AddObject("txt_4c_SrvNoCols", "TextBox")
10320:         WITH loc_oAba.txt_4c_SrvNoCols
10321:             .ControlSource = "crSigCnFNf.nldser"
10322:             .Top = 43
10323:             .Left = 214
10324:             .Width = 41
10325:             .Height = 18
10326:             .FontName = "Tahoma"
10327:             .FontSize = 8
10328:             .SpecialEffect = 1
10329:             .Format = "K"
10330:             .InputMask = "999.99"
10331:             .Visible = .T.
10332:         ENDWITH
10333: 
10334:         *-- No. Linhas (top=31)
10335:         loc_oAba.AddObject("lbl_4c_LblSrvNoLins", "Label")
10336:         WITH loc_oAba.lbl_4c_LblSrvNoLins

*-- Linhas 10347 a 10365:
10347: 
10348:         loc_oAba.AddObject("txt_4c_SrvNoLins", "TextBox")
10349:         WITH loc_oAba.txt_4c_SrvNoLins
10350:             .ControlSource = "crSigCnFNf.ncdser"
10351:             .Top = 43
10352:             .Left = 273
10353:             .Width = 41
10354:             .Height = 18
10355:             .FontName = "Tahoma"
10356:             .FontSize = 8
10357:             .SpecialEffect = 1
10358:             .Format = "K"
10359:             .InputMask = "999.99"
10360:             .Visible = .T.
10361:         ENDWITH
10362: 
10363:         *-- Valor I.S.S (top=81)
10364:         loc_oAba.AddObject("lbl_4c_LblValISS", "Label")
10365:         WITH loc_oAba.lbl_4c_LblValISS

*-- Linhas 10376 a 10394:
10376: 
10377:         loc_oAba.AddObject("txt_4c_ValISSL", "TextBox")
10378:         WITH loc_oAba.txt_4c_ValISSL
10379:             .ControlSource = "crSigCnFNf.lvaliss"
10380:             .Top = 93
10381:             .Left = 107
10382:             .Width = 41
10383:             .Height = 18
10384:             .FontName = "Tahoma"
10385:             .FontSize = 8
10386:             .SpecialEffect = 1
10387:             .Format = "K"
10388:             .InputMask = "999.99"
10389:             .Visible = .T.
10390:         ENDWITH
10391: 
10392:         loc_oAba.AddObject("lbl_4c_ValISSX", "Label")
10393:         WITH loc_oAba.lbl_4c_ValISSX
10394:             .Caption = "x"

*-- Linhas 10404 a 10422:
10404: 
10405:         loc_oAba.AddObject("txt_4c_ValISSC", "TextBox")
10406:         WITH loc_oAba.txt_4c_ValISSC
10407:             .ControlSource = "crSigCnFNf.cvaliss"
10408:             .Top = 93
10409:             .Left = 156
10410:             .Width = 41
10411:             .Height = 18
10412:             .FontName = "Tahoma"
10413:             .FontSize = 8
10414:             .SpecialEffect = 1
10415:             .Format = "K"
10416:             .InputMask = "999.99"
10417:             .Visible = .T.
10418:         ENDWITH
10419: 
10420:         *-- Valor Total Servicos (top=113)
10421:         loc_oAba.AddObject("lbl_4c_LblValSrv", "Label")
10422:         WITH loc_oAba.lbl_4c_LblValSrv

*-- Linhas 10433 a 10451:
10433: 
10434:         loc_oAba.AddObject("txt_4c_ValSrvL", "TextBox")
10435:         WITH loc_oAba.txt_4c_ValSrvL
10436:             .ControlSource = "crSigCnFNf.lvalser"
10437:             .Top = 125
10438:             .Left = 107
10439:             .Width = 41
10440:             .Height = 18
10441:             .FontName = "Tahoma"
10442:             .FontSize = 8
10443:             .SpecialEffect = 1
10444:             .Format = "K"
10445:             .InputMask = "999.99"
10446:             .Visible = .T.
10447:         ENDWITH
10448: 
10449:         loc_oAba.AddObject("lbl_4c_ValSrvX", "Label")
10450:         WITH loc_oAba.lbl_4c_ValSrvX
10451:             .Caption = "x"

*-- Linhas 10461 a 10479:
10461: 
10462:         loc_oAba.AddObject("txt_4c_ValSrvC", "TextBox")
10463:         WITH loc_oAba.txt_4c_ValSrvC
10464:             .ControlSource = "crSigCnFNf.cvalser"
10465:             .Top = 125
10466:             .Left = 156
10467:             .Width = 41
10468:             .Height = 18
10469:             .FontName = "Tahoma"
10470:             .FontSize = 8
10471:             .SpecialEffect = 1
10472:             .Format = "K"
10473:             .InputMask = "999.99"
10474:             .Visible = .T.
10475:         ENDWITH
10476:     ENDPROC
10477: 
10478:     *--------------------------------------------------------------------------
10479:     PROTECTED PROCEDURE ConfigurarOutrosTab()

*-- Linhas 10519 a 10537:
10519: 
10520:         loc_oAba.AddObject("txt_4c_EspPad", "TextBox")
10521:         WITH loc_oAba.txt_4c_EspPad
10522:             .ControlSource = "crSigCnFNf.esppads"
10523:             .Top = 65
10524:             .Left = 243
10525:             .Width = 92
10526:             .Height = 18
10527:             .FontName = "Tahoma"
10528:             .FontSize = 8
10529:             .SpecialEffect = 1
10530:             .Format = "K"
10531:             .InputMask = ""
10532:             .Visible = .T.
10533:         ENDWITH
10534: 
10535:         *-- Marca Padrao (top=42)
10536:         loc_oAba.AddObject("lbl_4c_LblMarPad", "Label")
10537:         WITH loc_oAba.lbl_4c_LblMarPad

*-- Linhas 10548 a 10566:
10548: 
10549:         loc_oAba.AddObject("txt_4c_MarPad", "TextBox")
10550:         WITH loc_oAba.txt_4c_MarPad
10551:             .ControlSource = "crSigCnFNf.marpads"
10552:             .Top = 40
10553:             .Left = 243
10554:             .Width = 92
10555:             .Height = 18
10556:             .FontName = "Tahoma"
10557:             .FontSize = 8
10558:             .SpecialEffect = 1
10559:             .Format = "K"
10560:             .InputMask = ""
10561:             .Visible = .T.
10562:         ENDWITH
10563: 
10564:         *-- Fator de Peso Bruto (top=93)
10565:         loc_oAba.AddObject("lbl_4c_LblFatPBru", "Label")
10566:         WITH loc_oAba.lbl_4c_LblFatPBru

*-- Linhas 10577 a 10595:
10577: 
10578:         loc_oAba.AddObject("txt_4c_FatPBru", "TextBox")
10579:         WITH loc_oAba.txt_4c_FatPBru
10580:             .ControlSource = "crSigCnFNf.fatbrutos"
10581:             .Top = 91
10582:             .Left = 243
10583:             .Width = 58
10584:             .Height = 18
10585:             .FontName = "Tahoma"
10586:             .FontSize = 8
10587:             .SpecialEffect = 1
10588:             .Format = "K"
10589:             .InputMask = "999.99"
10590:             .Visible = .T.
10591:         ENDWITH
10592: 
10593:         *-- Peso por Volume (top=117)
10594:         loc_oAba.AddObject("lbl_4c_LblPesVol", "Label")
10595:         WITH loc_oAba.lbl_4c_LblPesVol

*-- Linhas 10606 a 10624:
10606: 
10607:         loc_oAba.AddObject("txt_4c_PesVol", "TextBox")
10608:         WITH loc_oAba.txt_4c_PesVol
10609:             .ControlSource = "crSigCnFNf.pesovols"
10610:             .Top = 115
10611:             .Left = 243
10612:             .Width = 66
10613:             .Height = 18
10614:             .FontName = "Tahoma"
10615:             .FontSize = 8
10616:             .SpecialEffect = 1
10617:             .Format = "K"
10618:             .InputMask = "999.99"
10619:             .Visible = .T.
10620:         ENDWITH
10621: 
10622:         loc_oAba.AddObject("lbl_4c_LblGrs", "Label")
10623:         WITH loc_oAba.lbl_4c_LblGrs
10624:             .Caption = "( grs )"

*-- Linhas 10648 a 10682:
10648: 
10649:         loc_oAba.AddObject("txt_4c_EmpPad", "TextBox")
10650:         WITH loc_oAba.txt_4c_EmpPad
10651:             .ControlSource = "crSigCnFNf.emps"
10652:             .Top = 140
10653:             .Left = 243
10654:             .Width = 31
10655:             .Height = 18
10656:             .FontName = "Tahoma"
10657:             .FontSize = 8
10658:             .SpecialEffect = 1
10659:             .Format = "K"
10660:             .InputMask = ""
10661:             .Visible = .T.
10662:         ENDWITH
10663: 
10664:         *-- Validar Sequencia de Notas (top=162)
10665:         loc_oAba.AddObject("chk_4c_ValidSeqNota", "CheckBox")
10666:         WITH loc_oAba.chk_4c_ValidSeqNota
10667:             .ControlSource = "crSigCnFNf.vseqnota"
10668:             .Caption = "Validar Sequ" + CHR(234) + "ncia de Notas :"
10669:             .Top = 162
10670:             .Left = 88
10671:             .Width = 155
10672:             .Height = 15
10673:             .FontName = "Tahoma"
10674:             .FontSize = 7
10675:             .Visible = .T.
10676:             .Sparse = .F.
10677:             .Alignment = 0
10678:             .ReadOnly = .F.
10679:         ENDWITH
10680: 
10681:         *-- Dados da Operacao - Localizacao (top=53, left=405)
10682:         loc_oAba.AddObject("lbl_4c_LblLoc", "Label")

*-- Linhas 10694 a 10712:
10694: 
10695:         loc_oAba.AddObject("txt_4c_LocL", "TextBox")
10696:         WITH loc_oAba.txt_4c_LocL
10697:             .ControlSource = "crSigCnFNf.loploc"
10698:             .Top = 65
10699:             .Left = 405
10700:             .Width = 41
10701:             .Height = 18
10702:             .FontName = "Tahoma"
10703:             .FontSize = 8
10704:             .SpecialEffect = 1
10705:             .Format = "K"
10706:             .InputMask = "999.99"
10707:             .Visible = .T.
10708:         ENDWITH
10709: 
10710:         loc_oAba.AddObject("lbl_4c_LocX", "Label")
10711:         WITH loc_oAba.lbl_4c_LocX
10712:             .Caption = "x"

*-- Linhas 10722 a 10740:
10722: 
10723:         loc_oAba.AddObject("txt_4c_LocC", "TextBox")
10724:         WITH loc_oAba.txt_4c_LocC
10725:             .ControlSource = "crSigCnFNf.coploc"
10726:             .Top = 65
10727:             .Left = 454
10728:             .Width = 41
10729:             .Height = 18
10730:             .FontName = "Tahoma"
10731:             .FontSize = 8
10732:             .SpecialEffect = 1
10733:             .Format = "K"
10734:             .InputMask = "999.99"
10735:             .Visible = .T.
10736:         ENDWITH
10737: 
10738:         *-- Vendedor (top=85, left=405)
10739:         loc_oAba.AddObject("lbl_4c_LblVend", "Label")
10740:         WITH loc_oAba.lbl_4c_LblVend

*-- Linhas 10751 a 10769:
10751: 
10752:         loc_oAba.AddObject("txt_4c_VendL", "TextBox")
10753:         WITH loc_oAba.txt_4c_VendL
10754:             .ControlSource = "crSigCnFNf.lopnvd"
10755:             .Top = 97
10756:             .Left = 405
10757:             .Width = 41
10758:             .Height = 18
10759:             .FontName = "Tahoma"
10760:             .FontSize = 8
10761:             .SpecialEffect = 1
10762:             .Format = "K"
10763:             .InputMask = "999.99"
10764:             .Visible = .T.
10765:         ENDWITH
10766: 
10767:         loc_oAba.AddObject("lbl_4c_VendX", "Label")
10768:         WITH loc_oAba.lbl_4c_VendX
10769:             .Caption = "x"

*-- Linhas 10779 a 10797:
10779: 
10780:         loc_oAba.AddObject("txt_4c_VendC", "TextBox")
10781:         WITH loc_oAba.txt_4c_VendC
10782:             .ControlSource = "crSigCnFNf.copnvd"
10783:             .Top = 97
10784:             .Left = 454
10785:             .Width = 41
10786:             .Height = 18
10787:             .FontName = "Tahoma"
10788:             .FontSize = 8
10789:             .SpecialEffect = 1
10790:             .Format = "K"
10791:             .InputMask = "999.99"
10792:             .Visible = .T.
10793:         ENDWITH
10794: 
10795:         *-- Nome do Vendedor (top=85, left=507)
10796:         loc_oAba.AddObject("lbl_4c_LblNomeVend", "Label")
10797:         WITH loc_oAba.lbl_4c_LblNomeVend

*-- Linhas 10808 a 10826:
10808: 
10809:         loc_oAba.AddObject("txt_4c_NomeVendL", "TextBox")
10810:         WITH loc_oAba.txt_4c_NomeVendL
10811:             .ControlSource = "crSigCnFNf.lopcvd"
10812:             .Top = 97
10813:             .Left = 507
10814:             .Width = 41
10815:             .Height = 18
10816:             .FontName = "Tahoma"
10817:             .FontSize = 8
10818:             .SpecialEffect = 1
10819:             .Format = "K"
10820:             .InputMask = "999.99"
10821:             .Visible = .T.
10822:         ENDWITH
10823: 
10824:         loc_oAba.AddObject("lbl_4c_NomeVendX", "Label")
10825:         WITH loc_oAba.lbl_4c_NomeVendX
10826:             .Caption = "x"

*-- Linhas 10836 a 10854:
10836: 
10837:         loc_oAba.AddObject("txt_4c_NomeVendC", "TextBox")
10838:         WITH loc_oAba.txt_4c_NomeVendC
10839:             .ControlSource = "crSigCnFNf.copcvd"
10840:             .Top = 97
10841:             .Left = 556
10842:             .Width = 41
10843:             .Height = 18
10844:             .FontName = "Tahoma"
10845:             .FontSize = 8
10846:             .SpecialEffect = 1
10847:             .Format = "K"
10848:             .InputMask = "999.99"
10849:             .Visible = .T.
10850:         ENDWITH
10851: 
10852:         *-- Responsavel (top=117, left=405)
10853:         loc_oAba.AddObject("lbl_4c_LblResp", "Label")
10854:         WITH loc_oAba.lbl_4c_LblResp

*-- Linhas 10865 a 10883:
10865: 
10866:         loc_oAba.AddObject("txt_4c_RespL", "TextBox")
10867:         WITH loc_oAba.txt_4c_RespL
10868:             .ControlSource = "crSigCnFNf.lopnrp"
10869:             .Top = 129
10870:             .Left = 405
10871:             .Width = 41
10872:             .Height = 18
10873:             .FontName = "Tahoma"
10874:             .FontSize = 8
10875:             .SpecialEffect = 1
10876:             .Format = "K"
10877:             .InputMask = "999.99"
10878:             .Visible = .T.
10879:         ENDWITH
10880: 
10881:         loc_oAba.AddObject("lbl_4c_RespX", "Label")
10882:         WITH loc_oAba.lbl_4c_RespX
10883:             .Caption = "x"

*-- Linhas 10893 a 10911:
10893: 
10894:         loc_oAba.AddObject("txt_4c_RespC", "TextBox")
10895:         WITH loc_oAba.txt_4c_RespC
10896:             .ControlSource = "crSigCnFNf.copnrp"
10897:             .Top = 129
10898:             .Left = 454
10899:             .Width = 41
10900:             .Height = 18
10901:             .FontName = "Tahoma"
10902:             .FontSize = 8
10903:             .SpecialEffect = 1
10904:             .Format = "K"
10905:             .InputMask = "999.99"
10906:             .Visible = .T.
10907:         ENDWITH
10908: 
10909:         *-- Nome do Responsavel (top=117, left=507)
10910:         loc_oAba.AddObject("lbl_4c_LblNomeResp", "Label")
10911:         WITH loc_oAba.lbl_4c_LblNomeResp

*-- Linhas 10922 a 10940:
10922: 
10923:         loc_oAba.AddObject("txt_4c_NomeRespL", "TextBox")
10924:         WITH loc_oAba.txt_4c_NomeRespL
10925:             .ControlSource = "crSigCnFNf.lopcvd"
10926:             .Top = 129
10927:             .Left = 507
10928:             .Width = 41
10929:             .Height = 18
10930:             .FontName = "Tahoma"
10931:             .FontSize = 8
10932:             .SpecialEffect = 1
10933:             .Format = "K"
10934:             .InputMask = "999.99"
10935:             .Visible = .T.
10936:         ENDWITH
10937: 
10938:         loc_oAba.AddObject("lbl_4c_NomeRespX", "Label")
10939:         WITH loc_oAba.lbl_4c_NomeRespX
10940:             .Caption = "x"

*-- Linhas 10950 a 10968:
10950: 
10951:         loc_oAba.AddObject("txt_4c_NomeRespC", "TextBox")
10952:         WITH loc_oAba.txt_4c_NomeRespC
10953:             .ControlSource = "crSigCnFNf.copcvd"
10954:             .Top = 129
10955:             .Left = 556
10956:             .Width = 41
10957:             .Height = 18
10958:             .FontName = "Tahoma"
10959:             .FontSize = 8
10960:             .SpecialEffect = 1
10961:             .Format = "K"
10962:             .InputMask = "999.99"
10963:             .Visible = .T.
10964:         ENDWITH
10965: 
10966:         *-- N Vias (top=184)
10967:         loc_oAba.AddObject("lbl_4c_LblNVias", "Label")
10968:         WITH loc_oAba.lbl_4c_LblNVias

*-- Linhas 10979 a 10997:
10979: 
10980:         loc_oAba.AddObject("txt_4c_NVias", "TextBox")
10981:         WITH loc_oAba.txt_4c_NVias
10982:             .ControlSource = "crSigCnFNf.tipos"
10983:             .Top = 184
10984:             .Left = 243
10985:             .Width = 31
10986:             .Height = 18
10987:             .FontName = "Tahoma"
10988:             .FontSize = 8
10989:             .SpecialEffect = 1
10990:             .Format = "K"
10991:             .InputMask = ""
10992:             .Visible = .T.
10993:         ENDWITH
10994: 
10995:         *-- Fator Proporcao Linha (top=205)
10996:         loc_oAba.AddObject("lbl_4c_LblFatPropLin", "Label")
10997:         WITH loc_oAba.lbl_4c_LblFatPropLin

*-- Linhas 11008 a 11026:
11008: 
11009:         loc_oAba.AddObject("txt_4c_FatPropLin", "TextBox")
11010:         WITH loc_oAba.txt_4c_FatPropLin
11011:             .ControlSource = "crSigCnFNf.tamanhos"
11012:             .Top = 203
11013:             .Left = 243
11014:             .Width = 66
11015:             .Height = 18
11016:             .FontName = "Tahoma"
11017:             .FontSize = 8
11018:             .SpecialEffect = 1
11019:             .Format = "K"
11020:             .InputMask = "999.99"
11021:             .Visible = .T.
11022:         ENDWITH
11023:     ENDPROC
11024: 
11025: 
11026: 

