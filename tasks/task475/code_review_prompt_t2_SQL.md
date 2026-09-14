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

### FORM (C:\4c\projeto\app\forms\cadastros\FormNfl.prg) - TRECHOS RELEVANTES PARA PASS SQL (11097 linhas total):

*-- Linhas 45 a 81:
45:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
46:                 THIS.ConfigurarPaginaLista()
47: 
48:                 *-- Criar cursores para ControlSource dos controles das 10 abas
49:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
50:                     IF !USED("crSigCnFNf")
51:                         IF SQLEXEC(gnConnHandle, "SELECT TOP 0 * FROM SigCnFNf", "crSigCnFNf") > 0
52:                             APPEND BLANK IN crSigCnFNf
53:                         ENDIF
54:                     ENDIF
55:                     IF !USED("crSigCnFN2")
56:                         IF SQLEXEC(gnConnHandle, "SELECT TOP 0 * FROM SigCnFN2", "crSigCnFN2") > 0
57:                             APPEND BLANK IN crSigCnFN2
58:                         ENDIF
59:                     ENDIF
60:                 ELSE
61:                     IF !USED("crSigCnFNf")
62:                         CREATE CURSOR crSigCnFNf (cidchaves c(20), emps c(3), series c(3))
63:                         APPEND BLANK IN crSigCnFNf
64:                     ENDIF
65:                     IF !USED("crSigCnFN2")
66:                         CREATE CURSOR crSigCnFN2 (cidchaves c(20), emps c(3), series c(3))
67:                         APPEND BLANK IN crSigCnFN2
68:                     ENDIF
69:                 ENDIF
70: 
71:                 THIS.ConfigurarPaginaDados()
72:                 THIS.TornarControlesVisiveis(THIS)
73: 
74:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
75:                     THIS.CarregarLista()
76:                 ENDIF
77: 
78:                 THIS.pgf_4c_Paginas.Visible = .T.
79:                 THIS.pgf_4c_Paginas.ActivePage = 1
80:                 THIS.this_cModoAtual = "LISTA"
81:                 THIS.AjustarBotoesPorModo("LISTA")

*-- Linhas 283 a 322:
283:             .ReadOnly     = .T.
284:             .GridLines    = 2
285:             .RecordMark   = .F.
286:             .DeleteMark   = .F.
287:             .Visible      = .T.
288:             WITH .Column1
289:                 .ControlSource   = "cursor_4c_Dados.emps"
290:                 .Width           = 55
291:                 .ReadOnly        = .T.
292:                 .Header1.Caption = "Empr."
293:             ENDWITH
294:             WITH .Column2
295:                 .ControlSource   = "cursor_4c_Dados.Razas"
296:                 .Width           = 220
297:                 .ReadOnly        = .T.
298:                 .Header1.Caption = "Empresa"
299:             ENDWITH
300:             WITH .Column3
301:                 .ControlSource   = "cursor_4c_Dados.series"
302:                 .Width           = 55
303:                 .ReadOnly        = .T.
304:                 .Header1.Caption = "S" + CHR(233) + "rie"
305:             ENDWITH
306:             WITH .Column4
307:                 .ControlSource   = "cursor_4c_Dados.cidchaves"
308:                 .Width           = 641
309:                 .ReadOnly        = .T.
310:                 .Header1.Caption = "Chave"
311:             ENDWITH
312:         ENDWITH
313:         THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
314: 
315:         *-- Container cntcopia (flutuante, inicialmente oculto)
316:         *-- Top=244+29=273 compensado; Left=257 como no legado
317:         loc_oPagina.AddObject("cnt_4c_copia", "Container")
318:         WITH loc_oPagina.cnt_4c_copia
319:             .Top         = 273
320:             .Left        = 257
321:             .Width       = 484
322:             .Height      = 116

*-- Linhas 692 a 713:
692:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
693:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 4
694:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
695:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.emps"
696:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.Razas"
697:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.series"
698:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.ControlSource = "cursor_4c_Dados.cidchaves"
699:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "Empr."
700:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.Header1.Caption = "Empresa"
701:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.Header1.Caption = "S" + CHR(233) + "rie"
702:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.Header1.Caption = "Chave"
703:                     ENDIF
704:                 ENDIF
705:             ENDIF
706:         CATCH TO loc_oErro
707:             MsgErro(loc_oErro.Message, "FormNfl.CarregarLista")
708:         ENDTRY
709: 
710:         RETURN loc_lResultado
711:     ENDPROC
712: 
713:     *--------------------------------------------------------------------------

*-- Linhas 975 a 993:
975:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
976:                 MsgAviso("Nenhum registro selecionado.", "FormNfl")
977:             ELSE
978:                 SELECT cursor_4c_Dados
979:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
980:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
981:                     THIS.BOParaForm()
982:                     THIS.this_cModoAtual = "VISUALIZAR"
983:                     THIS.HabilitarCampos(.F.)
984:                     THIS.AjustarBotoesPorModo("VISUALIZAR")
985:                     THIS.AlternarPagina(2)
986:                     THIS.this_cModoAtual = "VISUALIZAR"
987:                     loc_lResultado = .T.
988:                 ENDIF
989:             ENDIF
990:         CATCH TO loc_oErro
991:             MsgErro(loc_oErro.Message, "FormNfl.BtnVisualizarClick")
992:         ENDTRY
993:         RETURN loc_lResultado

*-- Linhas 1001 a 1019:
1001:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1002:                 MsgAviso("Nenhum registro selecionado.", "FormNfl")
1003:             ELSE
1004:                 SELECT cursor_4c_Dados
1005:                 loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)
1006:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1007:                     THIS.this_oBusinessObject.EditarRegistro()
1008:                     THIS.BOParaForm()
1009:                     THIS.this_cModoAtual = "ALTERAR"
1010:                     THIS.HabilitarCampos(.T.)
1011:                     THIS.AjustarBotoesPorModo("ALTERAR")
1012:                     THIS.AlternarPagina(2)
1013:                     THIS.this_cModoAtual = "ALTERAR"
1014:                     loc_lResultado = .T.
1015:                 ENDIF
1016:             ENDIF
1017:         CATCH TO loc_oErro
1018:             MsgErro(loc_oErro.Message, "FormNfl.BtnAlterarClick")
1019:         ENDTRY

*-- Linhas 1028 a 1046:
1028:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1029:                 MsgAviso("Nenhum registro selecionado.", "FormNfl")
1030:             ELSE
1031:                 SELECT cursor_4c_Dados
1032:                 loc_cChave    = ALLTRIM(cursor_4c_Dados.cidchaves)
1033:                 loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o da configura" + CHR(231) + CHR(227) + "o selecionada?", "FormNfl")
1034:                 IF loc_lConfirma
1035:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1036:                         loc_lResultado = THIS.this_oBusinessObject.Excluir()
1037:                         IF loc_lResultado
1038:                             THIS.CarregarLista()
1039:                         ENDIF
1040:                     ENDIF
1041:                 ENDIF
1042:             ENDIF
1043:         CATCH TO loc_oErro
1044:             MsgErro(loc_oErro.Message, "FormNfl.BtnExcluirClick")
1045:         ENDTRY
1046:         RETURN loc_lResultado

*-- Linhas 1056 a 1077:
1056:             IF loc_lResultado AND PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
1057:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 4
1058:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
1059:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.emps"
1060:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.Razas"
1061:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.series"
1062:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.ControlSource = "cursor_4c_Dados.cidchaves"
1063:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "Empr."
1064:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.Header1.Caption = "Empresa"
1065:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.Header1.Caption = "S" + CHR(233) + "rie"
1066:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.Header1.Caption = "Chave"
1067:             ENDIF
1068:         CATCH TO loc_oErro
1069:             MsgErro(loc_oErro.Message, "FormNfl.BtnBuscarClick")
1070:         ENDTRY
1071:         RETURN loc_lResultado
1072:     ENDPROC
1073: 
1074:     *--------------------------------------------------------------------------
1075:     PROCEDURE BtnEncerrarClick()
1076:         THIS.Release()
1077:     ENDPROC

*-- Linhas 1192 a 1210:
1192:         ENDWITH
1193:         loc_oAba.AddObject("txt_4c_Text1", "TextBox")
1194:         WITH loc_oAba.txt_4c_Text1
1195:             .ControlSource = "crSigCnFNf.l1nf"
1196:             .Top           = 46
1197:             .Left          = 41
1198:             .Width         = 41
1199:             .Height        = 18
1200:             .FontName      = "Tahoma"
1201:             .FontSize      = 8
1202:             .Format        = "K"
1203:             .InputMask     = "999.99"
1204:             .SpecialEffect = 1
1205:             .Margin        = 0
1206:             .Visible       = .T.
1207:         ENDWITH
1208:         loc_oAba.AddObject("lbl_4c_Label2", "Label")
1209:         WITH loc_oAba.lbl_4c_Label2
1210:             .Caption   = "x"

*-- Linhas 1220 a 1238:
1220:         ENDWITH
1221:         loc_oAba.AddObject("txt_4c_Text2", "TextBox")
1222:         WITH loc_oAba.txt_4c_Text2
1223:             .ControlSource = "crSigCnFNf.c1nf"
1224:             .Top           = 46
1225:             .Left          = 90
1226:             .Width         = 41
1227:             .Height        = 18
1228:             .FontName      = "Tahoma"
1229:             .FontSize      = 8
1230:             .Format        = "K"
1231:             .InputMask     = "999.99"
1232:             .SpecialEffect = 1
1233:             .Margin        = 0
1234:             .Visible       = .T.
1235:         ENDWITH
1236: 
1237:         *-- NF Saida (lnfsai x cnfsai)
1238:         loc_oAba.AddObject("lbl_4c_Label3", "Label")

*-- Linhas 1250 a 1268:
1250:         ENDWITH
1251:         loc_oAba.AddObject("txt_4c_Text3", "TextBox")
1252:         WITH loc_oAba.txt_4c_Text3
1253:             .ControlSource = "crSigCnFNf.lnfsai"
1254:             .Top           = 78
1255:             .Left          = 41
1256:             .Width         = 41
1257:             .Height        = 18
1258:             .FontName      = "Tahoma"
1259:             .FontSize      = 8
1260:             .Format        = "K"
1261:             .InputMask     = "999.99"
1262:             .SpecialEffect = 1
1263:             .Margin        = 0
1264:             .Visible       = .T.
1265:         ENDWITH
1266:         loc_oAba.AddObject("lbl_4c_Label4", "Label")
1267:         WITH loc_oAba.lbl_4c_Label4
1268:             .Caption   = "x"

*-- Linhas 1278 a 1296:
1278:         ENDWITH
1279:         loc_oAba.AddObject("txt_4c_Text4", "TextBox")
1280:         WITH loc_oAba.txt_4c_Text4
1281:             .ControlSource = "crSigCnFNf.cnfsai"
1282:             .Top           = 78
1283:             .Left          = 90
1284:             .Width         = 41
1285:             .Height        = 18
1286:             .FontName      = "Tahoma"
1287:             .FontSize      = 8
1288:             .Format        = "K"
1289:             .InputMask     = "999.99"
1290:             .SpecialEffect = 1
1291:             .Margin        = 0
1292:             .Visible       = .T.
1293:         ENDWITH
1294: 
1295:         *-- NF Entrada (lnfent x cnfent)
1296:         loc_oAba.AddObject("lbl_4c_Label5", "Label")

*-- Linhas 1308 a 1326:
1308:         ENDWITH
1309:         loc_oAba.AddObject("txt_4c_Text5", "TextBox")
1310:         WITH loc_oAba.txt_4c_Text5
1311:             .ControlSource = "crSigCnFNf.lnfent"
1312:             .Top           = 110
1313:             .Left          = 41
1314:             .Width         = 41
1315:             .Height        = 18
1316:             .FontName      = "Tahoma"
1317:             .FontSize      = 8
1318:             .Format        = "K"
1319:             .InputMask     = "999.99"
1320:             .SpecialEffect = 1
1321:             .Margin        = 0
1322:             .Visible       = .T.
1323:         ENDWITH
1324:         loc_oAba.AddObject("lbl_4c_Label6", "Label")
1325:         WITH loc_oAba.lbl_4c_Label6
1326:             .Caption   = "x"

*-- Linhas 1336 a 1354:
1336:         ENDWITH
1337:         loc_oAba.AddObject("txt_4c_Text6", "TextBox")
1338:         WITH loc_oAba.txt_4c_Text6
1339:             .ControlSource = "crSigCnFNf.cnfent"
1340:             .Top           = 110
1341:             .Left          = 90
1342:             .Width         = 41
1343:             .Height        = 18
1344:             .FontName      = "Tahoma"
1345:             .FontSize      = 8
1346:             .Format        = "K"
1347:             .InputMask     = "999.99"
1348:             .SpecialEffect = 1
1349:             .Margin        = 0
1350:             .Visible       = .T.
1351:         ENDWITH
1352: 
1353:         *-- Nat. Operacao (lnatop x cnatop)
1354:         loc_oAba.AddObject("lbl_4c_Label7", "Label")

*-- Linhas 1366 a 1384:
1366:         ENDWITH
1367:         loc_oAba.AddObject("txt_4c_Text7", "TextBox")
1368:         WITH loc_oAba.txt_4c_Text7
1369:             .ControlSource = "crSigCnFNf.lnatop"
1370:             .Top           = 142
1371:             .Left          = 41
1372:             .Width         = 41
1373:             .Height        = 18
1374:             .FontName      = "Tahoma"
1375:             .FontSize      = 8
1376:             .Format        = "K"
1377:             .InputMask     = "999.99"
1378:             .SpecialEffect = 1
1379:             .Margin        = 0
1380:             .Visible       = .T.
1381:         ENDWITH
1382:         loc_oAba.AddObject("lbl_4c_Label8", "Label")
1383:         WITH loc_oAba.lbl_4c_Label8
1384:             .Caption   = "x"

*-- Linhas 1394 a 1412:
1394:         ENDWITH
1395:         loc_oAba.AddObject("txt_4c_Text8", "TextBox")
1396:         WITH loc_oAba.txt_4c_Text8
1397:             .ControlSource = "crSigCnFNf.cnatop"
1398:             .Top           = 142
1399:             .Left          = 90
1400:             .Width         = 41
1401:             .Height        = 18
1402:             .FontName      = "Tahoma"
1403:             .FontSize      = 8
1404:             .Format        = "K"
1405:             .InputMask     = "999.99"
1406:             .SpecialEffect = 1
1407:             .Margin        = 0
1408:             .Visible       = .T.
1409:         ENDWITH
1410: 
1411:         *-- CFOP (lcfop x ccfop)
1412:         loc_oAba.AddObject("lbl_4c_Label9", "Label")

*-- Linhas 1424 a 1442:
1424:         ENDWITH
1425:         loc_oAba.AddObject("txt_4c_Text9", "TextBox")
1426:         WITH loc_oAba.txt_4c_Text9
1427:             .ControlSource = "crSigCnFNf.lcfop"
1428:             .Top           = 174
1429:             .Left          = 41
1430:             .Width         = 41
1431:             .Height        = 18
1432:             .FontName      = "Tahoma"
1433:             .FontSize      = 8
1434:             .Format        = "K"
1435:             .InputMask     = "999.99"
1436:             .SpecialEffect = 1
1437:             .Margin        = 0
1438:             .Visible       = .T.
1439:         ENDWITH
1440:         loc_oAba.AddObject("lbl_4c_Label10", "Label")
1441:         WITH loc_oAba.lbl_4c_Label10
1442:             .Caption   = "x"

*-- Linhas 1452 a 1484:
1452:         ENDWITH
1453:         loc_oAba.AddObject("txt_4c_Text10", "TextBox")
1454:         WITH loc_oAba.txt_4c_Text10
1455:             .ControlSource = "crSigCnFNf.ccfop"
1456:             .Top           = 174
1457:             .Left          = 90
1458:             .Width         = 41
1459:             .Height        = 18
1460:             .FontName      = "Tahoma"
1461:             .FontSize      = 8
1462:             .Format        = "K"
1463:             .InputMask     = "999.99"
1464:             .SpecialEffect = 1
1465:             .Margin        = 0
1466:             .Visible       = .T.
1467:         ENDWITH
1468: 
1469:         *-- Razao Social (LRAZEMP x CRAZEMP, sem ControlSource)
1470:         loc_oAba.AddObject("lbl_4c_Label11", "Label")
1471:         WITH loc_oAba.lbl_4c_Label11
1472:             .Caption   = "Raz" + CHR(227) + "o Social"
1473:             .Top       = 193
1474:             .Left      = 41
1475:             .Width     = 54
1476:             .Height    = 13
1477:             .FontName  = "Tahoma"
1478:             .FontSize  = 7
1479:             .BackStyle = 0
1480:             .ForeColor = RGB(90, 90, 90)
1481:             .Visible   = .T.
1482:         ENDWITH
1483:         loc_oAba.AddObject("txt_4c_LRAZEMP", "TextBox")
1484:         WITH loc_oAba.txt_4c_LRAZEMP

*-- Linhas 1522 a 1540:
1522:             .Visible       = .T.
1523:         ENDWITH
1524: 
1525:         *-- Endereco (LENDEMP x CENDEMP, sem ControlSource)
1526:         loc_oAba.AddObject("lbl_4c_Label16", "Label")
1527:         WITH loc_oAba.lbl_4c_Label16
1528:             .Caption   = "Endere" + CHR(231) + "o"
1529:             .Top       = 226
1530:             .Left      = 43
1531:             .Width     = 40
1532:             .Height    = 13
1533:             .FontName  = "Tahoma"
1534:             .FontSize  = 7
1535:             .BackStyle = 0
1536:             .ForeColor = RGB(90, 90, 90)
1537:             .Visible   = .T.
1538:         ENDWITH
1539:         loc_oAba.AddObject("txt_4c_LENDEMP", "TextBox")
1540:         WITH loc_oAba.txt_4c_LENDEMP

*-- Linhas 1596 a 1614:
1596:         ENDWITH
1597:         loc_oAba.AddObject("txt_4c_Text12", "TextBox")
1598:         WITH loc_oAba.txt_4c_Text12
1599:             .ControlSource = "crSigCnFN2.lxinc"
1600:             .Top           = 46
1601:             .Left          = 165
1602:             .Width         = 41
1603:             .Height        = 18
1604:             .FontName      = "Tahoma"
1605:             .FontSize      = 8
1606:             .Format        = "K"
1607:             .InputMask     = "999.99"
1608:             .SpecialEffect = 1
1609:             .Margin        = 0
1610:             .Visible       = .T.
1611:         ENDWITH
1612:         loc_oAba.AddObject("lbl_4c_Label20", "Label")
1613:         WITH loc_oAba.lbl_4c_Label20
1614:             .Caption   = "x"

*-- Linhas 1624 a 1642:
1624:         ENDWITH
1625:         loc_oAba.AddObject("txt_4c_Text16", "TextBox")
1626:         WITH loc_oAba.txt_4c_Text16
1627:             .ControlSource = "crSigCnFN2.cxinc"
1628:             .Top           = 46
1629:             .Left          = 214
1630:             .Width         = 41
1631:             .Height        = 18
1632:             .FontName      = "Tahoma"
1633:             .FontSize      = 8
1634:             .Format        = "K"
1635:             .InputMask     = "999.99"
1636:             .SpecialEffect = 1
1637:             .Margin        = 0
1638:             .Visible       = .T.
1639:         ENDWITH
1640:         loc_oAba.AddObject("lbl_4c_Label21", "Label")
1641:         WITH loc_oAba.lbl_4c_Label21
1642:             .Caption   = "x"

*-- Linhas 1652 a 1670:
1652:         ENDWITH
1653:         loc_oAba.AddObject("txt_4c_Text17", "TextBox")
1654:         WITH loc_oAba.txt_4c_Text17
1655:             .ControlSource = "crSigCnFN2.lenxinc"
1656:             .Top           = 46
1657:             .Left          = 261
1658:             .Width         = 41
1659:             .Height        = 18
1660:             .FontName      = "Tahoma"
1661:             .FontSize      = 8
1662:             .Format        = "K"
1663:             .InputMask     = "99999"
1664:             .SpecialEffect = 1
1665:             .Margin        = 0
1666:             .Visible       = .T.
1667:         ENDWITH
1668: 
1669:         *-- SAC (lsac x csac + contsac)
1670:         loc_oAba.AddObject("lbl_4c_Label22", "Label")

*-- Linhas 1682 a 1700:
1682:         ENDWITH
1683:         loc_oAba.AddObject("txt_4c_Text18", "TextBox")
1684:         WITH loc_oAba.txt_4c_Text18
1685:             .ControlSource = "crSigCnFN2.lsac"
1686:             .Top           = 78
1687:             .Left          = 164
1688:             .Width         = 41
1689:             .Height        = 18
1690:             .FontName      = "Tahoma"
1691:             .FontSize      = 8
1692:             .Format        = "K"
1693:             .InputMask     = "999.99"
1694:             .SpecialEffect = 1
1695:             .Margin        = 0
1696:             .Visible       = .T.
1697:         ENDWITH
1698:         loc_oAba.AddObject("lbl_4c_Label23", "Label")
1699:         WITH loc_oAba.lbl_4c_Label23
1700:             .Caption   = "x"

*-- Linhas 1710 a 1743:
1710:         ENDWITH
1711:         loc_oAba.AddObject("txt_4c_Text19", "TextBox")
1712:         WITH loc_oAba.txt_4c_Text19
1713:             .ControlSource = "crSigCnFN2.csac"
1714:             .Top           = 78
1715:             .Left          = 213
1716:             .Width         = 41
1717:             .Height        = 18
1718:             .FontName      = "Tahoma"
1719:             .FontSize      = 8
1720:             .Format        = "K"
1721:             .InputMask     = "999.99"
1722:             .SpecialEffect = 1
1723:             .Margin        = 0
1724:             .Visible       = .T.
1725:         ENDWITH
1726:         loc_oAba.AddObject("txt_4c_Text20", "TextBox")
1727:         WITH loc_oAba.txt_4c_Text20
1728:             .ControlSource = "crSigCnFN2.contsac"
1729:             .Top           = 97
1730:             .Left          = 164
1731:             .Width         = 137
1732:             .Height        = 18
1733:             .MaxLength     = 20
1734:             .FontName      = "Tahoma"
1735:             .FontSize      = 8
1736:             .Format        = "K"
1737:             .SpecialEffect = 1
1738:             .Margin        = 0
1739:             .Visible       = .T.
1740:         ENDWITH
1741: 
1742:         *-- Nat. Operacao Substituicao Tributaria (lnatopsub x cnatopsub)
1743:         loc_oAba.AddObject("lbl_4c_Label24", "Label")

*-- Linhas 1755 a 1773:
1755:         ENDWITH
1756:         loc_oAba.AddObject("txt_4c_Text21", "TextBox")
1757:         WITH loc_oAba.txt_4c_Text21
1758:             .ControlSource = "crSigCnFN2.lnatopsub"
1759:             .Top           = 142
1760:             .Left          = 164
1761:             .Width         = 41
1762:             .Height        = 18
1763:             .FontName      = "Tahoma"
1764:             .FontSize      = 8
1765:             .Format        = "K"
1766:             .InputMask     = "999.99"
1767:             .SpecialEffect = 1
1768:             .Margin        = 0
1769:             .Visible       = .T.
1770:         ENDWITH
1771:         loc_oAba.AddObject("lbl_4c_Label25", "Label")
1772:         WITH loc_oAba.lbl_4c_Label25
1773:             .Caption   = "x"

*-- Linhas 1783 a 1801:
1783:         ENDWITH
1784:         loc_oAba.AddObject("txt_4c_Text22", "TextBox")
1785:         WITH loc_oAba.txt_4c_Text22
1786:             .ControlSource = "crSigCnFN2.cnatopsub"
1787:             .Top           = 142
1788:             .Left          = 213
1789:             .Width         = 41
1790:             .Height        = 18
1791:             .FontName      = "Tahoma"
1792:             .FontSize      = 8
1793:             .Format        = "K"
1794:             .InputMask     = "999.99"
1795:             .SpecialEffect = 1
1796:             .Margin        = 0
1797:             .Visible       = .T.
1798:         ENDWITH
1799: 
1800:         *-- CFOP Substituicao Tributaria (lcfopsub x ccfopsub)
1801:         loc_oAba.AddObject("lbl_4c_Label26", "Label")

*-- Linhas 1813 a 1831:
1813:         ENDWITH
1814:         loc_oAba.AddObject("txt_4c_Text23", "TextBox")
1815:         WITH loc_oAba.txt_4c_Text23
1816:             .ControlSource = "crSigCnFN2.lcfopsub"
1817:             .Top           = 174
1818:             .Left          = 164
1819:             .Width         = 41
1820:             .Height        = 18
1821:             .FontName      = "Tahoma"
1822:             .FontSize      = 8
1823:             .Format        = "K"
1824:             .InputMask     = "999.99"
1825:             .SpecialEffect = 1
1826:             .Margin        = 0
1827:             .Visible       = .T.
1828:         ENDWITH
1829:         loc_oAba.AddObject("lbl_4c_Label27", "Label")
1830:         WITH loc_oAba.lbl_4c_Label27
1831:             .Caption   = "x"

*-- Linhas 1841 a 1859:
1841:         ENDWITH
1842:         loc_oAba.AddObject("txt_4c_Text24", "TextBox")
1843:         WITH loc_oAba.txt_4c_Text24
1844:             .ControlSource = "crSigCnFN2.ccfopsub"
1845:             .Top           = 174
1846:             .Left          = 213
1847:             .Width         = 41
1848:             .Height        = 18
1849:             .FontName      = "Tahoma"
1850:             .FontSize      = 8
1851:             .Format        = "K"
1852:             .InputMask     = "999.99"
1853:             .SpecialEffect = 1
1854:             .Margin        = 0
1855:             .Visible       = .T.
1856:         ENDWITH
1857: 
1858:         *===== Coluna direita: impressora (dentro do Shape1) =====
1859: 

*-- Linhas 1873 a 1904:
1873:         ENDWITH
1874:         loc_oAba.AddObject("txt_4c_Text13", "TextBox")
1875:         WITH loc_oAba.txt_4c_Text13
1876:             .ControlSource = "crSigCnFNf.imppads"
1877:             .Top           = 61
1878:             .Left          = 393
1879:             .Width         = 240
1880:             .Height        = 18
1881:             .FontName      = "Tahoma"
1882:             .FontSize      = 8
1883:             .Format        = "K"
1884:             .SpecialEffect = 1
1885:             .Margin        = 0
1886:             .Visible       = .T.
1887:         ENDWITH
1888: 
1889:         *-- Fonte Padrao + Tamanho (sem ControlSource; Text14 abre dialogo fonte)
1890:         loc_oAba.AddObject("lbl_4c_Label14", "Label")
1891:         WITH loc_oAba.lbl_4c_Label14
1892:             .Caption   = "Fonte Padr" + CHR(227) + "o"
1893:             .Top       = 81
1894:             .Left      = 393
1895:             .Width     = 58
1896:             .Height    = 13
1897:             .FontName  = "Tahoma"
1898:             .FontSize  = 7
1899:             .BackStyle = 0
1900:             .ForeColor = RGB(90, 90, 90)
1901:             .Visible   = .T.
1902:         ENDWITH
1903:         loc_oAba.AddObject("txt_4c_Text14", "TextBox")
1904:         WITH loc_oAba.txt_4c_Text14

*-- Linhas 1928 a 1960:
1928:         ENDWITH
1929:         loc_oAba.AddObject("txt_4c_Text15", "TextBox")
1930:         WITH loc_oAba.txt_4c_Text15
1931:             .ControlSource = "crSigCnFNf.tamanhos"
1932:             .Top           = 93
1933:             .Left          = 592
1934:             .Width         = 41
1935:             .Height        = 18
1936:             .FontName      = "Tahoma"
1937:             .FontSize      = 8
1938:             .Format        = "K"
1939:             .InputMask     = "999"
1940:             .SpecialEffect = 1
1941:             .Margin        = 0
1942:             .Visible       = .T.
1943:         ENDWITH
1944: 
1945:         *-- Tamanho da Folha (Text11, sem ControlSource; abre dialogo)
1946:         loc_oAba.AddObject("lbl_4c_Label18", "Label")
1947:         WITH loc_oAba.lbl_4c_Label18
1948:             .Caption   = "Tamanho da Folha"
1949:             .Top       = 114
1950:             .Left      = 394
1951:             .Width     = 80
1952:             .Height    = 13
1953:             .FontName  = "Tahoma"
1954:             .FontSize  = 7
1955:             .BackStyle = 0
1956:             .ForeColor = RGB(90, 90, 90)
1957:             .Visible   = .T.
1958:         ENDWITH
1959:         loc_oAba.AddObject("txt_4c_Text11", "TextBox")
1960:         WITH loc_oAba.txt_4c_Text11

*-- Linhas 1974 a 1992:
1974:         *-- optTpMargem (Sem Margem / Com Margem)
1975:         loc_oAba.AddObject("obj_4c_OptTpMargem", "OptionGroup")
1976:         WITH loc_oAba.obj_4c_OptTpMargem
1977:             .ControlSource = "crSigCnFN2.ntpmargems"
1978:             .Top           = 149
1979:             .Left          = 389
1980:             .Width         = 202
1981:             .Height        = 27
1982:             .BackStyle     = 0
1983:             .BorderStyle   = 0
1984:             .Value         = 1
1985:             .Visible       = .T.
1986:             WITH .Buttons(1)
1987:                 .Caption   = "Sem Margem"
1988:                 .Left      = 5
1989:                 .Top       = 5
1990:                 .AutoSize  = .T.
1991:                 .BackStyle = 0
1992:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 2050 a 2069:
2050:             IF EMPTY(loc_cVal) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
2051:                 loc_lResultado = .T.
2052:             ELSE
2053:                 loc_nRes = SQLEXEC(gnConnHandle, ;
2054:                     "SELECT cods FROM SigCdSer WHERE cods = " + EscaparSQL(loc_cVal), ;
2055:                     "cursor_4c_ValidSer")
2056:                 IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_ValidSer") = 0
2057:                     THIS.AbrirLookupSeries()
2058:                 ELSE
2059:                     THIS.this_cUltimoSeriesValidado = loc_cVal
2060:                 ENDIF
2061:                 IF USED("cursor_4c_ValidSer")
2062:                     USE IN cursor_4c_ValidSer
2063:                 ENDIF
2064:             ENDIF
2065:         CATCH TO loc_oErro
2066:             MsgErro(loc_oErro.Message, "FormNfl.SeriesDadosValid")
2067:         ENDTRY
2068:         RETURN loc_lResultado
2069:     ENDPROC

*-- Linhas 2090 a 2132:
2090:             ENDIF
2091:             loc_cVal = ALLTRIM(loc_oCtrl.Value)
2092:             IF !EMPTY(loc_cVal)
2093:                 loc_cSQL = "SELECT cods, descs FROM SigCdSer WHERE UPPER(cods) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY cods"
2094:             ELSE
2095:                 loc_cSQL = "SELECT cods, descs FROM SigCdSer ORDER BY cods"
2096:             ENDIF
2097:             SET NULL ON
2098:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaSer")
2099:             IF !USED("cursor_4c_BuscaSer") OR RECCOUNT("cursor_4c_BuscaSer") = 0
2100:                 IF USED("cursor_4c_BuscaSer")
2101:                     USE IN cursor_4c_BuscaSer
2102:                 ENDIF
2103:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdSer ORDER BY cods", "cursor_4c_BuscaSer")
2104:             ENDIF
2105:             IF !USED("cursor_4c_BuscaSer")
2106:                 CREATE CURSOR cursor_4c_BuscaSer (cods c(3), descs c(50))
2107:             ENDIF
2108:             SET NULL OFF
2109:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2110:             IF VARTYPE(loc_oBusca) = "O"
2111:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaSer"
2112:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaSer", "cods", "descs", "S" + CHR(233) + "ries")
2113:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
2114:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2115:                 loc_oBusca.Mostrar()
2116:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSer")
2117:                     SELECT cursor_4c_BuscaSer
2118:                     loc_oCtrl.Value = ALLTRIM(cods)
2119:                 ENDIF
2120:             ENDIF
2121:             IF USED("cursor_4c_BuscaSer")
2122:                 USE IN cursor_4c_BuscaSer
2123:             ENDIF
2124:         CATCH TO loc_oErro
2125:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupSeries")
2126:         ENDTRY
2127:     ENDPROC
2128: 
2129:     *--------------------------------------------------------------------------
2130:     PROCEDURE NomedestKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2131:         IF par_nKeyCode = 28
2132:             THIS.AbrirLookupNomedest()

*-- Linhas 2145 a 2187:
2145:             loc_oCtrl = THIS.pgf_4c_Paginas.Page1.cnt_4c_copia.txt_4c_nomedest
2146:             loc_cVal  = ALLTRIM(loc_oCtrl.Value)
2147:             IF !EMPTY(loc_cVal)
2148:                 loc_cSQL = "SELECT cods, descs FROM SigCdSer WHERE UPPER(cods) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY cods"
2149:             ELSE
2150:                 loc_cSQL = "SELECT cods, descs FROM SigCdSer ORDER BY cods"
2151:             ENDIF
2152:             SET NULL ON
2153:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaSerCp")
2154:             IF !USED("cursor_4c_BuscaSerCp") OR RECCOUNT("cursor_4c_BuscaSerCp") = 0
2155:                 IF USED("cursor_4c_BuscaSerCp")
2156:                     USE IN cursor_4c_BuscaSerCp
2157:                 ENDIF
2158:                 SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdSer ORDER BY cods", "cursor_4c_BuscaSerCp")
2159:             ENDIF
2160:             IF !USED("cursor_4c_BuscaSerCp")
2161:                 CREATE CURSOR cursor_4c_BuscaSerCp (cods c(3), descs c(50))
2162:             ENDIF
2163:             SET NULL OFF
2164:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2165:             IF VARTYPE(loc_oBusca) = "O"
2166:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaSerCp"
2167:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaSerCp", "cods", "descs", "S" + CHR(233) + "rie Destino")
2168:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
2169:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2170:                 loc_oBusca.Mostrar()
2171:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSerCp")
2172:                     SELECT cursor_4c_BuscaSerCp
2173:                     loc_oCtrl.Value = ALLTRIM(cods)
2174:                 ENDIF
2175:             ENDIF
2176:             IF USED("cursor_4c_BuscaSerCp")
2177:                 USE IN cursor_4c_BuscaSerCp
2178:             ENDIF
2179:         CATCH TO loc_oErro
2180:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupNomedest")
2181:         ENDTRY
2182:     ENDPROC
2183: 
2184:     *--------------------------------------------------------------------------
2185:     PROCEDURE EmpDestKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2186:         IF par_nKeyCode = 28
2187:             THIS.AbrirLookupEmpDest()

*-- Linhas 2200 a 2242:
2200:             loc_oCtrl = THIS.pgf_4c_Paginas.Page1.cnt_4c_copia.txt_4c_empDest
2201:             loc_cVal  = ALLTRIM(loc_oCtrl.Value)
2202:             IF !EMPTY(loc_cVal)
2203:                 loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp WHERE UPPER(CEmps) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY CEmps"
2204:             ELSE
2205:                 loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps"
2206:             ENDIF
2207:             SET NULL ON
2208:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpDest")
2209:             IF !USED("cursor_4c_BuscaEmpDest") OR RECCOUNT("cursor_4c_BuscaEmpDest") = 0
2210:                 IF USED("cursor_4c_BuscaEmpDest")
2211:                     USE IN cursor_4c_BuscaEmpDest
2212:                 ENDIF
2213:                 SQLEXEC(gnConnHandle, "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps", "cursor_4c_BuscaEmpDest")
2214:             ENDIF
2215:             IF !USED("cursor_4c_BuscaEmpDest")
2216:                 CREATE CURSOR cursor_4c_BuscaEmpDest (CEmps c(2), Razas c(60))
2217:             ENDIF
2218:             SET NULL OFF
2219:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2220:             IF VARTYPE(loc_oBusca) = "O"
2221:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpDest"
2222:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaEmpDest", "CEmps", "Razas", "Empresa Destino")
2223:                 loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
2224:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
2225:                 loc_oBusca.Mostrar()
2226:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpDest")
2227:                     SELECT cursor_4c_BuscaEmpDest
2228:                     loc_oCtrl.Value = ALLTRIM(CEmps)
2229:                 ENDIF
2230:             ENDIF
2231:             IF USED("cursor_4c_BuscaEmpDest")
2232:                 USE IN cursor_4c_BuscaEmpDest
2233:             ENDIF
2234:         CATCH TO loc_oErro
2235:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupEmpDest")
2236:         ENDTRY
2237:     ENDPROC
2238: 
2239:     *--------------------------------------------------------------------------
2240:     PROCEDURE EmpPadKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2241:         IF par_nKeyCode = 28
2242:             THIS.AbrirLookupEmpPad()

*-- Linhas 2257 a 2276:
2257:             IF EMPTY(loc_cVal) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
2258:                 loc_lResultado = .T.
2259:             ENDIF
2260:             loc_nRes = SQLEXEC(gnConnHandle, ;
2261:                 "SELECT CEmps FROM SigCdEmp WHERE CEmps = " + EscaparSQL(loc_cVal), ;
2262:                 "cursor_4c_ValidEmpPad")
2263:             IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_ValidEmpPad") = 0
2264:                 THIS.AbrirLookupEmpPad()
2265:             ENDIF
2266:             IF USED("cursor_4c_ValidEmpPad")
2267:                 USE IN cursor_4c_ValidEmpPad
2268:             ENDIF
2269:         CATCH TO loc_oErro
2270:             MsgErro(loc_oErro.Message, "FormNfl.EmpPadValid")
2271:         ENDTRY
2272:         RETURN loc_lResultado
2273:     ENDPROC
2274: 
2275:     *--------------------------------------------------------------------------
2276:     PROTECTED PROCEDURE AbrirLookupEmpPad()

*-- Linhas 2282 a 2324:
2282:             ENDIF
2283:             loc_cVal = ALLTRIM(loc_oCtrl.Value)
2284:             IF !EMPTY(loc_cVal)
2285:                 loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp WHERE UPPER(CEmps) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY CEmps"
2286:             ELSE
2287:                 loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps"
2288:             ENDIF
2289:             SET NULL ON
2290:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmpPad")
2291:             IF !USED("cursor_4c_BuscaEmpPad") OR RECCOUNT("cursor_4c_BuscaEmpPad") = 0
2292:                 IF USED("cursor_4c_BuscaEmpPad")
2293:                     USE IN cursor_4c_BuscaEmpPad
2294:                 ENDIF
2295:                 SQLEXEC(gnConnHandle, "SELECT CEmps, Razas FROM SigCdEmp ORDER BY CEmps", "cursor_4c_BuscaEmpPad")
2296:             ENDIF
2297:             IF !USED("cursor_4c_BuscaEmpPad")
2298:                 CREATE CURSOR cursor_4c_BuscaEmpPad (CEmps c(2), Razas c(60))
2299:             ENDIF
2300:             SET NULL OFF
2301:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2302:             IF VARTYPE(loc_oBusca) = "O"
2303:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaEmpPad"
2304:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaEmpPad", "CEmps", "Razas", "Empresa Padr" + CHR(227) + "o")
2305:                 loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
2306:                 loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
2307:                 loc_oBusca.Mostrar()
2308:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpPad")
2309:                     SELECT cursor_4c_BuscaEmpPad
2310:                     loc_oCtrl.Value = ALLTRIM(CEmps)
2311:                 ENDIF
2312:             ENDIF
2313:             IF USED("cursor_4c_BuscaEmpPad")
2314:                 USE IN cursor_4c_BuscaEmpPad
2315:             ENDIF
2316:         CATCH TO loc_oErro
2317:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupEmpPad")
2318:         ENDTRY
2319:     ENDPROC
2320: 
2321:     *--------------------------------------------------------------------------
2322:     PROCEDURE UnPesosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2323:         IF par_nKeyCode = 28
2324:             THIS.AbrirLookupUnPesos()

*-- Linhas 2339 a 2358:
2339:             IF EMPTY(loc_cVal) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
2340:                 loc_lResultado = .T.
2341:             ENDIF
2342:             loc_nRes = SQLEXEC(gnConnHandle, ;
2343:                 "SELECT CUnis FROM SigCdUni WHERE CUnis = " + EscaparSQL(loc_cVal), ;
2344:                 "cursor_4c_ValidUni")
2345:             IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_ValidUni") = 0
2346:                 THIS.AbrirLookupUnPesos()
2347:             ENDIF
2348:             IF USED("cursor_4c_ValidUni")
2349:                 USE IN cursor_4c_ValidUni
2350:             ENDIF
2351:         CATCH TO loc_oErro
2352:             MsgErro(loc_oErro.Message, "FormNfl.UnPesosValid")
2353:         ENDTRY
2354:         RETURN loc_lResultado
2355:     ENDPROC
2356: 
2357:     *--------------------------------------------------------------------------
2358:     PROTECTED PROCEDURE AbrirLookupUnPesos()

*-- Linhas 2364 a 2476:
2364:             ENDIF
2365:             loc_cVal = ALLTRIM(loc_oCtrl.Value)
2366:             IF !EMPTY(loc_cVal)
2367:                 loc_cSQL = "SELECT CUnis, DUnis FROM SigCdUni WHERE UPPER(CUnis) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY CUnis"
2368:             ELSE
2369:                 loc_cSQL = "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis"
2370:             ENDIF
2371:             SET NULL ON
2372:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUni")
2373:             IF !USED("cursor_4c_BuscaUni") OR RECCOUNT("cursor_4c_BuscaUni") = 0
2374:                 IF USED("cursor_4c_BuscaUni")
2375:                     USE IN cursor_4c_BuscaUni
2376:                 ENDIF
2377:                 SQLEXEC(gnConnHandle, "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", "cursor_4c_BuscaUni")
2378:             ENDIF
2379:             IF !USED("cursor_4c_BuscaUni")
2380:                 CREATE CURSOR cursor_4c_BuscaUni (CUnis c(6), DUnis c(30))
2381:             ENDIF
2382:             SET NULL OFF
2383:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2384:             IF VARTYPE(loc_oBusca) = "O"
2385:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaUni"
2386:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaUni", "CUnis", "DUnis", "Unidades de Medida")
2387:                 loc_oBusca.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
2388:                 loc_oBusca.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
2389:                 loc_oBusca.Mostrar()
2390:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUni")
2391:                     SELECT cursor_4c_BuscaUni
2392:                     loc_oCtrl.Value = ALLTRIM(CUnis)
2393:                 ENDIF
2394:             ENDIF
2395:             IF USED("cursor_4c_BuscaUni")
2396:                 USE IN cursor_4c_BuscaUni
2397:             ENDIF
2398:         CATCH TO loc_oErro
2399:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupUnPesos")
2400:         ENDTRY
2401:     ENDPROC
2402: 
2403:     *--------------------------------------------------------------------------
2404:     PROTECTED PROCEDURE AbrirLookupClsFis(par_cNomeCampo)
2405:         LOCAL loc_oRdp, loc_oCtrl, loc_cVal, loc_oBusca, loc_cSQL
2406:         TRY
2407:             loc_oRdp  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page7
2408:             loc_oCtrl = THIS.ObterControle(loc_oRdp, par_cNomeCampo)
2409:             IF PEMSTATUS(loc_oCtrl, "Enabled", 5) AND !loc_oCtrl.Enabled
2410:                 RETURN
2411:             ENDIF
2412:             loc_cVal = ALLTRIM(loc_oCtrl.Value)
2413:             IF !EMPTY(loc_cVal)
2414:                 loc_cSQL = "SELECT codigos, descricaos FROM SigCdClf WHERE UPPER(codigos) LIKE '" + UPPER(loc_cVal) + "%' ORDER BY codigos"
2415:             ELSE
2416:                 loc_cSQL = "SELECT codigos, descricaos FROM SigCdClf ORDER BY codigos"
2417:             ENDIF
2418:             SET NULL ON
2419:             SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaClf")
2420:             IF !USED("cursor_4c_BuscaClf") OR RECCOUNT("cursor_4c_BuscaClf") = 0
2421:                 IF USED("cursor_4c_BuscaClf")
2422:                     USE IN cursor_4c_BuscaClf
2423:                 ENDIF
2424:                 SQLEXEC(gnConnHandle, "SELECT codigos, descricaos FROM SigCdClf ORDER BY codigos", "cursor_4c_BuscaClf")
2425:             ENDIF
2426:             IF !USED("cursor_4c_BuscaClf")
2427:                 CREATE CURSOR cursor_4c_BuscaClf (codigos c(10), descricaos c(60))
2428:             ENDIF
2429:             SET NULL OFF
2430:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2431:             IF VARTYPE(loc_oBusca) = "O"
2432:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaClf"
2433:                 loc_oBusca.DefinirCursor("cursor_4c_BuscaClf", "codigos", "descricaos", "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
2434:                 loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
2435:                 loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
2436:                 loc_oBusca.Mostrar()
2437:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
2438:                     SELECT cursor_4c_BuscaClf
2439:                     loc_oCtrl.Value = ALLTRIM(codigos)
2440:                 ENDIF
2441:             ENDIF
2442:             IF USED("cursor_4c_BuscaClf")
2443:                 USE IN cursor_4c_BuscaClf
2444:             ENDIF
2445:         CATCH TO loc_oErro
2446:             MsgErro(loc_oErro.Message, "FormNfl.AbrirLookupClsFis")
2447:         ENDTRY
2448:     ENDPROC
2449: 
2450:     *--------------------------------------------------------------------------
2451:     PROTECTED PROCEDURE ValidarClsFis(par_cNomeCampo)
2452:         LOCAL loc_lResultado, loc_oRdp, loc_cVal, loc_nRes
2453:         loc_lResultado = .T.
2454:         TRY
2455:             loc_oRdp = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page7
2456:             loc_cVal = ALLTRIM(loc_oRdp.Value)
2457:             IF EMPTY(loc_cVal) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
2458:                 loc_lResultado = .T.
2459:             ENDIF
2460:             loc_nRes = SQLEXEC(gnConnHandle, ;
2461:                 "SELECT codigos FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cVal), ;
2462:                 "cursor_4c_ValidClf")
2463:             IF loc_nRes <= 0 OR RECCOUNT("cursor_4c_ValidClf") = 0
2464:                 THIS.AbrirLookupClsFis(par_cNomeCampo)
2465:             ENDIF
2466:             IF USED("cursor_4c_ValidClf")
2467:                 USE IN cursor_4c_ValidClf
2468:             ENDIF
2469:         CATCH TO loc_oErro
2470:             MsgErro(loc_oErro.Message, "FormNfl.ValidarClsFis")
2471:         ENDTRY
2472:         RETURN loc_lResultado
2473:     ENDPROC
2474: 
2475:     *-- CodImp bloco 1 (campos 1-7)
2476:     PROCEDURE CodImp1KeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 2657 a 2687:
2657:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
2658:         loc_oBO   = THIS.this_oBusinessObject
2659: 
2660:         *-- Controles standalone (sem ControlSource)
2661:         IF PEMSTATUS(loc_oPag2, "txt_4c_Series", 5)
2662:             loc_oBO.this_cSeries = ALLTRIM(loc_oPag2.txt_4c_Series.Value)
2663:         ENDIF
2664:         IF VARTYPE(loc_oPag2.pgf_4c_Abas) = "O"
2665:             IF PEMSTATUS(loc_oPag2.pgf_4c_Abas.Page10, "txt_4c_EmpPad", 5)
2666:                 loc_oBO.this_cEmps = ALLTRIM(loc_oPag2.pgf_4c_Abas.Page10.txt_4c_EmpPad.Value)
2667:             ENDIF
2668:         ENDIF
2669: 
2670:         *-- Campos de crSigCnFN2 (Empresa, Destinatario, Impostos adicionais, Classes extras)
2671:         IF USED("crSigCnFN2") AND RECCOUNT("crSigCnFN2") > 0
2672:             SELECT crSigCnFN2
2673:             loc_oBO.this_cCtitent      = ALLTRIM(ctitent)
2674:             loc_oBO.this_nLendent      = lendent
2675:             loc_oBO.this_nCendent      = cendent
2676:             loc_oBO.this_nLbaient      = lbaient
2677:             loc_oBO.this_nCbaient      = cbaient
2678:             loc_oBO.this_nLmunent      = lmunent
2679:             loc_oBO.this_nCmunent      = cmunent
2680:             loc_oBO.this_nLestent      = lestent
2681:             loc_oBO.this_nCestent      = cestent
2682:             loc_oBO.this_nLcepent      = lcepent
2683:             loc_oBO.this_nCcepent      = ccepent
2684:             loc_oBO.this_nLfoneent     = lfoneent
2685:             loc_oBO.this_nCfoneent     = cfoneent
2686:             loc_oBO.this_nLiniped      = liniped
2687:             loc_oBO.this_nCiniped      = ciniped

*-- Linhas 2785 a 2832:
2785:         *-- Campos editados via crSigCnFNf que tem contraparte em SigCnFN2
2786:         *   (desdobramento posicoes e vseqnota)
2787:         IF USED("crSigCnFNf") AND FCOUNT("crSigCnFNf") > 3 AND RECCOUNT("crSigCnFNf") > 0
2788:             SELECT crSigCnFNf
2789:             loc_oBO.this_lVseqnota = (vseqnota = 1)
2790:             loc_oBO.this_nLopcvd   = lopcvd
2791:             loc_oBO.this_nCopcvd   = copcvd
2792:             loc_oBO.this_nLoploc   = loploc
2793:             loc_oBO.this_nCoploc   = coploc
2794:             loc_oBO.this_nLopnvd   = lopnvd
2795:             loc_oBO.this_nCopnvd   = copnvd
2796:             loc_oBO.this_nLopnrp   = lopnrp
2797:             loc_oBO.this_nCopnrp   = copnrp
2798:         ENDIF
2799:     ENDPROC
2800: 
2801:     *--------------------------------------------------------------------------
2802:     PROTECTED PROCEDURE BOParaForm()
2803:         LOCAL loc_lResultado, loc_oPag2, loc_oBO, loc_cChave
2804:         loc_lResultado = .F.
2805:         TRY
2806:             loc_oPag2  = THIS.pgf_4c_Paginas.Page2
2807:             loc_oBO    = THIS.this_oBusinessObject
2808:             loc_cChave = ALLTRIM(loc_oBO.this_cCidchaves)
2809: 
2810:             IF !EMPTY(loc_cChave)
2811:                 IF SQLEXEC(gnConnHandle, ;
2812:                     "SELECT * FROM SigCnFNf WHERE cidchaves = " + EscaparSQL(loc_cChave), ;
2813:                     "crSigCnFNf") <= 0
2814:                     MsgErro("Erro ao recarregar SigCnFNf.", "FormNfl.BOParaForm")
2815:                 ENDIF
2816:                 IF SQLEXEC(gnConnHandle, ;
2817:                     "SELECT * FROM SigCnFN2 WHERE cidchaves = " + EscaparSQL(loc_cChave), ;
2818:                     "crSigCnFN2") <= 0
2819:                     MsgErro("Erro ao recarregar SigCnFN2.", "FormNfl.BOParaForm")
2820:                 ENDIF
2821:             ENDIF
2822: 
2823:             IF PEMSTATUS(loc_oPag2, "txt_4c_Series", 5)
2824:                 loc_oPag2.txt_4c_Series.Value = ALLTRIM(loc_oBO.this_cSeries)
2825:             ENDIF
2826:             IF VARTYPE(loc_oPag2.pgf_4c_Abas) = "O"
2827:                 IF PEMSTATUS(loc_oPag2.pgf_4c_Abas.Page10, "txt_4c_EmpPad", 5)
2828:                     loc_oPag2.pgf_4c_Abas.Page10.txt_4c_EmpPad.Value = ALLTRIM(loc_oBO.this_cEmps)
2829:                 ENDIF
2830:             ENDIF
2831:             loc_lResultado = .T.
2832:         CATCH TO loc_oErro

*-- Linhas 2882 a 2900:
2882: 
2883:         loc_oAba.AddObject("txt_4c_EmpNomeL", "TextBox")
2884:         WITH loc_oAba.txt_4c_EmpNomeL
2885:             .ControlSource = "crSigCnFN2.lempnome"
2886:             .Top           = 38
2887:             .Left          = 42
2888:             .Width         = 41
2889:             .Height        = 18
2890:             .FontName      = "Tahoma"
2891:             .FontSize      = 8
2892:             .SpecialEffect = 1
2893:             .Format        = "K"
2894:             .InputMask     = "999.99"
2895:             .Visible       = .T.
2896:         ENDWITH
2897: 
2898:         loc_oAba.AddObject("lbl_4c_Label42", "Label")
2899:         WITH loc_oAba.lbl_4c_Label42
2900:             .Caption   = "x"

*-- Linhas 2910 a 2928:
2910: 
2911:         loc_oAba.AddObject("txt_4c_EmpNomeC", "TextBox")
2912:         WITH loc_oAba.txt_4c_EmpNomeC
2913:             .ControlSource = "crSigCnFN2.cempnome"
2914:             .Top           = 38
2915:             .Left          = 91
2916:             .Width         = 41
2917:             .Height        = 18
2918:             .FontName      = "Tahoma"
2919:             .FontSize      = 8
2920:             .SpecialEffect = 1
2921:             .Format        = "K"
2922:             .InputMask     = "999.99"
2923:             .Visible       = .T.
2924:         ENDWITH
2925: 
2926:         *-- Empresa - CGC/CPF (top=26)
2927:         loc_oAba.AddObject("lbl_4c_Label43", "Label")
2928:         WITH loc_oAba.lbl_4c_Label43

*-- Linhas 2939 a 2957:
2939: 
2940:         loc_oAba.AddObject("txt_4c_EmpCgcL", "TextBox")
2941:         WITH loc_oAba.txt_4c_EmpCgcL
2942:             .ControlSource = "crSigCnFN2.lempcgc"
2943:             .Top           = 38
2944:             .Left          = 150
2945:             .Width         = 41
2946:             .Height        = 18
2947:             .FontName      = "Tahoma"
2948:             .FontSize      = 8
2949:             .SpecialEffect = 1
2950:             .Format        = "K"
2951:             .InputMask     = "999.99"
2952:             .Visible       = .T.
2953:         ENDWITH
2954: 
2955:         loc_oAba.AddObject("lbl_4c_Label44", "Label")
2956:         WITH loc_oAba.lbl_4c_Label44
2957:             .Caption   = "x"

*-- Linhas 2967 a 2985:
2967: 
2968:         loc_oAba.AddObject("txt_4c_EmpCgcC", "TextBox")
2969:         WITH loc_oAba.txt_4c_EmpCgcC
2970:             .ControlSource = "crSigCnFN2.cempcgc"
2971:             .Top           = 38
2972:             .Left          = 199
2973:             .Width         = 41
2974:             .Height        = 18
2975:             .FontName      = "Tahoma"
2976:             .FontSize      = 8
2977:             .SpecialEffect = 1
2978:             .Format        = "K"
2979:             .InputMask     = "999.99"
2980:             .Visible       = .T.
2981:         ENDWITH
2982: 
2983:         *-- Empresa - Insc.Estadual (top=26)
2984:         loc_oAba.AddObject("lbl_4c_Label55", "Label")
2985:         WITH loc_oAba.lbl_4c_Label55

*-- Linhas 2996 a 3014:
2996: 
2997:         loc_oAba.AddObject("txt_4c_EmpIestL", "TextBox")
2998:         WITH loc_oAba.txt_4c_EmpIestL
2999:             .ControlSource = "crSigCnFN2.lempiest"
3000:             .Top           = 38
3001:             .Left          = 258
3002:             .Width         = 41
3003:             .Height        = 18
3004:             .FontName      = "Tahoma"
3005:             .FontSize      = 8
3006:             .SpecialEffect = 1
3007:             .Format        = "K"
3008:             .InputMask     = "999.99"
3009:             .Visible       = .T.
3010:         ENDWITH
3011: 
3012:         loc_oAba.AddObject("lbl_4c_Label56", "Label")
3013:         WITH loc_oAba.lbl_4c_Label56
3014:             .Caption   = "x"

*-- Linhas 3024 a 3042:
3024: 
3025:         loc_oAba.AddObject("txt_4c_EmpIestC", "TextBox")
3026:         WITH loc_oAba.txt_4c_EmpIestC
3027:             .ControlSource = "crSigCnFN2.cempiest"
3028:             .Top           = 38
3029:             .Left          = 307
3030:             .Width         = 41
3031:             .Height        = 18
3032:             .FontName      = "Tahoma"
3033:             .FontSize      = 8
3034:             .SpecialEffect = 1
3035:             .Format        = "K"
3036:             .InputMask     = "999.99"
3037:             .Visible       = .T.
3038:         ENDWITH
3039: 
3040:         *-- Empresa - Endereco (top=56)
3041:         loc_oAba.AddObject("lbl_4c_Label45", "Label")
3042:         WITH loc_oAba.lbl_4c_Label45

*-- Linhas 3053 a 3071:
3053: 
3054:         loc_oAba.AddObject("txt_4c_EmpEnderL", "TextBox")
3055:         WITH loc_oAba.txt_4c_EmpEnderL
3056:             .ControlSource = "crSigCnFN2.lempender"
3057:             .Top           = 68
3058:             .Left          = 42
3059:             .Width         = 41
3060:             .Height        = 18
3061:             .FontName      = "Tahoma"
3062:             .FontSize      = 8
3063:             .SpecialEffect = 1
3064:             .Format        = "K"
3065:             .InputMask     = "999.99"
3066:             .Visible       = .T.
3067:         ENDWITH
3068: 
3069:         loc_oAba.AddObject("lbl_4c_Label46", "Label")
3070:         WITH loc_oAba.lbl_4c_Label46
3071:             .Caption   = "x"

*-- Linhas 3081 a 3099:
3081: 
3082:         loc_oAba.AddObject("txt_4c_EmpEnderC", "TextBox")
3083:         WITH loc_oAba.txt_4c_EmpEnderC
3084:             .ControlSource = "crSigCnFN2.cempender"
3085:             .Top           = 68
3086:             .Left          = 91
3087:             .Width         = 41
3088:             .Height        = 18
3089:             .FontName      = "Tahoma"
3090:             .FontSize      = 8
3091:             .SpecialEffect = 1
3092:             .Format        = "K"
3093:             .InputMask     = "999.99"
3094:             .Visible       = .T.
3095:         ENDWITH
3096: 
3097:         *-- Empresa - Bairro (top=56)
3098:         loc_oAba.AddObject("lbl_4c_Label47", "Label")
3099:         WITH loc_oAba.lbl_4c_Label47

*-- Linhas 3110 a 3128:
3110: 
3111:         loc_oAba.AddObject("txt_4c_EmpBairL", "TextBox")
3112:         WITH loc_oAba.txt_4c_EmpBairL
3113:             .ControlSource = "crSigCnFN2.lempbair"
3114:             .Top           = 68
3115:             .Left          = 149
3116:             .Width         = 41
3117:             .Height        = 18
3118:             .FontName      = "Tahoma"
3119:             .FontSize      = 8
3120:             .SpecialEffect = 1
3121:             .Format        = "K"
3122:             .InputMask     = "999.99"
3123:             .Visible       = .T.
3124:         ENDWITH
3125: 
3126:         loc_oAba.AddObject("lbl_4c_Label48", "Label")
3127:         WITH loc_oAba.lbl_4c_Label48
3128:             .Caption   = "x"

*-- Linhas 3138 a 3156:
3138: 
3139:         loc_oAba.AddObject("txt_4c_EmpBairC", "TextBox")
3140:         WITH loc_oAba.txt_4c_EmpBairC
3141:             .ControlSource = "crSigCnFN2.cempbair"
3142:             .Top           = 68
3143:             .Left          = 198
3144:             .Width         = 41
3145:             .Height        = 18
3146:             .FontName      = "Tahoma"
3147:             .FontSize      = 8
3148:             .SpecialEffect = 1
3149:             .Format        = "K"
3150:             .InputMask     = "999.99"
3151:             .Visible       = .T.
3152:         ENDWITH
3153: 
3154:         *-- Empresa - Municipio (top=56)
3155:         loc_oAba.AddObject("lbl_4c_Label51", "Label")
3156:         WITH loc_oAba.lbl_4c_Label51

*-- Linhas 3167 a 3185:
3167: 
3168:         loc_oAba.AddObject("txt_4c_EmpMuniL", "TextBox")
3169:         WITH loc_oAba.txt_4c_EmpMuniL
3170:             .ControlSource = "crSigCnFN2.lempmuni"
3171:             .Top           = 68
3172:             .Left          = 257
3173:             .Width         = 41
3174:             .Height        = 18
3175:             .FontName      = "Tahoma"
3176:             .FontSize      = 8
3177:             .SpecialEffect = 1
3178:             .Format        = "K"
3179:             .InputMask     = "999.99"
3180:             .Visible       = .T.
3181:         ENDWITH
3182: 
3183:         loc_oAba.AddObject("lbl_4c_Label52", "Label")
3184:         WITH loc_oAba.lbl_4c_Label52
3185:             .Caption   = "x"

*-- Linhas 3195 a 3213:
3195: 
3196:         loc_oAba.AddObject("txt_4c_EmpMuniC", "TextBox")
3197:         WITH loc_oAba.txt_4c_EmpMuniC
3198:             .ControlSource = "crSigCnFN2.cempmuni"
3199:             .Top           = 68
3200:             .Left          = 306
3201:             .Width         = 41
3202:             .Height        = 18
3203:             .FontName      = "Tahoma"
3204:             .FontSize      = 8
3205:             .SpecialEffect = 1
3206:             .Format        = "K"
3207:             .InputMask     = "999.99"
3208:             .Visible       = .T.
3209:         ENDWITH
3210: 
3211:         *-- Empresa - CEP (top=86)
3212:         loc_oAba.AddObject("lbl_4c_Label49", "Label")
3213:         WITH loc_oAba.lbl_4c_Label49

*-- Linhas 3224 a 3242:
3224: 
3225:         loc_oAba.AddObject("txt_4c_EmpCepL", "TextBox")
3226:         WITH loc_oAba.txt_4c_EmpCepL
3227:             .ControlSource = "crSigCnFN2.lempcep"
3228:             .Top           = 98
3229:             .Left          = 41
3230:             .Width         = 41
3231:             .Height        = 18
3232:             .FontName      = "Tahoma"
3233:             .FontSize      = 8
3234:             .SpecialEffect = 1
3235:             .Format        = "K"
3236:             .InputMask     = "999.99"
3237:             .Visible       = .T.
3238:         ENDWITH
3239: 
3240:         loc_oAba.AddObject("lbl_4c_Label50", "Label")
3241:         WITH loc_oAba.lbl_4c_Label50
3242:             .Caption   = "x"

*-- Linhas 3252 a 3270:
3252: 
3253:         loc_oAba.AddObject("txt_4c_EmpCepC", "TextBox")
3254:         WITH loc_oAba.txt_4c_EmpCepC
3255:             .ControlSource = "crSigCnFN2.cempcep"
3256:             .Top           = 98
3257:             .Left          = 90
3258:             .Width         = 41
3259:             .Height        = 18
3260:             .FontName      = "Tahoma"
3261:             .FontSize      = 8
3262:             .SpecialEffect = 1
3263:             .Format        = "K"
3264:             .InputMask     = "999.99"
3265:             .Visible       = .T.
3266:         ENDWITH
3267: 
3268:         *-- Empresa - Fone/Fax (top=86)
3269:         loc_oAba.AddObject("lbl_4c_Label53", "Label")
3270:         WITH loc_oAba.lbl_4c_Label53

*-- Linhas 3281 a 3299:
3281: 
3282:         loc_oAba.AddObject("txt_4c_EmpFoneL", "TextBox")
3283:         WITH loc_oAba.txt_4c_EmpFoneL
3284:             .ControlSource = "crSigCnFN2.lempfone"
3285:             .Top           = 98
3286:             .Left          = 149
3287:             .Width         = 41
3288:             .Height        = 18
3289:             .FontName      = "Tahoma"
3290:             .FontSize      = 8
3291:             .SpecialEffect = 1
3292:             .Format        = "K"
3293:             .InputMask     = "999.99"
3294:             .Visible       = .T.
3295:         ENDWITH
3296: 
3297:         loc_oAba.AddObject("lbl_4c_Label54", "Label")
3298:         WITH loc_oAba.lbl_4c_Label54
3299:             .Caption   = "x"

*-- Linhas 3309 a 3327:
3309: 
3310:         loc_oAba.AddObject("txt_4c_EmpFoneC", "TextBox")
3311:         WITH loc_oAba.txt_4c_EmpFoneC
3312:             .ControlSource = "crSigCnFN2.cempfone"
3313:             .Top           = 98
3314:             .Left          = 198
3315:             .Width         = 41
3316:             .Height        = 18
3317:             .FontName      = "Tahoma"
3318:             .FontSize      = 8
3319:             .SpecialEffect = 1
3320:             .Format        = "K"
3321:             .InputMask     = "999.99"
3322:             .Visible       = .T.
3323:         ENDWITH
3324: 
3325:         *-- Empresa - Estado (top=86)
3326:         loc_oAba.AddObject("lbl_4c_Label58", "Label")
3327:         WITH loc_oAba.lbl_4c_Label58

*-- Linhas 3338 a 3356:
3338: 
3339:         loc_oAba.AddObject("txt_4c_EmpEstaL", "TextBox")
3340:         WITH loc_oAba.txt_4c_EmpEstaL
3341:             .ControlSource = "crSigCnFN2.lempesta"
3342:             .Top           = 98
3343:             .Left          = 257
3344:             .Width         = 41
3345:             .Height        = 18
3346:             .FontName      = "Tahoma"
3347:             .FontSize      = 8
3348:             .SpecialEffect = 1
3349:             .Format        = "K"
3350:             .InputMask     = "999.99"
3351:             .Visible       = .T.
3352:         ENDWITH
3353: 
3354:         loc_oAba.AddObject("lbl_4c_Label59", "Label")
3355:         WITH loc_oAba.lbl_4c_Label59
3356:             .Caption   = "x"

*-- Linhas 3366 a 3384:
3366: 
3367:         loc_oAba.AddObject("txt_4c_EmpEstaC", "TextBox")
3368:         WITH loc_oAba.txt_4c_EmpEstaC
3369:             .ControlSource = "crSigCnFN2.cempesta"
3370:             .Top           = 98
3371:             .Left          = 306
3372:             .Width         = 41
3373:             .Height        = 18
3374:             .FontName      = "Tahoma"
3375:             .FontSize      = 8
3376:             .SpecialEffect = 1
3377:             .Format        = "K"
3378:             .InputMask     = "999.99"
3379:             .Visible       = .T.
3380:         ENDWITH
3381: 
3382:         *-- Secao: Dados/Endereco - Empresa/Cliente (top=120 shape + top=127 header)
3383:         loc_oAba.AddObject("shp_4c_Shape1", "Shape")
3384:         WITH loc_oAba.shp_4c_Shape1

*-- Linhas 3422 a 3440:
3422: 
3423:         loc_oAba.AddObject("txt_4c_CliNomeL", "TextBox")
3424:         WITH loc_oAba.txt_4c_CliNomeL
3425:             .ControlSource = "crSigCnFNf.lnome"
3426:             .Top           = 153
3427:             .Left          = 42
3428:             .Width         = 41
3429:             .Height        = 18
3430:             .FontName      = "Tahoma"
3431:             .FontSize      = 8
3432:             .SpecialEffect = 1
3433:             .Format        = "K"
3434:             .InputMask     = "999.99"
3435:             .Visible       = .T.
3436:         ENDWITH
3437: 
3438:         loc_oAba.AddObject("lbl_4c_Label2", "Label")
3439:         WITH loc_oAba.lbl_4c_Label2
3440:             .Caption   = "x"

*-- Linhas 3450 a 3468:
3450: 
3451:         loc_oAba.AddObject("txt_4c_CliNomeC", "TextBox")
3452:         WITH loc_oAba.txt_4c_CliNomeC
3453:             .ControlSource = "crSigCnFNf.cnome"
3454:             .Top           = 153
3455:             .Left          = 91
3456:             .Width         = 41
3457:             .Height        = 18
3458:             .FontName      = "Tahoma"
3459:             .FontSize      = 8
3460:             .SpecialEffect = 1
3461:             .Format        = "K"
3462:             .InputMask     = "999.99"
3463:             .Visible       = .T.
3464:         ENDWITH
3465: 
3466:         *-- CGC/CPF (cliente, top=141)
3467:         loc_oAba.AddObject("lbl_4c_Label3", "Label")
3468:         WITH loc_oAba.lbl_4c_Label3

*-- Linhas 3479 a 3497:
3479: 
3480:         loc_oAba.AddObject("txt_4c_CliCgcL", "TextBox")
3481:         WITH loc_oAba.txt_4c_CliCgcL
3482:             .ControlSource = "crSigCnFNf.lcgc"
3483:             .Top           = 153
3484:             .Left          = 150
3485:             .Width         = 41
3486:             .Height        = 18
3487:             .FontName      = "Tahoma"
3488:             .FontSize      = 8
3489:             .SpecialEffect = 1
3490:             .Format        = "K"
3491:             .InputMask     = "999.99"
3492:             .Visible       = .T.
3493:         ENDWITH
3494: 
3495:         loc_oAba.AddObject("lbl_4c_Label4", "Label")
3496:         WITH loc_oAba.lbl_4c_Label4
3497:             .Caption   = "x"

*-- Linhas 3507 a 3525:
3507: 
3508:         loc_oAba.AddObject("txt_4c_CliCgcC", "TextBox")
3509:         WITH loc_oAba.txt_4c_CliCgcC
3510:             .ControlSource = "crSigCnFNf.ccgc"
3511:             .Top           = 153
3512:             .Left          = 199
3513:             .Width         = 41
3514:             .Height        = 18
3515:             .FontName      = "Tahoma"
3516:             .FontSize      = 8
3517:             .SpecialEffect = 1
3518:             .Format        = "K"
3519:             .InputMask     = "999.99"
3520:             .Visible       = .T.
3521:         ENDWITH
3522: 
3523:         *-- Insc.Estadual (cliente, top=141)
3524:         loc_oAba.AddObject("lbl_4c_Label21", "Label")
3525:         WITH loc_oAba.lbl_4c_Label21

*-- Linhas 3536 a 3554:
3536: 
3537:         loc_oAba.AddObject("txt_4c_CliIestL", "TextBox")
3538:         WITH loc_oAba.txt_4c_CliIestL
3539:             .ControlSource = "crSigCnFNf.liest"
3540:             .Top           = 153
3541:             .Left          = 258
3542:             .Width         = 41
3543:             .Height        = 18
3544:             .FontName      = "Tahoma"
3545:             .FontSize      = 8
3546:             .SpecialEffect = 1
3547:             .Format        = "K"
3548:             .InputMask     = "999.99"
3549:             .Visible       = .T.
3550:         ENDWITH
3551: 
3552:         loc_oAba.AddObject("lbl_4c_Label22", "Label")
3553:         WITH loc_oAba.lbl_4c_Label22
3554:             .Caption   = "x"

*-- Linhas 3564 a 3582:
3564: 
3565:         loc_oAba.AddObject("txt_4c_CliIestC", "TextBox")
3566:         WITH loc_oAba.txt_4c_CliIestC
3567:             .ControlSource = "crSigCnFNf.ciest"
3568:             .Top           = 153
3569:             .Left          = 307
3570:             .Width         = 41
3571:             .Height        = 18
3572:             .FontName      = "Tahoma"
3573:             .FontSize      = 8
3574:             .SpecialEffect = 1
3575:             .Format        = "K"
3576:             .InputMask     = "999.99"
3577:             .Visible       = .T.
3578:         ENDWITH
3579: 
3580:         *-- Data de Emissao (cliente, top=141)
3581:         loc_oAba.AddObject("lbl_4c_Label5", "Label")
3582:         WITH loc_oAba.lbl_4c_Label5

*-- Linhas 3593 a 3611:
3593: 
3594:         loc_oAba.AddObject("txt_4c_CliDtEmiL", "TextBox")
3595:         WITH loc_oAba.txt_4c_CliDtEmiL
3596:             .ControlSource = "crSigCnFNf.ldtemi"
3597:             .Top           = 153
3598:             .Left          = 366
3599:             .Width         = 41
3600:             .Height        = 18
3601:             .FontName      = "Tahoma"
3602:             .FontSize      = 8
3603:             .SpecialEffect = 1
3604:             .Format        = "K"
3605:             .InputMask     = "999.99"
3606:             .Visible       = .T.
3607:         ENDWITH
3608: 
3609:         loc_oAba.AddObject("lbl_4c_Label6", "Label")
3610:         WITH loc_oAba.lbl_4c_Label6
3611:             .Caption   = "x"

*-- Linhas 3621 a 3639:
3621: 
3622:         loc_oAba.AddObject("txt_4c_CliDtEmiC", "TextBox")
3623:         WITH loc_oAba.txt_4c_CliDtEmiC
3624:             .ControlSource = "crSigCnFNf.cdtemi"
3625:             .Top           = 153
3626:             .Left          = 415
3627:             .Width         = 41
3628:             .Height        = 18
3629:             .FontName      = "Tahoma"
3630:             .FontSize      = 8
3631:             .SpecialEffect = 1
3632:             .Format        = "K"
3633:             .InputMask     = "999.99"
3634:             .Visible       = .T.
3635:         ENDWITH
3636: 
3637:         *-- Endereco (cliente, top=171)
3638:         loc_oAba.AddObject("lbl_4c_Label7", "Label")
3639:         WITH loc_oAba.lbl_4c_Label7

*-- Linhas 3650 a 3668:
3650: 
3651:         loc_oAba.AddObject("txt_4c_CliEnderL", "TextBox")
3652:         WITH loc_oAba.txt_4c_CliEnderL
3653:             .ControlSource = "crSigCnFNf.lender"
3654:             .Top           = 183
3655:             .Left          = 42
3656:             .Width         = 41
3657:             .Height        = 18
3658:             .FontName      = "Tahoma"
3659:             .FontSize      = 8
3660:             .SpecialEffect = 1
3661:             .Format        = "K"
3662:             .InputMask     = "999.99"
3663:             .Visible       = .T.
3664:         ENDWITH
3665: 
3666:         loc_oAba.AddObject("lbl_4c_Label8", "Label")
3667:         WITH loc_oAba.lbl_4c_Label8
3668:             .Caption   = "x"

*-- Linhas 3678 a 3696:
3678: 
3679:         loc_oAba.AddObject("txt_4c_CliEnderC", "TextBox")
3680:         WITH loc_oAba.txt_4c_CliEnderC
3681:             .ControlSource = "crSigCnFNf.cender"
3682:             .Top           = 183
3683:             .Left          = 91
3684:             .Width         = 41
3685:             .Height        = 18
3686:             .FontName      = "Tahoma"
3687:             .FontSize      = 8
3688:             .SpecialEffect = 1
3689:             .Format        = "K"
3690:             .InputMask     = "999.99"
3691:             .Visible       = .T.
3692:         ENDWITH
3693: 
3694:         *-- Bairro (cliente, top=171)
3695:         loc_oAba.AddObject("lbl_4c_Label9", "Label")
3696:         WITH loc_oAba.lbl_4c_Label9

*-- Linhas 3707 a 3725:
3707: 
3708:         loc_oAba.AddObject("txt_4c_CliBairrL", "TextBox")
3709:         WITH loc_oAba.txt_4c_CliBairrL
3710:             .ControlSource = "crSigCnFNf.lbairr"
3711:             .Top           = 183
3712:             .Left          = 149
3713:             .Width         = 41
3714:             .Height        = 18
3715:             .FontName      = "Tahoma"
3716:             .FontSize      = 8
3717:             .SpecialEffect = 1
3718:             .Format        = "K"
3719:             .InputMask     = "999.99"
3720:             .Visible       = .T.
3721:         ENDWITH
3722: 
3723:         loc_oAba.AddObject("lbl_4c_Label10", "Label")
3724:         WITH loc_oAba.lbl_4c_Label10
3725:             .Caption   = "x"

*-- Linhas 3735 a 3753:
3735: 
3736:         loc_oAba.AddObject("txt_4c_CliBairrC", "TextBox")
3737:         WITH loc_oAba.txt_4c_CliBairrC
3738:             .ControlSource = "crSigCnFNf.cbairr"
3739:             .Top           = 183
3740:             .Left          = 198
3741:             .Width         = 41
3742:             .Height        = 18
3743:             .FontName      = "Tahoma"
3744:             .FontSize      = 8
3745:             .SpecialEffect = 1
3746:             .Format        = "K"
3747:             .InputMask     = "999.99"
3748:             .Visible       = .T.
3749:         ENDWITH
3750: 
3751:         *-- Municipio (cliente, top=171)
3752:         loc_oAba.AddObject("lbl_4c_Label15", "Label")
3753:         WITH loc_oAba.lbl_4c_Label15

*-- Linhas 3764 a 3782:
3764: 
3765:         loc_oAba.AddObject("txt_4c_CliMuniL", "TextBox")
3766:         WITH loc_oAba.txt_4c_CliMuniL
3767:             .ControlSource = "crSigCnFNf.lmuni"
3768:             .Top           = 183
3769:             .Left          = 257
3770:             .Width         = 41
3771:             .Height        = 18
3772:             .FontName      = "Tahoma"
3773:             .FontSize      = 8
3774:             .SpecialEffect = 1
3775:             .Format        = "K"
3776:             .InputMask     = "999.99"
3777:             .Visible       = .T.
3778:         ENDWITH
3779: 
3780:         loc_oAba.AddObject("lbl_4c_Label16", "Label")
3781:         WITH loc_oAba.lbl_4c_Label16
3782:             .Caption   = "x"

*-- Linhas 3792 a 3810:
3792: 
3793:         loc_oAba.AddObject("txt_4c_CliMuniC", "TextBox")
3794:         WITH loc_oAba.txt_4c_CliMuniC
3795:             .ControlSource = "crSigCnFNf.cmuni"
3796:             .Top           = 183
3797:             .Left          = 306
3798:             .Width         = 41
3799:             .Height        = 18
3800:             .FontName      = "Tahoma"
3801:             .FontSize      = 8
3802:             .SpecialEffect = 1
3803:             .Format        = "K"
3804:             .InputMask     = "999.99"
3805:             .Visible       = .T.
3806:         ENDWITH
3807: 
3808:         *-- Estado (cliente, top=171)
3809:         loc_oAba.AddObject("lbl_4c_Label17", "Label")
3810:         WITH loc_oAba.lbl_4c_Label17

*-- Linhas 3821 a 3839:
3821: 
3822:         loc_oAba.AddObject("txt_4c_CliEstaL", "TextBox")
3823:         WITH loc_oAba.txt_4c_CliEstaL
3824:             .ControlSource = "crSigCnFNf.lesta"
3825:             .Top           = 183
3826:             .Left          = 365
3827:             .Width         = 41
3828:             .Height        = 18
3829:             .FontName      = "Tahoma"
3830:             .FontSize      = 8
3831:             .SpecialEffect = 1
3832:             .Format        = "K"
3833:             .InputMask     = "999.99"
3834:             .Visible       = .T.
3835:         ENDWITH
3836: 
3837:         loc_oAba.AddObject("lbl_4c_Label18", "Label")
3838:         WITH loc_oAba.lbl_4c_Label18
3839:             .Caption   = "x"

*-- Linhas 3849 a 3867:
3849: 
3850:         loc_oAba.AddObject("txt_4c_CliEstaC", "TextBox")
3851:         WITH loc_oAba.txt_4c_CliEstaC
3852:             .ControlSource = "crSigCnFNf.cesta"
3853:             .Top           = 183
3854:             .Left          = 414
3855:             .Width         = 41
3856:             .Height        = 18
3857:             .FontName      = "Tahoma"
3858:             .FontSize      = 8
3859:             .SpecialEffect = 1
3860:             .Format        = "K"
3861:             .InputMask     = "999.99"
3862:             .Visible       = .T.
3863:         ENDWITH
3864: 
3865:         *-- CEP (cliente, top=201)
3866:         loc_oAba.AddObject("lbl_4c_Label13", "Label")
3867:         WITH loc_oAba.lbl_4c_Label13

*-- Linhas 3878 a 3896:
3878: 
3879:         loc_oAba.AddObject("txt_4c_CliCepL", "TextBox")
3880:         WITH loc_oAba.txt_4c_CliCepL
3881:             .ControlSource = "crSigCnFNf.lcep"
3882:             .Top           = 213
3883:             .Left          = 41
3884:             .Width         = 41
3885:             .Height        = 18
3886:             .FontName      = "Tahoma"
3887:             .FontSize      = 8
3888:             .SpecialEffect = 1
3889:             .Format        = "K"
3890:             .InputMask     = "999.99"
3891:             .Visible       = .T.
3892:         ENDWITH
3893: 
3894:         loc_oAba.AddObject("lbl_4c_Label14", "Label")
3895:         WITH loc_oAba.lbl_4c_Label14
3896:             .Caption   = "x"

*-- Linhas 3906 a 3924:
3906: 
3907:         loc_oAba.AddObject("txt_4c_CliCepC", "TextBox")
3908:         WITH loc_oAba.txt_4c_CliCepC
3909:             .ControlSource = "crSigCnFNf.ccep"
3910:             .Top           = 213
3911:             .Left          = 90
3912:             .Width         = 41
3913:             .Height        = 18
3914:             .FontName      = "Tahoma"
3915:             .FontSize      = 8
3916:             .SpecialEffect = 1
3917:             .Format        = "K"
3918:             .InputMask     = "999.99"
3919:             .Visible       = .T.
3920:         ENDWITH
3921: 
3922:         *-- Fone/Fax (cliente, top=201)
3923:         loc_oAba.AddObject("lbl_4c_Label19", "Label")
3924:         WITH loc_oAba.lbl_4c_Label19

*-- Linhas 3935 a 3953:
3935: 
3936:         loc_oAba.AddObject("txt_4c_CliFoneL", "TextBox")
3937:         WITH loc_oAba.txt_4c_CliFoneL
3938:             .ControlSource = "crSigCnFNf.lfone"
3939:             .Top           = 213
3940:             .Left          = 149
3941:             .Width         = 41
3942:             .Height        = 18
3943:             .FontName      = "Tahoma"
3944:             .FontSize      = 8
3945:             .SpecialEffect = 1
3946:             .Format        = "K"
3947:             .InputMask     = "999.99"
3948:             .Visible       = .T.
3949:         ENDWITH
3950: 
3951:         loc_oAba.AddObject("lbl_4c_Label20", "Label")
3952:         WITH loc_oAba.lbl_4c_Label20
3953:             .Caption   = "x"

*-- Linhas 3963 a 3981:
3963: 
3964:         loc_oAba.AddObject("txt_4c_CliFoneC", "TextBox")
3965:         WITH loc_oAba.txt_4c_CliFoneC
3966:             .ControlSource = "crSigCnFNf.cfone"
3967:             .Top           = 213
3968:             .Left          = 198
3969:             .Width         = 41
3970:             .Height        = 18
3971:             .FontName      = "Tahoma"
3972:             .FontSize      = 8
3973:             .SpecialEffect = 1
3974:             .Format        = "K"
3975:             .InputMask     = "999.99"
3976:             .Visible       = .T.
3977:         ENDWITH
3978: 
3979:         *-- Secao: Endereco de Entrega - Empresa/Cliente (top=234 shape + top=238 header)
3980:         loc_oAba.AddObject("shp_4c_Shape2", "Shape")
3981:         WITH loc_oAba.shp_4c_Shape2

*-- Linhas 4019 a 4037:
4019: 
4020:         loc_oAba.AddObject("txt_4c_EntEnderL", "TextBox")
4021:         WITH loc_oAba.txt_4c_EntEnderL
4022:             .ControlSource = "crSigCnFN2.lendent"
4023:             .Top           = 264
4024:             .Left          = 42
4025:             .Width         = 41
4026:             .Height        = 18
4027:             .FontName      = "Tahoma"
4028:             .FontSize      = 8
4029:             .SpecialEffect = 1
4030:             .Format        = "K"
4031:             .InputMask     = "999.99"
4032:             .Visible       = .T.
4033:         ENDWITH
4034: 
4035:         loc_oAba.AddObject("lbl_4c_Label26", "Label")
4036:         WITH loc_oAba.lbl_4c_Label26
4037:             .Caption   = "x"

*-- Linhas 4047 a 4065:
4047: 
4048:         loc_oAba.AddObject("txt_4c_EntEnderC", "TextBox")
4049:         WITH loc_oAba.txt_4c_EntEnderC
4050:             .ControlSource = "crSigCnFN2.cendent"
4051:             .Top           = 264
4052:             .Left          = 91
4053:             .Width         = 41
4054:             .Height        = 18
4055:             .FontName      = "Tahoma"
4056:             .FontSize      = 8
4057:             .SpecialEffect = 1
4058:             .Format        = "K"
4059:             .InputMask     = "999.99"
4060:             .Visible       = .T.
4061:         ENDWITH
4062: 
4063:         *-- Entrega - Bairro (top=252)
4064:         loc_oAba.AddObject("lbl_4c_Label27", "Label")
4065:         WITH loc_oAba.lbl_4c_Label27

*-- Linhas 4076 a 4094:
4076: 
4077:         loc_oAba.AddObject("txt_4c_EntBairL", "TextBox")
4078:         WITH loc_oAba.txt_4c_EntBairL
4079:             .ControlSource = "crSigCnFN2.lbaient"
4080:             .Top           = 264
4081:             .Left          = 149
4082:             .Width         = 41
4083:             .Height        = 18
4084:             .FontName      = "Tahoma"
4085:             .FontSize      = 8
4086:             .SpecialEffect = 1
4087:             .Format        = "K"
4088:             .InputMask     = "999.99"
4089:             .Visible       = .T.
4090:         ENDWITH
4091: 
4092:         loc_oAba.AddObject("lbl_4c_Label28", "Label")
4093:         WITH loc_oAba.lbl_4c_Label28
4094:             .Caption   = "x"

*-- Linhas 4104 a 4122:
4104: 
4105:         loc_oAba.AddObject("txt_4c_EntBairC", "TextBox")
4106:         WITH loc_oAba.txt_4c_EntBairC
4107:             .ControlSource = "crSigCnFN2.cbaient"
4108:             .Top           = 264
4109:             .Left          = 198
4110:             .Width         = 41
4111:             .Height        = 18
4112:             .FontName      = "Tahoma"
4113:             .FontSize      = 8
4114:             .SpecialEffect = 1
4115:             .Format        = "K"
4116:             .InputMask     = "999.99"
4117:             .Visible       = .T.
4118:         ENDWITH
4119: 
4120:         *-- Entrega - Municipio (top=252)
4121:         loc_oAba.AddObject("lbl_4c_Label31", "Label")
4122:         WITH loc_oAba.lbl_4c_Label31

*-- Linhas 4133 a 4151:
4133: 
4134:         loc_oAba.AddObject("txt_4c_EntMuniL", "TextBox")
4135:         WITH loc_oAba.txt_4c_EntMuniL
4136:             .ControlSource = "crSigCnFN2.lmunent"
4137:             .Top           = 264
4138:             .Left          = 257
4139:             .Width         = 41
4140:             .Height        = 18
4141:             .FontName      = "Tahoma"
4142:             .FontSize      = 8
4143:             .SpecialEffect = 1
4144:             .Format        = "K"
4145:             .InputMask     = "999.99"
4146:             .Visible       = .T.
4147:         ENDWITH
4148: 
4149:         loc_oAba.AddObject("lbl_4c_Label32", "Label")
4150:         WITH loc_oAba.lbl_4c_Label32
4151:             .Caption   = "x"

*-- Linhas 4161 a 4179:
4161: 
4162:         loc_oAba.AddObject("txt_4c_EntMuniC", "TextBox")
4163:         WITH loc_oAba.txt_4c_EntMuniC
4164:             .ControlSource = "crSigCnFN2.cmunent"
4165:             .Top           = 264
4166:             .Left          = 306
4167:             .Width         = 41
4168:             .Height        = 18
4169:             .FontName      = "Tahoma"
4170:             .FontSize      = 8
4171:             .SpecialEffect = 1
4172:             .Format        = "K"
4173:             .InputMask     = "999.99"
4174:             .Visible       = .T.
4175:         ENDWITH
4176: 
4177:         *-- Entrega - Estado (top=252)
4178:         loc_oAba.AddObject("lbl_4c_Label33", "Label")
4179:         WITH loc_oAba.lbl_4c_Label33

*-- Linhas 4190 a 4208:
4190: 
4191:         loc_oAba.AddObject("txt_4c_EntEstaL", "TextBox")
4192:         WITH loc_oAba.txt_4c_EntEstaL
4193:             .ControlSource = "crSigCnFN2.lestent"
4194:             .Top           = 264
4195:             .Left          = 365
4196:             .Width         = 41
4197:             .Height        = 18
4198:             .FontName      = "Tahoma"
4199:             .FontSize      = 8
4200:             .SpecialEffect = 1
4201:             .Format        = "K"
4202:             .InputMask     = "999.99"
4203:             .Visible       = .T.
4204:         ENDWITH
4205: 
4206:         loc_oAba.AddObject("lbl_4c_Label34", "Label")
4207:         WITH loc_oAba.lbl_4c_Label34
4208:             .Caption   = "x"

*-- Linhas 4218 a 4236:
4218: 
4219:         loc_oAba.AddObject("txt_4c_EntEstaC", "TextBox")
4220:         WITH loc_oAba.txt_4c_EntEstaC
4221:             .ControlSource = "crSigCnFN2.cestent"
4222:             .Top           = 264
4223:             .Left          = 414
4224:             .Width         = 41
4225:             .Height        = 18
4226:             .FontName      = "Tahoma"
4227:             .FontSize      = 8
4228:             .SpecialEffect = 1
4229:             .Format        = "K"
4230:             .InputMask     = "999.99"
4231:             .Visible       = .T.
4232:         ENDWITH
4233: 
4234:         *-- Entrega - CEP (top=282)
4235:         loc_oAba.AddObject("lbl_4c_Label29", "Label")
4236:         WITH loc_oAba.lbl_4c_Label29

*-- Linhas 4247 a 4265:
4247: 
4248:         loc_oAba.AddObject("txt_4c_EntCepL", "TextBox")
4249:         WITH loc_oAba.txt_4c_EntCepL
4250:             .ControlSource = "crSigCnFN2.lcepent"
4251:             .Top           = 294
4252:             .Left          = 41
4253:             .Width         = 41
4254:             .Height        = 18
4255:             .FontName      = "Tahoma"
4256:             .FontSize      = 8
4257:             .SpecialEffect = 1
4258:             .Format        = "K"
4259:             .InputMask     = "999.99"
4260:             .Visible       = .T.
4261:         ENDWITH
4262: 
4263:         loc_oAba.AddObject("lbl_4c_Label30", "Label")
4264:         WITH loc_oAba.lbl_4c_Label30
4265:             .Caption   = "x"

*-- Linhas 4275 a 4293:
4275: 
4276:         loc_oAba.AddObject("txt_4c_EntCepC", "TextBox")
4277:         WITH loc_oAba.txt_4c_EntCepC
4278:             .ControlSource = "crSigCnFN2.ccepent"
4279:             .Top           = 294
4280:             .Left          = 90
4281:             .Width         = 41
4282:             .Height        = 18
4283:             .FontName      = "Tahoma"
4284:             .FontSize      = 8
4285:             .SpecialEffect = 1
4286:             .Format        = "K"
4287:             .InputMask     = "999.99"
4288:             .Visible       = .T.
4289:         ENDWITH
4290: 
4291:         *-- Entrega - Fone/Fax (top=282)
4292:         loc_oAba.AddObject("lbl_4c_Label35", "Label")
4293:         WITH loc_oAba.lbl_4c_Label35

*-- Linhas 4304 a 4322:
4304: 
4305:         loc_oAba.AddObject("txt_4c_EntFoneL", "TextBox")
4306:         WITH loc_oAba.txt_4c_EntFoneL
4307:             .ControlSource = "crSigCnFN2.lfoneent"
4308:             .Top           = 294
4309:             .Left          = 149
4310:             .Width         = 41
4311:             .Height        = 18
4312:             .FontName      = "Tahoma"
4313:             .FontSize      = 8
4314:             .SpecialEffect = 1
4315:             .Format        = "K"
4316:             .InputMask     = "999.99"
4317:             .Visible       = .T.
4318:         ENDWITH
4319: 
4320:         loc_oAba.AddObject("lbl_4c_Label36", "Label")
4321:         WITH loc_oAba.lbl_4c_Label36
4322:             .Caption   = "x"

*-- Linhas 4332 a 4350:
4332: 
4333:         loc_oAba.AddObject("txt_4c_EntFoneC", "TextBox")
4334:         WITH loc_oAba.txt_4c_EntFoneC
4335:             .ControlSource = "crSigCnFN2.cfoneent"
4336:             .Top           = 294
4337:             .Left          = 198
4338:             .Width         = 41
4339:             .Height        = 18
4340:             .FontName      = "Tahoma"
4341:             .FontSize      = 8
4342:             .SpecialEffect = 1
4343:             .Format        = "K"
4344:             .InputMask     = "999.99"
4345:             .Visible       = .T.
4346:         ENDWITH
4347: 
4348:         *-- Entrega - Titulo de Impressao (top=282)
4349:         loc_oAba.AddObject("lbl_4c_Label39", "Label")
4350:         WITH loc_oAba.lbl_4c_Label39

*-- Linhas 4361 a 4379:
4361: 
4362:         loc_oAba.AddObject("txt_4c_EntTitEndL", "TextBox")
4363:         WITH loc_oAba.txt_4c_EntTitEndL
4364:             .ControlSource = "crSigCnFN2.lendtite"
4365:             .Top           = 294
4366:             .Left          = 257
4367:             .Width         = 41
4368:             .Height        = 18
4369:             .FontName      = "Tahoma"
4370:             .FontSize      = 8
4371:             .SpecialEffect = 1
4372:             .Format        = "K"
4373:             .InputMask     = "999.99"
4374:             .Visible       = .T.
4375:         ENDWITH
4376: 
4377:         loc_oAba.AddObject("lbl_4c_Label40", "Label")
4378:         WITH loc_oAba.lbl_4c_Label40
4379:             .Caption   = "x"

*-- Linhas 4389 a 4422:
4389: 
4390:         loc_oAba.AddObject("txt_4c_EntTitEndC", "TextBox")
4391:         WITH loc_oAba.txt_4c_EntTitEndC
4392:             .ControlSource = "crSigCnFN2.cendtite"
4393:             .Top           = 294
4394:             .Left          = 306
4395:             .Width         = 41
4396:             .Height        = 18
4397:             .FontName      = "Tahoma"
4398:             .FontSize      = 8
4399:             .SpecialEffect = 1
4400:             .Format        = "K"
4401:             .InputMask     = "999.99"
4402:             .Visible       = .T.
4403:         ENDWITH
4404: 
4405:         loc_oAba.AddObject("txt_4c_EntTitulo", "TextBox")
4406:         WITH loc_oAba.txt_4c_EntTitulo
4407:             .ControlSource = "crSigCnFN2.ctitent"
4408:             .Top           = 294
4409:             .Left          = 353
4410:             .Width         = 150
4411:             .Height        = 18
4412:             .MaxLength     = 20
4413:             .FontName      = "Tahoma"
4414:             .FontSize      = 8
4415:             .SpecialEffect = 1
4416:             .Format        = "K"
4417:             .InputMask     = ""
4418:             .Visible       = .T.
4419:         ENDWITH
4420: 
4421:         *-- Secao: Codigo Posto Fiscal / Codigo Suframa (top=313)
4422:         loc_oAba.AddObject("lbl_4c_Label11", "Label")

*-- Linhas 4434 a 4452:
4434: 
4435:         loc_oAba.AddObject("txt_4c_PosFisL", "TextBox")
4436:         WITH loc_oAba.txt_4c_PosFisL
4437:             .ControlSource = "crSigCnFNf.lposfis"
4438:             .Top           = 325
4439:             .Left          = 41
4440:             .Width         = 41
4441:             .Height        = 18
4442:             .FontName      = "Tahoma"
4443:             .FontSize      = 8
4444:             .SpecialEffect = 1
4445:             .Format        = "K"
4446:             .InputMask     = "999.99"
4447:             .Visible       = .T.
4448:         ENDWITH
4449: 
4450:         loc_oAba.AddObject("lbl_4c_Label12", "Label")
4451:         WITH loc_oAba.lbl_4c_Label12
4452:             .Caption   = "x"

*-- Linhas 4462 a 4480:
4462: 
4463:         loc_oAba.AddObject("txt_4c_PosFisC", "TextBox")
4464:         WITH loc_oAba.txt_4c_PosFisC
4465:             .ControlSource = "crSigCnFNf.cposfis"
4466:             .Top           = 325
4467:             .Left          = 90
4468:             .Width         = 41
4469:             .Height        = 18
4470:             .FontName      = "Tahoma"
4471:             .FontSize      = 8
4472:             .SpecialEffect = 1
4473:             .Format        = "K"
4474:             .InputMask     = "999.99"
4475:             .Visible       = .T.
4476:         ENDWITH
4477: 
4478:         loc_oAba.AddObject("lbl_4c_Label23", "Label")
4479:         WITH loc_oAba.lbl_4c_Label23
4480:             .Caption   = "C" + CHR(243) + "digo Suframa"

*-- Linhas 4490 a 4508:
4490: 
4491:         loc_oAba.AddObject("txt_4c_SuframaL", "TextBox")
4492:         WITH loc_oAba.txt_4c_SuframaL
4493:             .ControlSource = "crSigCnFNf.lsufras"
4494:             .Top           = 325
4495:             .Left          = 149
4496:             .Width         = 41
4497:             .Height        = 18
4498:             .FontName      = "Tahoma"
4499:             .FontSize      = 8
4500:             .SpecialEffect = 1
4501:             .Format        = "K"
4502:             .InputMask     = "999.99"
4503:             .Visible       = .T.
4504:         ENDWITH
4505: 
4506:         loc_oAba.AddObject("lbl_4c_Label24", "Label")
4507:         WITH loc_oAba.lbl_4c_Label24
4508:             .Caption   = "x"

*-- Linhas 4518 a 4536:
4518: 
4519:         loc_oAba.AddObject("txt_4c_SuframaC", "TextBox")
4520:         WITH loc_oAba.txt_4c_SuframaC
4521:             .ControlSource = "crSigCnFNf.csufras"
4522:             .Top           = 325
4523:             .Left          = 198
4524:             .Width         = 41
4525:             .Height        = 18
4526:             .FontName      = "Tahoma"
4527:             .FontSize      = 8
4528:             .SpecialEffect = 1
4529:             .Format        = "K"
4530:             .InputMask     = "999.99"
4531:             .Visible       = .T.
4532:         ENDWITH
4533:     ENDPROC
4534: 
4535:     *--------------------------------------------------------------------------
4536:     PROTECTED PROCEDURE ConfigurarDesdobramentoTab()

*-- Linhas 4593 a 4611:
4593:         ENDWITH
4594:         loc_oAba.AddObject("txt_4c_Fat1NumL", "TextBox")
4595:         WITH loc_oAba.txt_4c_Fat1NumL
4596:             .ControlSource = "crSigCnFNf.lfat1num"
4597:             .Top = 37
4598:             .Left = 58
4599:             .Width = 41
4600:             .Height = 18
4601:             .FontName = "Tahoma"
4602:             .FontSize = 8
4603:             .SpecialEffect = 1
4604:             .Format = "K"
4605:             .InputMask = "999.99"
4606:             .Visible = .T.
4607:         ENDWITH
4608:         loc_oAba.AddObject("lbl_4c_F1NX", "Label")
4609:         WITH loc_oAba.lbl_4c_F1NX
4610:             .Caption = "x"
4611:             .Top = 39

*-- Linhas 4619 a 4651:
4619:         ENDWITH
4620:         loc_oAba.AddObject("txt_4c_Fat1NumC", "TextBox")
4621:         WITH loc_oAba.txt_4c_Fat1NumC
4622:             .ControlSource = "crSigCnFNf.cfat1num"
4623:             .Top = 37
4624:             .Left = 107
4625:             .Width = 41
4626:             .Height = 18
4627:             .FontName = "Tahoma"
4628:             .FontSize = 8
4629:             .SpecialEffect = 1
4630:             .Format = "K"
4631:             .InputMask = "999.99"
4632:             .Visible = .T.
4633:         ENDWITH
4634:         loc_oAba.AddObject("txt_4c_Fat1ValL", "TextBox")
4635:         WITH loc_oAba.txt_4c_Fat1ValL
4636:             .ControlSource = "crSigCnFNf.lfat1val"
4637:             .Top = 37
4638:             .Left = 165
4639:             .Width = 41
4640:             .Height = 18
4641:             .FontName = "Tahoma"
4642:             .FontSize = 8
4643:             .SpecialEffect = 1
4644:             .Format = "K"
4645:             .InputMask = "999.99"
4646:             .Visible = .T.
4647:         ENDWITH
4648:         loc_oAba.AddObject("lbl_4c_F1VX", "Label")
4649:         WITH loc_oAba.lbl_4c_F1VX
4650:             .Caption = "x"
4651:             .Top = 39

*-- Linhas 4659 a 4691:
4659:         ENDWITH
4660:         loc_oAba.AddObject("txt_4c_Fat1ValC", "TextBox")
4661:         WITH loc_oAba.txt_4c_Fat1ValC
4662:             .ControlSource = "crSigCnFNf.cfat1val"
4663:             .Top = 37
4664:             .Left = 214
4665:             .Width = 41
4666:             .Height = 18
4667:             .FontName = "Tahoma"
4668:             .FontSize = 8
4669:             .SpecialEffect = 1
4670:             .Format = "K"
4671:             .InputMask = "999.99"
4672:             .Visible = .T.
4673:         ENDWITH
4674:         loc_oAba.AddObject("txt_4c_Fat1VecL", "TextBox")
4675:         WITH loc_oAba.txt_4c_Fat1VecL
4676:             .ControlSource = "crSigCnFNf.lfat1vec"
4677:             .Top = 37
4678:             .Left = 273
4679:             .Width = 41
4680:             .Height = 18
4681:             .FontName = "Tahoma"
4682:             .FontSize = 8
4683:             .SpecialEffect = 1
4684:             .Format = "K"
4685:             .InputMask = "999.99"
4686:             .Visible = .T.
4687:         ENDWITH
4688:         loc_oAba.AddObject("lbl_4c_F1EX", "Label")
4689:         WITH loc_oAba.lbl_4c_F1EX
4690:             .Caption = "x"
4691:             .Top = 39

*-- Linhas 4699 a 4717:
4699:         ENDWITH
4700:         loc_oAba.AddObject("txt_4c_Fat1VecC", "TextBox")
4701:         WITH loc_oAba.txt_4c_Fat1VecC
4702:             .ControlSource = "crSigCnFNf.cfat1vec"
4703:             .Top = 37
4704:             .Left = 322
4705:             .Width = 41
4706:             .Height = 18
4707:             .FontName = "Tahoma"
4708:             .FontSize = 8
4709:             .SpecialEffect = 1
4710:             .Format = "K"
4711:             .InputMask = "999.99"
4712:             .Visible = .T.
4713:         ENDWITH
4714: 
4715:         *-- Fatura 2 (top=56/58)
4716:         loc_oAba.AddObject("lbl_4c_Fat2", "Label")
4717:         WITH loc_oAba.lbl_4c_Fat2

*-- Linhas 4727 a 4745:
4727:         ENDWITH
4728:         loc_oAba.AddObject("txt_4c_Fat2NumL", "TextBox")
4729:         WITH loc_oAba.txt_4c_Fat2NumL
4730:             .ControlSource = "crSigCnFNf.lfat2num"
4731:             .Top = 56
4732:             .Left = 58
4733:             .Width = 41
4734:             .Height = 18
4735:             .FontName = "Tahoma"
4736:             .FontSize = 8
4737:             .SpecialEffect = 1
4738:             .Format = "K"
4739:             .InputMask = "999.99"
4740:             .Visible = .T.
4741:         ENDWITH
4742:         loc_oAba.AddObject("lbl_4c_F2NX", "Label")
4743:         WITH loc_oAba.lbl_4c_F2NX
4744:             .Caption = "x"
4745:             .Top = 58

*-- Linhas 4753 a 4785:
4753:         ENDWITH
4754:         loc_oAba.AddObject("txt_4c_Fat2NumC", "TextBox")
4755:         WITH loc_oAba.txt_4c_Fat2NumC
4756:             .ControlSource = "crSigCnFNf.cfat2num"
4757:             .Top = 56
4758:             .Left = 107
4759:             .Width = 41
4760:             .Height = 18
4761:             .FontName = "Tahoma"
4762:             .FontSize = 8
4763:             .SpecialEffect = 1
4764:             .Format = "K"
4765:             .InputMask = "999.99"
4766:             .Visible = .T.
4767:         ENDWITH
4768:         loc_oAba.AddObject("txt_4c_Fat2ValL", "TextBox")
4769:         WITH loc_oAba.txt_4c_Fat2ValL
4770:             .ControlSource = "crSigCnFNf.lfat2val"
4771:             .Top = 56
4772:             .Left = 165
4773:             .Width = 41
4774:             .Height = 18
4775:             .FontName = "Tahoma"
4776:             .FontSize = 8
4777:             .SpecialEffect = 1
4778:             .Format = "K"
4779:             .InputMask = "999.99"
4780:             .Visible = .T.
4781:         ENDWITH
4782:         loc_oAba.AddObject("lbl_4c_F2VX", "Label")
4783:         WITH loc_oAba.lbl_4c_F2VX
4784:             .Caption = "x"
4785:             .Top = 58

*-- Linhas 4793 a 4825:
4793:         ENDWITH
4794:         loc_oAba.AddObject("txt_4c_Fat2ValC", "TextBox")
4795:         WITH loc_oAba.txt_4c_Fat2ValC
4796:             .ControlSource = "crSigCnFNf.cfat2val"
4797:             .Top = 56
4798:             .Left = 214
4799:             .Width = 41
4800:             .Height = 18
4801:             .FontName = "Tahoma"
4802:             .FontSize = 8
4803:             .SpecialEffect = 1
4804:             .Format = "K"
4805:             .InputMask = "999.99"
4806:             .Visible = .T.
4807:         ENDWITH
4808:         loc_oAba.AddObject("txt_4c_Fat2VecL", "TextBox")
4809:         WITH loc_oAba.txt_4c_Fat2VecL
4810:             .ControlSource = "crSigCnFNf.lfat2vec"
4811:             .Top = 56
4812:             .Left = 273
4813:             .Width = 41
4814:             .Height = 18
4815:             .FontName = "Tahoma"
4816:             .FontSize = 8
4817:             .SpecialEffect = 1
4818:             .Format = "K"
4819:             .InputMask = "999.99"
4820:             .Visible = .T.
4821:         ENDWITH
4822:         loc_oAba.AddObject("lbl_4c_F2EX", "Label")
4823:         WITH loc_oAba.lbl_4c_F2EX
4824:             .Caption = "x"
4825:             .Top = 58

*-- Linhas 4833 a 4851:
4833:         ENDWITH
4834:         loc_oAba.AddObject("txt_4c_Fat2VecC", "TextBox")
4835:         WITH loc_oAba.txt_4c_Fat2VecC
4836:             .ControlSource = "crSigCnFNf.cfat2vec"
4837:             .Top = 56
4838:             .Left = 322
4839:             .Width = 41
4840:             .Height = 18
4841:             .FontName = "Tahoma"
4842:             .FontSize = 8
4843:             .SpecialEffect = 1
4844:             .Format = "K"
4845:             .InputMask = "999.99"
4846:             .Visible = .T.
4847:         ENDWITH
4848: 
4849:         *-- Fatura 3 (top=75/77)
4850:         loc_oAba.AddObject("lbl_4c_Fat3", "Label")
4851:         WITH loc_oAba.lbl_4c_Fat3

*-- Linhas 4861 a 4879:
4861:         ENDWITH
4862:         loc_oAba.AddObject("txt_4c_Fat3NumL", "TextBox")
4863:         WITH loc_oAba.txt_4c_Fat3NumL
4864:             .ControlSource = "crSigCnFNf.lfat3num"
4865:             .Top = 75
4866:             .Left = 58
4867:             .Width = 41
4868:             .Height = 18
4869:             .FontName = "Tahoma"
4870:             .FontSize = 8
4871:             .SpecialEffect = 1
4872:             .Format = "K"
4873:             .InputMask = "999.99"
4874:             .Visible = .T.
4875:         ENDWITH
4876:         loc_oAba.AddObject("lbl_4c_F3NX", "Label")
4877:         WITH loc_oAba.lbl_4c_F3NX
4878:             .Caption = "x"
4879:             .Top = 77

*-- Linhas 4887 a 4919:
4887:         ENDWITH
4888:         loc_oAba.AddObject("txt_4c_Fat3NumC", "TextBox")
4889:         WITH loc_oAba.txt_4c_Fat3NumC
4890:             .ControlSource = "crSigCnFNf.cfat3num"
4891:             .Top = 75
4892:             .Left = 107
4893:             .Width = 41
4894:             .Height = 18
4895:             .FontName = "Tahoma"
4896:             .FontSize = 8
4897:             .SpecialEffect = 1
4898:             .Format = "K"
4899:             .InputMask = "999.99"
4900:             .Visible = .T.
4901:         ENDWITH
4902:         loc_oAba.AddObject("txt_4c_Fat3ValL", "TextBox")
4903:         WITH loc_oAba.txt_4c_Fat3ValL
4904:             .ControlSource = "crSigCnFNf.lfat3val"
4905:             .Top = 75
4906:             .Left = 165
4907:             .Width = 41
4908:             .Height = 18
4909:             .FontName = "Tahoma"
4910:             .FontSize = 8
4911:             .SpecialEffect = 1
4912:             .Format = "K"
4913:             .InputMask = "999.99"
4914:             .Visible = .T.
4915:         ENDWITH
4916:         loc_oAba.AddObject("lbl_4c_F3VX", "Label")
4917:         WITH loc_oAba.lbl_4c_F3VX
4918:             .Caption = "x"
4919:             .Top = 77

*-- Linhas 4927 a 4959:
4927:         ENDWITH
4928:         loc_oAba.AddObject("txt_4c_Fat3ValC", "TextBox")
4929:         WITH loc_oAba.txt_4c_Fat3ValC
4930:             .ControlSource = "crSigCnFNf.cfat3val"
4931:             .Top = 75
4932:             .Left = 214
4933:             .Width = 41
4934:             .Height = 18
4935:             .FontName = "Tahoma"
4936:             .FontSize = 8
4937:             .SpecialEffect = 1
4938:             .Format = "K"
4939:             .InputMask = "999.99"
4940:             .Visible = .T.
4941:         ENDWITH
4942:         loc_oAba.AddObject("txt_4c_Fat3VecL", "TextBox")
4943:         WITH loc_oAba.txt_4c_Fat3VecL
4944:             .ControlSource = "crSigCnFNf.lfat3vec"
4945:             .Top = 75
4946:             .Left = 273
4947:             .Width = 41
4948:             .Height = 18
4949:             .FontName = "Tahoma"
4950:             .FontSize = 8
4951:             .SpecialEffect = 1
4952:             .Format = "K"
4953:             .InputMask = "999.99"
4954:             .Visible = .T.
4955:         ENDWITH
4956:         loc_oAba.AddObject("lbl_4c_F3EX", "Label")
4957:         WITH loc_oAba.lbl_4c_F3EX
4958:             .Caption = "x"
4959:             .Top = 77

*-- Linhas 4967 a 4985:
4967:         ENDWITH
4968:         loc_oAba.AddObject("txt_4c_Fat3VecC", "TextBox")
4969:         WITH loc_oAba.txt_4c_Fat3VecC
4970:             .ControlSource = "crSigCnFNf.cfat3vec"
4971:             .Top = 75
4972:             .Left = 322
4973:             .Width = 41
4974:             .Height = 18
4975:             .FontName = "Tahoma"
4976:             .FontSize = 8
4977:             .SpecialEffect = 1
4978:             .Format = "K"
4979:             .InputMask = "999.99"
4980:             .Visible = .T.
4981:         ENDWITH
4982: 
4983:         *-- Fatura 4 (top=94/96)
4984:         loc_oAba.AddObject("lbl_4c_Fat4", "Label")
4985:         WITH loc_oAba.lbl_4c_Fat4

*-- Linhas 4995 a 5013:
4995:         ENDWITH
4996:         loc_oAba.AddObject("txt_4c_Fat4NumL", "TextBox")
4997:         WITH loc_oAba.txt_4c_Fat4NumL
4998:             .ControlSource = "crSigCnFNf.lfat4num"
4999:             .Top = 94
5000:             .Left = 58
5001:             .Width = 41
5002:             .Height = 18
5003:             .FontName = "Tahoma"
5004:             .FontSize = 8
5005:             .SpecialEffect = 1
5006:             .Format = "K"
5007:             .InputMask = "999.99"
5008:             .Visible = .T.
5009:         ENDWITH
5010:         loc_oAba.AddObject("lbl_4c_F4NX", "Label")
5011:         WITH loc_oAba.lbl_4c_F4NX
5012:             .Caption = "x"
5013:             .Top = 96

*-- Linhas 5021 a 5053:
5021:         ENDWITH
5022:         loc_oAba.AddObject("txt_4c_Fat4NumC", "TextBox")
5023:         WITH loc_oAba.txt_4c_Fat4NumC
5024:             .ControlSource = "crSigCnFNf.cfat4num"
5025:             .Top = 94
5026:             .Left = 107
5027:             .Width = 41
5028:             .Height = 18
5029:             .FontName = "Tahoma"
5030:             .FontSize = 8
5031:             .SpecialEffect = 1
5032:             .Format = "K"
5033:             .InputMask = "999.99"
5034:             .Visible = .T.
5035:         ENDWITH
5036:         loc_oAba.AddObject("txt_4c_Fat4ValL", "TextBox")
5037:         WITH loc_oAba.txt_4c_Fat4ValL
5038:             .ControlSource = "crSigCnFNf.lfat4val"
5039:             .Top = 94
5040:             .Left = 165
5041:             .Width = 41
5042:             .Height = 18
5043:             .FontName = "Tahoma"
5044:             .FontSize = 8
5045:             .SpecialEffect = 1
5046:             .Format = "K"
5047:             .InputMask = "999.99"
5048:             .Visible = .T.
5049:         ENDWITH
5050:         loc_oAba.AddObject("lbl_4c_F4VX", "Label")
5051:         WITH loc_oAba.lbl_4c_F4VX
5052:             .Caption = "x"
5053:             .Top = 96

*-- Linhas 5061 a 5093:
5061:         ENDWITH
5062:         loc_oAba.AddObject("txt_4c_Fat4ValC", "TextBox")
5063:         WITH loc_oAba.txt_4c_Fat4ValC
5064:             .ControlSource = "crSigCnFNf.cfat4val"
5065:             .Top = 94
5066:             .Left = 214
5067:             .Width = 41
5068:             .Height = 18
5069:             .FontName = "Tahoma"
5070:             .FontSize = 8
5071:             .SpecialEffect = 1
5072:             .Format = "K"
5073:             .InputMask = "999.99"
5074:             .Visible = .T.
5075:         ENDWITH
5076:         loc_oAba.AddObject("txt_4c_Fat4VecL", "TextBox")
5077:         WITH loc_oAba.txt_4c_Fat4VecL
5078:             .ControlSource = "crSigCnFNf.lfat4vec"
5079:             .Top = 94
5080:             .Left = 273
5081:             .Width = 41
5082:             .Height = 18
5083:             .FontName = "Tahoma"
5084:             .FontSize = 8
5085:             .SpecialEffect = 1
5086:             .Format = "K"
5087:             .InputMask = "999.99"
5088:             .Visible = .T.
5089:         ENDWITH
5090:         loc_oAba.AddObject("lbl_4c_F4EX", "Label")
5091:         WITH loc_oAba.lbl_4c_F4EX
5092:             .Caption = "x"
5093:             .Top = 96

*-- Linhas 5101 a 5119:
5101:         ENDWITH
5102:         loc_oAba.AddObject("txt_4c_Fat4VecC", "TextBox")
5103:         WITH loc_oAba.txt_4c_Fat4VecC
5104:             .ControlSource = "crSigCnFNf.cfat4vec"
5105:             .Top = 94
5106:             .Left = 322
5107:             .Width = 41
5108:             .Height = 18
5109:             .FontName = "Tahoma"
5110:             .FontSize = 8
5111:             .SpecialEffect = 1
5112:             .Format = "K"
5113:             .InputMask = "999.99"
5114:             .Visible = .T.
5115:         ENDWITH
5116: 
5117:         *-- Fatura 5 (top=113/115)
5118:         loc_oAba.AddObject("lbl_4c_Fat5", "Label")
5119:         WITH loc_oAba.lbl_4c_Fat5

*-- Linhas 5129 a 5147:
5129:         ENDWITH
5130:         loc_oAba.AddObject("txt_4c_Fat5NumL", "TextBox")
5131:         WITH loc_oAba.txt_4c_Fat5NumL
5132:             .ControlSource = "crSigCnFNf.lfat5num"
5133:             .Top = 113
5134:             .Left = 58
5135:             .Width = 41
5136:             .Height = 18
5137:             .FontName = "Tahoma"
5138:             .FontSize = 8
5139:             .SpecialEffect = 1
5140:             .Format = "K"
5141:             .InputMask = "999.99"
5142:             .Visible = .T.
5143:         ENDWITH
5144:         loc_oAba.AddObject("lbl_4c_F5NX", "Label")
5145:         WITH loc_oAba.lbl_4c_F5NX
5146:             .Caption = "x"
5147:             .Top = 115

*-- Linhas 5155 a 5187:
5155:         ENDWITH
5156:         loc_oAba.AddObject("txt_4c_Fat5NumC", "TextBox")
5157:         WITH loc_oAba.txt_4c_Fat5NumC
5158:             .ControlSource = "crSigCnFNf.cfat5num"
5159:             .Top = 113
5160:             .Left = 107
5161:             .Width = 41
5162:             .Height = 18
5163:             .FontName = "Tahoma"
5164:             .FontSize = 8
5165:             .SpecialEffect = 1
5166:             .Format = "K"
5167:             .InputMask = "999.99"
5168:             .Visible = .T.
5169:         ENDWITH
5170:         loc_oAba.AddObject("txt_4c_Fat5ValL", "TextBox")
5171:         WITH loc_oAba.txt_4c_Fat5ValL
5172:             .ControlSource = "crSigCnFNf.lfat5val"
5173:             .Top = 113
5174:             .Left = 165
5175:             .Width = 41
5176:             .Height = 18
5177:             .FontName = "Tahoma"
5178:             .FontSize = 8
5179:             .SpecialEffect = 1
5180:             .Format = "K"
5181:             .InputMask = "999.99"
5182:             .Visible = .T.
5183:         ENDWITH
5184:         loc_oAba.AddObject("lbl_4c_F5VX", "Label")
5185:         WITH loc_oAba.lbl_4c_F5VX
5186:             .Caption = "x"
5187:             .Top = 115

*-- Linhas 5195 a 5227:
5195:         ENDWITH
5196:         loc_oAba.AddObject("txt_4c_Fat5ValC", "TextBox")
5197:         WITH loc_oAba.txt_4c_Fat5ValC
5198:             .ControlSource = "crSigCnFNf.cfat5val"
5199:             .Top = 113
5200:             .Left = 214
5201:             .Width = 41
5202:             .Height = 18
5203:             .FontName = "Tahoma"
5204:             .FontSize = 8
5205:             .SpecialEffect = 1
5206:             .Format = "K"
5207:             .InputMask = "999.99"
5208:             .Visible = .T.
5209:         ENDWITH
5210:         loc_oAba.AddObject("txt_4c_Fat5VecL", "TextBox")
5211:         WITH loc_oAba.txt_4c_Fat5VecL
5212:             .ControlSource = "crSigCnFNf.lfat5vec"
5213:             .Top = 113
5214:             .Left = 273
5215:             .Width = 41
5216:             .Height = 18
5217:             .FontName = "Tahoma"
5218:             .FontSize = 8
5219:             .SpecialEffect = 1
5220:             .Format = "K"
5221:             .InputMask = "999.99"
5222:             .Visible = .T.
5223:         ENDWITH
5224:         loc_oAba.AddObject("lbl_4c_F5EX", "Label")
5225:         WITH loc_oAba.lbl_4c_F5EX
5226:             .Caption = "x"
5227:             .Top = 115

*-- Linhas 5235 a 5253:
5235:         ENDWITH
5236:         loc_oAba.AddObject("txt_4c_Fat5VecC", "TextBox")
5237:         WITH loc_oAba.txt_4c_Fat5VecC
5238:             .ControlSource = "crSigCnFNf.cfat5vec"
5239:             .Top = 113
5240:             .Left = 322
5241:             .Width = 41
5242:             .Height = 18
5243:             .FontName = "Tahoma"
5244:             .FontSize = 8
5245:             .SpecialEffect = 1
5246:             .Format = "K"
5247:             .InputMask = "999.99"
5248:             .Visible = .T.
5249:         ENDWITH
5250: 
5251:         *-- Fatura 6 (top=132/134)
5252:         loc_oAba.AddObject("lbl_4c_Fat6", "Label")
5253:         WITH loc_oAba.lbl_4c_Fat6

*-- Linhas 5263 a 5281:
5263:         ENDWITH
5264:         loc_oAba.AddObject("txt_4c_Fat6NumL", "TextBox")
5265:         WITH loc_oAba.txt_4c_Fat6NumL
5266:             .ControlSource = "crSigCnFNf.lfat6num"
5267:             .Top = 132
5268:             .Left = 58
5269:             .Width = 41
5270:             .Height = 18
5271:             .FontName = "Tahoma"
5272:             .FontSize = 8
5273:             .SpecialEffect = 1
5274:             .Format = "K"
5275:             .InputMask = "999.99"
5276:             .Visible = .T.
5277:         ENDWITH
5278:         loc_oAba.AddObject("lbl_4c_F6NX", "Label")
5279:         WITH loc_oAba.lbl_4c_F6NX
5280:             .Caption = "x"
5281:             .Top = 134

*-- Linhas 5289 a 5321:
5289:         ENDWITH
5290:         loc_oAba.AddObject("txt_4c_Fat6NumC", "TextBox")
5291:         WITH loc_oAba.txt_4c_Fat6NumC
5292:             .ControlSource = "crSigCnFNf.cfat6num"
5293:             .Top = 132
5294:             .Left = 107
5295:             .Width = 41
5296:             .Height = 18
5297:             .FontName = "Tahoma"
5298:             .FontSize = 8
5299:             .SpecialEffect = 1
5300:             .Format = "K"
5301:             .InputMask = "999.99"
5302:             .Visible = .T.
5303:         ENDWITH
5304:         loc_oAba.AddObject("txt_4c_Fat6ValL", "TextBox")
5305:         WITH loc_oAba.txt_4c_Fat6ValL
5306:             .ControlSource = "crSigCnFNf.lfat6val"
5307:             .Top = 132
5308:             .Left = 165
5309:             .Width = 41
5310:             .Height = 18
5311:             .FontName = "Tahoma"
5312:             .FontSize = 8
5313:             .SpecialEffect = 1
5314:             .Format = "K"
5315:             .InputMask = "999.99"
5316:             .Visible = .T.
5317:         ENDWITH
5318:         loc_oAba.AddObject("lbl_4c_F6VX", "Label")
5319:         WITH loc_oAba.lbl_4c_F6VX
5320:             .Caption = "x"
5321:             .Top = 134

*-- Linhas 5329 a 5361:
5329:         ENDWITH
5330:         loc_oAba.AddObject("txt_4c_Fat6ValC", "TextBox")
5331:         WITH loc_oAba.txt_4c_Fat6ValC
5332:             .ControlSource = "crSigCnFNf.cfat6val"
5333:             .Top = 132
5334:             .Left = 214
5335:             .Width = 41
5336:             .Height = 18
5337:             .FontName = "Tahoma"
5338:             .FontSize = 8
5339:             .SpecialEffect = 1
5340:             .Format = "K"
5341:             .InputMask = "999.99"
5342:             .Visible = .T.
5343:         ENDWITH
5344:         loc_oAba.AddObject("txt_4c_Fat6VecL", "TextBox")
5345:         WITH loc_oAba.txt_4c_Fat6VecL
5346:             .ControlSource = "crSigCnFNf.lfat6vec"
5347:             .Top = 132
5348:             .Left = 273
5349:             .Width = 41
5350:             .Height = 18
5351:             .FontName = "Tahoma"
5352:             .FontSize = 8
5353:             .SpecialEffect = 1
5354:             .Format = "K"
5355:             .InputMask = "999.99"
5356:             .Visible = .T.
5357:         ENDWITH
5358:         loc_oAba.AddObject("lbl_4c_F6EX", "Label")
5359:         WITH loc_oAba.lbl_4c_F6EX
5360:             .Caption = "x"
5361:             .Top = 134

*-- Linhas 5369 a 5387:
5369:         ENDWITH
5370:         loc_oAba.AddObject("txt_4c_Fat6VecC", "TextBox")
5371:         WITH loc_oAba.txt_4c_Fat6VecC
5372:             .ControlSource = "crSigCnFNf.cfat6vec"
5373:             .Top = 132
5374:             .Left = 322
5375:             .Width = 41
5376:             .Height = 18
5377:             .FontName = "Tahoma"
5378:             .FontSize = 8
5379:             .SpecialEffect = 1
5380:             .Format = "K"
5381:             .InputMask = "999.99"
5382:             .Visible = .T.
5383:         ENDWITH
5384: 
5385:         *-- Fatura 7 (top=151/153)
5386:         loc_oAba.AddObject("lbl_4c_Fat7", "Label")
5387:         WITH loc_oAba.lbl_4c_Fat7

*-- Linhas 5397 a 5415:
5397:         ENDWITH
5398:         loc_oAba.AddObject("txt_4c_Fat7NumL", "TextBox")
5399:         WITH loc_oAba.txt_4c_Fat7NumL
5400:             .ControlSource = "crSigCnFNf.lfat7num"
5401:             .Top = 151
5402:             .Left = 58
5403:             .Width = 41
5404:             .Height = 18
5405:             .FontName = "Tahoma"
5406:             .FontSize = 8
5407:             .SpecialEffect = 1
5408:             .Format = "K"
5409:             .InputMask = "999.99"
5410:             .Visible = .T.
5411:         ENDWITH
5412:         loc_oAba.AddObject("lbl_4c_F7NX", "Label")
5413:         WITH loc_oAba.lbl_4c_F7NX
5414:             .Caption = "x"
5415:             .Top = 153

*-- Linhas 5423 a 5455:
5423:         ENDWITH
5424:         loc_oAba.AddObject("txt_4c_Fat7NumC", "TextBox")
5425:         WITH loc_oAba.txt_4c_Fat7NumC
5426:             .ControlSource = "crSigCnFNf.cfat7num"
5427:             .Top = 151
5428:             .Left = 107
5429:             .Width = 41
5430:             .Height = 18
5431:             .FontName = "Tahoma"
5432:             .FontSize = 8
5433:             .SpecialEffect = 1
5434:             .Format = "K"
5435:             .InputMask = "999.99"
5436:             .Visible = .T.
5437:         ENDWITH
5438:         loc_oAba.AddObject("txt_4c_Fat7ValL", "TextBox")
5439:         WITH loc_oAba.txt_4c_Fat7ValL
5440:             .ControlSource = "crSigCnFNf.lfat7val"
5441:             .Top = 151
5442:             .Left = 165
5443:             .Width = 41
5444:             .Height = 18
5445:             .FontName = "Tahoma"
5446:             .FontSize = 8
5447:             .SpecialEffect = 1
5448:             .Format = "K"
5449:             .InputMask = "999.99"
5450:             .Visible = .T.
5451:         ENDWITH
5452:         loc_oAba.AddObject("lbl_4c_F7VX", "Label")
5453:         WITH loc_oAba.lbl_4c_F7VX
5454:             .Caption = "x"
5455:             .Top = 153

*-- Linhas 5463 a 5495:
5463:         ENDWITH
5464:         loc_oAba.AddObject("txt_4c_Fat7ValC", "TextBox")
5465:         WITH loc_oAba.txt_4c_Fat7ValC
5466:             .ControlSource = "crSigCnFNf.cfat7val"
5467:             .Top = 151
5468:             .Left = 214
5469:             .Width = 41
5470:             .Height = 18
5471:             .FontName = "Tahoma"
5472:             .FontSize = 8
5473:             .SpecialEffect = 1
5474:             .Format = "K"
5475:             .InputMask = "999.99"
5476:             .Visible = .T.
5477:         ENDWITH
5478:         loc_oAba.AddObject("txt_4c_Fat7VecL", "TextBox")
5479:         WITH loc_oAba.txt_4c_Fat7VecL
5480:             .ControlSource = "crSigCnFNf.lfat7vec"
5481:             .Top = 151
5482:             .Left = 273
5483:             .Width = 41
5484:             .Height = 18
5485:             .FontName = "Tahoma"
5486:             .FontSize = 8
5487:             .SpecialEffect = 1
5488:             .Format = "K"
5489:             .InputMask = "999.99"
5490:             .Visible = .T.
5491:         ENDWITH
5492:         loc_oAba.AddObject("lbl_4c_F7EX", "Label")
5493:         WITH loc_oAba.lbl_4c_F7EX
5494:             .Caption = "x"
5495:             .Top = 153

*-- Linhas 5503 a 5521:
5503:         ENDWITH
5504:         loc_oAba.AddObject("txt_4c_Fat7VecC", "TextBox")
5505:         WITH loc_oAba.txt_4c_Fat7VecC
5506:             .ControlSource = "crSigCnFNf.cfat7vec"
5507:             .Top = 151
5508:             .Left = 322
5509:             .Width = 41
5510:             .Height = 18
5511:             .FontName = "Tahoma"
5512:             .FontSize = 8
5513:             .SpecialEffect = 1
5514:             .Format = "K"
5515:             .InputMask = "999.99"
5516:             .Visible = .T.
5517:         ENDWITH
5518: 
5519:         *-- Fatura 8 (top=170/172)
5520:         loc_oAba.AddObject("lbl_4c_Fat8", "Label")
5521:         WITH loc_oAba.lbl_4c_Fat8

*-- Linhas 5531 a 5549:
5531:         ENDWITH
5532:         loc_oAba.AddObject("txt_4c_Fat8NumL", "TextBox")
5533:         WITH loc_oAba.txt_4c_Fat8NumL
5534:             .ControlSource = "crSigCnFNf.lfat8num"
5535:             .Top = 170
5536:             .Left = 58
5537:             .Width = 41
5538:             .Height = 18
5539:             .FontName = "Tahoma"
5540:             .FontSize = 8
5541:             .SpecialEffect = 1
5542:             .Format = "K"
5543:             .InputMask = "999.99"
5544:             .Visible = .T.
5545:         ENDWITH
5546:         loc_oAba.AddObject("lbl_4c_F8NX", "Label")
5547:         WITH loc_oAba.lbl_4c_F8NX
5548:             .Caption = "x"
5549:             .Top = 172

*-- Linhas 5557 a 5589:
5557:         ENDWITH
5558:         loc_oAba.AddObject("txt_4c_Fat8NumC", "TextBox")
5559:         WITH loc_oAba.txt_4c_Fat8NumC
5560:             .ControlSource = "crSigCnFNf.cfat8num"
5561:             .Top = 170
5562:             .Left = 107
5563:             .Width = 41
5564:             .Height = 18
5565:             .FontName = "Tahoma"
5566:             .FontSize = 8
5567:             .SpecialEffect = 1
5568:             .Format = "K"
5569:             .InputMask = "999.99"
5570:             .Visible = .T.
5571:         ENDWITH
5572:         loc_oAba.AddObject("txt_4c_Fat8ValL", "TextBox")
5573:         WITH loc_oAba.txt_4c_Fat8ValL
5574:             .ControlSource = "crSigCnFNf.lfat8val"
5575:             .Top = 170
5576:             .Left = 165
5577:             .Width = 41
5578:             .Height = 18
5579:             .FontName = "Tahoma"
5580:             .FontSize = 8
5581:             .SpecialEffect = 1
5582:             .Format = "K"
5583:             .InputMask = "999.99"
5584:             .Visible = .T.
5585:         ENDWITH
5586:         loc_oAba.AddObject("lbl_4c_F8VX", "Label")
5587:         WITH loc_oAba.lbl_4c_F8VX
5588:             .Caption = "x"
5589:             .Top = 172

*-- Linhas 5597 a 5629:
5597:         ENDWITH
5598:         loc_oAba.AddObject("txt_4c_Fat8ValC", "TextBox")
5599:         WITH loc_oAba.txt_4c_Fat8ValC
5600:             .ControlSource = "crSigCnFNf.cfat8val"
5601:             .Top = 170
5602:             .Left = 214
5603:             .Width = 41
5604:             .Height = 18
5605:             .FontName = "Tahoma"
5606:             .FontSize = 8
5607:             .SpecialEffect = 1
5608:             .Format = "K"
5609:             .InputMask = "999.99"
5610:             .Visible = .T.
5611:         ENDWITH
5612:         loc_oAba.AddObject("txt_4c_Fat8VecL", "TextBox")
5613:         WITH loc_oAba.txt_4c_Fat8VecL
5614:             .ControlSource = "crSigCnFNf.lfat8vec"
5615:             .Top = 170
5616:             .Left = 273
5617:             .Width = 41
5618:             .Height = 18
5619:             .FontName = "Tahoma"
5620:             .FontSize = 8
5621:             .SpecialEffect = 1
5622:             .Format = "K"
5623:             .InputMask = "999.99"
5624:             .Visible = .T.
5625:         ENDWITH
5626:         loc_oAba.AddObject("lbl_4c_F8EX", "Label")
5627:         WITH loc_oAba.lbl_4c_F8EX
5628:             .Caption = "x"
5629:             .Top = 172

*-- Linhas 5637 a 5655:
5637:         ENDWITH
5638:         loc_oAba.AddObject("txt_4c_Fat8VecC", "TextBox")
5639:         WITH loc_oAba.txt_4c_Fat8VecC
5640:             .ControlSource = "crSigCnFNf.cfat8vec"
5641:             .Top = 170
5642:             .Left = 322
5643:             .Width = 41
5644:             .Height = 18
5645:             .FontName = "Tahoma"
5646:             .FontSize = 8
5647:             .SpecialEffect = 1
5648:             .Format = "K"
5649:             .InputMask = "999.99"
5650:             .Visible = .T.
5651:         ENDWITH
5652: 
5653:         *-- Fatura 9 (top=189/191)
5654:         loc_oAba.AddObject("lbl_4c_Fat9", "Label")
5655:         WITH loc_oAba.lbl_4c_Fat9

*-- Linhas 5665 a 5683:
5665:         ENDWITH
5666:         loc_oAba.AddObject("txt_4c_Fat9NumL", "TextBox")
5667:         WITH loc_oAba.txt_4c_Fat9NumL
5668:             .ControlSource = "crSigCnFNf.lfat9num"
5669:             .Top = 189
5670:             .Left = 58
5671:             .Width = 41
5672:             .Height = 18
5673:             .FontName = "Tahoma"
5674:             .FontSize = 8
5675:             .SpecialEffect = 1
5676:             .Format = "K"
5677:             .InputMask = "999.99"
5678:             .Visible = .T.
5679:         ENDWITH
5680:         loc_oAba.AddObject("lbl_4c_F9NX", "Label")
5681:         WITH loc_oAba.lbl_4c_F9NX
5682:             .Caption = "x"
5683:             .Top = 191

*-- Linhas 5691 a 5723:
5691:         ENDWITH
5692:         loc_oAba.AddObject("txt_4c_Fat9NumC", "TextBox")
5693:         WITH loc_oAba.txt_4c_Fat9NumC
5694:             .ControlSource = "crSigCnFNf.cfat9num"
5695:             .Top = 189
5696:             .Left = 107
5697:             .Width = 41
5698:             .Height = 18
5699:             .FontName = "Tahoma"
5700:             .FontSize = 8
5701:             .SpecialEffect = 1
5702:             .Format = "K"
5703:             .InputMask = "999.99"
5704:             .Visible = .T.
5705:         ENDWITH
5706:         loc_oAba.AddObject("txt_4c_Fat9ValL", "TextBox")
5707:         WITH loc_oAba.txt_4c_Fat9ValL
5708:             .ControlSource = "crSigCnFNf.lfat9val"
5709:             .Top = 189
5710:             .Left = 165
5711:             .Width = 41
5712:             .Height = 18
5713:             .FontName = "Tahoma"
5714:             .FontSize = 8
5715:             .SpecialEffect = 1
5716:             .Format = "K"
5717:             .InputMask = "999.99"
5718:             .Visible = .T.
5719:         ENDWITH
5720:         loc_oAba.AddObject("lbl_4c_F9VX", "Label")
5721:         WITH loc_oAba.lbl_4c_F9VX
5722:             .Caption = "x"
5723:             .Top = 191

*-- Linhas 5731 a 5763:
5731:         ENDWITH
5732:         loc_oAba.AddObject("txt_4c_Fat9ValC", "TextBox")
5733:         WITH loc_oAba.txt_4c_Fat9ValC
5734:             .ControlSource = "crSigCnFNf.cfat9val"
5735:             .Top = 189
5736:             .Left = 214
5737:             .Width = 41
5738:             .Height = 18
5739:             .FontName = "Tahoma"
5740:             .FontSize = 8
5741:             .SpecialEffect = 1
5742:             .Format = "K"
5743:             .InputMask = "999.99"
5744:             .Visible = .T.
5745:         ENDWITH
5746:         loc_oAba.AddObject("txt_4c_Fat9VecL", "TextBox")
5747:         WITH loc_oAba.txt_4c_Fat9VecL
5748:             .ControlSource = "crSigCnFNf.lfat9vec"
5749:             .Top = 189
5750:             .Left = 273
5751:             .Width = 41
5752:             .Height = 18
5753:             .FontName = "Tahoma"
5754:             .FontSize = 8
5755:             .SpecialEffect = 1
5756:             .Format = "K"
5757:             .InputMask = "999.99"
5758:             .Visible = .T.
5759:         ENDWITH
5760:         loc_oAba.AddObject("lbl_4c_F9EX", "Label")
5761:         WITH loc_oAba.lbl_4c_F9EX
5762:             .Caption = "x"
5763:             .Top = 191

*-- Linhas 5771 a 5789:
5771:         ENDWITH
5772:         loc_oAba.AddObject("txt_4c_Fat9VecC", "TextBox")
5773:         WITH loc_oAba.txt_4c_Fat9VecC
5774:             .ControlSource = "crSigCnFNf.cfat9vec"
5775:             .Top = 189
5776:             .Left = 322
5777:             .Width = 41
5778:             .Height = 18
5779:             .FontName = "Tahoma"
5780:             .FontSize = 8
5781:             .SpecialEffect = 1
5782:             .Format = "K"
5783:             .InputMask = "999.99"
5784:             .Visible = .T.
5785:         ENDWITH
5786: 
5787:         *-- Fatura 10 (top=208/210)
5788:         loc_oAba.AddObject("lbl_4c_Fat10", "Label")
5789:         WITH loc_oAba.lbl_4c_Fat10

*-- Linhas 5799 a 5817:
5799:         ENDWITH
5800:         loc_oAba.AddObject("txt_4c_Fat10NumL", "TextBox")
5801:         WITH loc_oAba.txt_4c_Fat10NumL
5802:             .ControlSource = "crSigCnFNf.lfat10num"
5803:             .Top = 208
5804:             .Left = 58
5805:             .Width = 41
5806:             .Height = 18
5807:             .FontName = "Tahoma"
5808:             .FontSize = 8
5809:             .SpecialEffect = 1
5810:             .Format = "K"
5811:             .InputMask = "999.99"
5812:             .Visible = .T.
5813:         ENDWITH
5814:         loc_oAba.AddObject("lbl_4c_F10NX", "Label")
5815:         WITH loc_oAba.lbl_4c_F10NX
5816:             .Caption = "x"
5817:             .Top = 210

*-- Linhas 5825 a 5857:
5825:         ENDWITH
5826:         loc_oAba.AddObject("txt_4c_Fat10NumC", "TextBox")
5827:         WITH loc_oAba.txt_4c_Fat10NumC
5828:             .ControlSource = "crSigCnFNf.cfat10num"
5829:             .Top = 208
5830:             .Left = 107
5831:             .Width = 41
5832:             .Height = 18
5833:             .FontName = "Tahoma"
5834:             .FontSize = 8
5835:             .SpecialEffect = 1
5836:             .Format = "K"
5837:             .InputMask = "999.99"
5838:             .Visible = .T.
5839:         ENDWITH
5840:         loc_oAba.AddObject("txt_4c_Fat10ValL", "TextBox")
5841:         WITH loc_oAba.txt_4c_Fat10ValL
5842:             .ControlSource = "crSigCnFNf.lfat10val"
5843:             .Top = 208
5844:             .Left = 165
5845:             .Width = 41
5846:             .Height = 18
5847:             .FontName = "Tahoma"
5848:             .FontSize = 8
5849:             .SpecialEffect = 1
5850:             .Format = "K"
5851:             .InputMask = "999.99"
5852:             .Visible = .T.
5853:         ENDWITH
5854:         loc_oAba.AddObject("lbl_4c_F10VX", "Label")
5855:         WITH loc_oAba.lbl_4c_F10VX
5856:             .Caption = "x"
5857:             .Top = 210

*-- Linhas 5865 a 5897:
5865:         ENDWITH
5866:         loc_oAba.AddObject("txt_4c_Fat10ValC", "TextBox")
5867:         WITH loc_oAba.txt_4c_Fat10ValC
5868:             .ControlSource = "crSigCnFNf.cfat10val"
5869:             .Top = 208
5870:             .Left = 214
5871:             .Width = 41
5872:             .Height = 18
5873:             .FontName = "Tahoma"
5874:             .FontSize = 8
5875:             .SpecialEffect = 1
5876:             .Format = "K"
5877:             .InputMask = "999.99"
5878:             .Visible = .T.
5879:         ENDWITH
5880:         loc_oAba.AddObject("txt_4c_Fat10VecL", "TextBox")
5881:         WITH loc_oAba.txt_4c_Fat10VecL
5882:             .ControlSource = "crSigCnFNf.lfat10vec"
5883:             .Top = 208
5884:             .Left = 273
5885:             .Width = 41
5886:             .Height = 18
5887:             .FontName = "Tahoma"
5888:             .FontSize = 8
5889:             .SpecialEffect = 1
5890:             .Format = "K"
5891:             .InputMask = "999.99"
5892:             .Visible = .T.
5893:         ENDWITH
5894:         loc_oAba.AddObject("lbl_4c_F10EX", "Label")
5895:         WITH loc_oAba.lbl_4c_F10EX
5896:             .Caption = "x"
5897:             .Top = 210

*-- Linhas 5905 a 5923:
5905:         ENDWITH
5906:         loc_oAba.AddObject("txt_4c_Fat10VecC", "TextBox")
5907:         WITH loc_oAba.txt_4c_Fat10VecC
5908:             .ControlSource = "crSigCnFNf.cfat10vec"
5909:             .Top = 208
5910:             .Left = 322
5911:             .Width = 41
5912:             .Height = 18
5913:             .FontName = "Tahoma"
5914:             .FontSize = 8
5915:             .SpecialEffect = 1
5916:             .Format = "K"
5917:             .InputMask = "999.99"
5918:             .Visible = .T.
5919:         ENDWITH
5920: 
5921:         *-- Endereco de Cobranca (right side, top=25 label at left=395)
5922:         loc_oAba.AddObject("lbl_4c_LblEndCob", "Label")
5923:         WITH loc_oAba.lbl_4c_LblEndCob

*-- Linhas 5934 a 5952:
5934: 
5935:         loc_oAba.AddObject("txt_4c_CobEnderL", "TextBox")
5936:         WITH loc_oAba.txt_4c_CobEnderL
5937:             .ControlSource = "crSigCnFNf.lendcob"
5938:             .Top = 37
5939:             .Left = 395
5940:             .Width = 41
5941:             .Height = 18
5942:             .FontName = "Tahoma"
5943:             .FontSize = 8
5944:             .SpecialEffect = 1
5945:             .Format = "K"
5946:             .InputMask = "999.99"
5947:             .Visible = .T.
5948:         ENDWITH
5949: 
5950:         loc_oAba.AddObject("lbl_4c_CobEX1", "Label")
5951:         WITH loc_oAba.lbl_4c_CobEX1
5952:             .Caption = "x"

*-- Linhas 5962 a 5980:
5962: 
5963:         loc_oAba.AddObject("txt_4c_CobEnderC", "TextBox")
5964:         WITH loc_oAba.txt_4c_CobEnderC
5965:             .ControlSource = "crSigCnFNf.cendcob"
5966:             .Top = 37
5967:             .Left = 444
5968:             .Width = 41
5969:             .Height = 18
5970:             .FontName = "Tahoma"
5971:             .FontSize = 8
5972:             .SpecialEffect = 1
5973:             .Format = "K"
5974:             .InputMask = "999.99"
5975:             .Visible = .T.
5976:         ENDWITH
5977: 
5978:         *-- Cobranca - Bairro (top=25, left=495)
5979:         loc_oAba.AddObject("lbl_4c_LblCobBai", "Label")
5980:         WITH loc_oAba.lbl_4c_LblCobBai

*-- Linhas 5991 a 6009:
5991: 
5992:         loc_oAba.AddObject("txt_4c_CobBairL", "TextBox")
5993:         WITH loc_oAba.txt_4c_CobBairL
5994:             .ControlSource = "crSigCnFNf.lbaicob"
5995:             .Top = 37
5996:             .Left = 495
5997:             .Width = 41
5998:             .Height = 18
5999:             .FontName = "Tahoma"
6000:             .FontSize = 8
6001:             .SpecialEffect = 1
6002:             .Format = "K"
6003:             .InputMask = "999.99"
6004:             .Visible = .T.
6005:         ENDWITH
6006: 
6007:         loc_oAba.AddObject("lbl_4c_CobBX", "Label")
6008:         WITH loc_oAba.lbl_4c_CobBX
6009:             .Caption = "x"

*-- Linhas 6019 a 6037:
6019: 
6020:         loc_oAba.AddObject("txt_4c_CobBairC", "TextBox")
6021:         WITH loc_oAba.txt_4c_CobBairC
6022:             .ControlSource = "crSigCnFNf.cbaicob"
6023:             .Top = 37
6024:             .Left = 544
6025:             .Width = 41
6026:             .Height = 18
6027:             .FontName = "Tahoma"
6028:             .FontSize = 8
6029:             .SpecialEffect = 1
6030:             .Format = "K"
6031:             .InputMask = "999.99"
6032:             .Visible = .T.
6033:         ENDWITH
6034: 
6035:         *-- Cobranca - Municipio (top=61, left=394)
6036:         loc_oAba.AddObject("lbl_4c_LblCobMun", "Label")
6037:         WITH loc_oAba.lbl_4c_LblCobMun

*-- Linhas 6048 a 6066:
6048: 
6049:         loc_oAba.AddObject("txt_4c_CobMuniL", "TextBox")
6050:         WITH loc_oAba.txt_4c_CobMuniL
6051:             .ControlSource = "crSigCnFNf.lmuncob"
6052:             .Top = 73
6053:             .Left = 394
6054:             .Width = 41
6055:             .Height = 18
6056:             .FontName = "Tahoma"
6057:             .FontSize = 8
6058:             .SpecialEffect = 1
6059:             .Format = "K"
6060:             .InputMask = "999.99"
6061:             .Visible = .T.
6062:         ENDWITH
6063: 
6064:         loc_oAba.AddObject("lbl_4c_CobMX", "Label")
6065:         WITH loc_oAba.lbl_4c_CobMX
6066:             .Caption = "x"

*-- Linhas 6076 a 6094:
6076: 
6077:         loc_oAba.AddObject("txt_4c_CobMuniC", "TextBox")
6078:         WITH loc_oAba.txt_4c_CobMuniC
6079:             .ControlSource = "crSigCnFNf.cmuncob"
6080:             .Top = 73
6081:             .Left = 443
6082:             .Width = 41
6083:             .Height = 18
6084:             .FontName = "Tahoma"
6085:             .FontSize = 8
6086:             .SpecialEffect = 1
6087:             .Format = "K"
6088:             .InputMask = "999.99"
6089:             .Visible = .T.
6090:         ENDWITH
6091: 
6092:         *-- Cobranca - Estado (top=61, left=495)
6093:         loc_oAba.AddObject("lbl_4c_LblCobEst", "Label")
6094:         WITH loc_oAba.lbl_4c_LblCobEst

*-- Linhas 6105 a 6123:
6105: 
6106:         loc_oAba.AddObject("txt_4c_CobEstL", "TextBox")
6107:         WITH loc_oAba.txt_4c_CobEstL
6108:             .ControlSource = "crSigCnFNf.lestcob"
6109:             .Top = 73
6110:             .Left = 495
6111:             .Width = 41
6112:             .Height = 18
6113:             .FontName = "Tahoma"
6114:             .FontSize = 8
6115:             .SpecialEffect = 1
6116:             .Format = "K"
6117:             .InputMask = "999.99"
6118:             .Visible = .T.
6119:         ENDWITH
6120: 
6121:         loc_oAba.AddObject("lbl_4c_CobEstX", "Label")
6122:         WITH loc_oAba.lbl_4c_CobEstX
6123:             .Caption = "x"

*-- Linhas 6133 a 6151:
6133: 
6134:         loc_oAba.AddObject("txt_4c_CobEstC", "TextBox")
6135:         WITH loc_oAba.txt_4c_CobEstC
6136:             .ControlSource = "crSigCnFNf.cestcob"
6137:             .Top = 73
6138:             .Left = 544
6139:             .Width = 41
6140:             .Height = 18
6141:             .FontName = "Tahoma"
6142:             .FontSize = 8
6143:             .SpecialEffect = 1
6144:             .Format = "K"
6145:             .InputMask = "999.99"
6146:             .Visible = .T.
6147:         ENDWITH
6148: 
6149:         *-- Cobranca - CEP (top=97, left=394)
6150:         loc_oAba.AddObject("lbl_4c_LblCobCep", "Label")
6151:         WITH loc_oAba.lbl_4c_LblCobCep

*-- Linhas 6162 a 6180:
6162: 
6163:         loc_oAba.AddObject("txt_4c_CobCepL", "TextBox")
6164:         WITH loc_oAba.txt_4c_CobCepL
6165:             .ControlSource = "crSigCnFNf.lcepcob"
6166:             .Top = 109
6167:             .Left = 394
6168:             .Width = 41
6169:             .Height = 18
6170:             .FontName = "Tahoma"
6171:             .FontSize = 8
6172:             .SpecialEffect = 1
6173:             .Format = "K"
6174:             .InputMask = "999.99"
6175:             .Visible = .T.
6176:         ENDWITH
6177: 
6178:         loc_oAba.AddObject("lbl_4c_CobCepX", "Label")
6179:         WITH loc_oAba.lbl_4c_CobCepX
6180:             .Caption = "x"

*-- Linhas 6190 a 6208:
6190: 
6191:         loc_oAba.AddObject("txt_4c_CobCepC", "TextBox")
6192:         WITH loc_oAba.txt_4c_CobCepC
6193:             .ControlSource = "crSigCnFNf.ccepcob"
6194:             .Top = 109
6195:             .Left = 443
6196:             .Width = 41
6197:             .Height = 18
6198:             .FontName = "Tahoma"
6199:             .FontSize = 8
6200:             .SpecialEffect = 1
6201:             .Format = "K"
6202:             .InputMask = "999.99"
6203:             .Visible = .T.
6204:         ENDWITH
6205:     ENDPROC
6206: 
6207:     *--------------------------------------------------------------------------
6208:     PROTECTED PROCEDURE ConfigurarProdutosTab()

*-- Linhas 6225 a 6243:
6225: 
6226:         loc_oAba.AddObject("txt_4c_LinIni", "TextBox")
6227:         WITH loc_oAba.txt_4c_LinIni
6228:             .ControlSource = "crSigCnFNf.linprod"
6229:             .Top           = 24
6230:             .Left          = 153
6231:             .Width         = 41
6232:             .Height        = 18
6233:             .FontName      = "Tahoma"
6234:             .FontSize      = 8
6235:             .SpecialEffect = 1
6236:             .Format        = "K"
6237:             .InputMask     = "999.99"
6238:             .Visible       = .T.
6239:         ENDWITH
6240: 
6241:         *-- Codigo (top=50)
6242:         loc_oAba.AddObject("lbl_4c_LblCodigo", "Label")
6243:         WITH loc_oAba.lbl_4c_LblCodigo

*-- Linhas 6254 a 6272:
6254: 
6255:         loc_oAba.AddObject("txt_4c_ProdCodL", "TextBox")
6256:         WITH loc_oAba.txt_4c_ProdCodL
6257:             .ControlSource = "crSigCnFNf.lcodpro"
6258:             .Top           = 62
6259:             .Left          = 32
6260:             .Width         = 38
6261:             .Height        = 18
6262:             .FontName      = "Tahoma"
6263:             .FontSize      = 8
6264:             .SpecialEffect = 1
6265:             .Format        = "K"
6266:             .InputMask     = "999.99"
6267:             .Visible       = .T.
6268:         ENDWITH
6269: 
6270:         *-- Descricao (top=50)
6271:         loc_oAba.AddObject("lbl_4c_LblDescr", "Label")
6272:         WITH loc_oAba.lbl_4c_LblDescr

*-- Linhas 6283 a 6301:
6283: 
6284:         loc_oAba.AddObject("txt_4c_ProdDescL", "TextBox")
6285:         WITH loc_oAba.txt_4c_ProdDescL
6286:             .ControlSource = "crSigCnFNf.ldescpro"
6287:             .Top           = 62
6288:             .Left          = 75
6289:             .Width         = 38
6290:             .Height        = 18
6291:             .FontName      = "Tahoma"
6292:             .FontSize      = 8
6293:             .SpecialEffect = 1
6294:             .Format        = "K"
6295:             .InputMask     = "999.99"
6296:             .Visible       = .T.
6297:         ENDWITH
6298: 
6299:         *-- Peso (top=50)
6300:         loc_oAba.AddObject("lbl_4c_LblPeso", "Label")
6301:         WITH loc_oAba.lbl_4c_LblPeso

*-- Linhas 6312 a 6330:
6312: 
6313:         loc_oAba.AddObject("txt_4c_ProdPesoL", "TextBox")
6314:         WITH loc_oAba.txt_4c_ProdPesoL
6315:             .ControlSource = "crSigCnFNf.cpespro"
6316:             .Top           = 62
6317:             .Left          = 118
6318:             .Width         = 38
6319:             .Height        = 18
6320:             .FontName      = "Tahoma"
6321:             .FontSize      = 8
6322:             .SpecialEffect = 1
6323:             .Format        = "K"
6324:             .InputMask     = "999.99"
6325:             .Visible       = .T.
6326:         ENDWITH
6327: 
6328:         *-- Tipo (top=50)
6329:         loc_oAba.AddObject("lbl_4c_LblTipo", "Label")
6330:         WITH loc_oAba.lbl_4c_LblTipo

*-- Linhas 6341 a 6359:
6341: 
6342:         loc_oAba.AddObject("txt_4c_ProdTipoL", "TextBox")
6343:         WITH loc_oAba.txt_4c_ProdTipoL
6344:             .ControlSource = "crSigCnFNf.ltprod"
6345:             .Top           = 62
6346:             .Left          = 161
6347:             .Width         = 38
6348:             .Height        = 18
6349:             .FontName      = "Tahoma"
6350:             .FontSize      = 8
6351:             .SpecialEffect = 1
6352:             .Format        = "K"
6353:             .InputMask     = "999.99"
6354:             .Visible       = .T.
6355:         ENDWITH
6356: 
6357:         *-- Metal (top=50)
6358:         loc_oAba.AddObject("lbl_4c_LblMetal", "Label")
6359:         WITH loc_oAba.lbl_4c_LblMetal

*-- Linhas 6370 a 6388:
6370: 
6371:         loc_oAba.AddObject("txt_4c_ProdMetalL", "TextBox")
6372:         WITH loc_oAba.txt_4c_ProdMetalL
6373:             .ControlSource = "crSigCnFNf.cmarca"
6374:             .Top           = 62
6375:             .Left          = 204
6376:             .Width         = 38
6377:             .Height        = 18
6378:             .FontName      = "Tahoma"
6379:             .FontSize      = 8
6380:             .SpecialEffect = 1
6381:             .Format        = "K"
6382:             .InputMask     = "999.99"
6383:             .Visible       = .T.
6384:         ENDWITH
6385: 
6386:         *-- Teor (top=50)
6387:         loc_oAba.AddObject("lbl_4c_LblTeor", "Label")
6388:         WITH loc_oAba.lbl_4c_LblTeor

*-- Linhas 6399 a 6417:
6399: 
6400:         loc_oAba.AddObject("txt_4c_ProdTeorL", "TextBox")
6401:         WITH loc_oAba.txt_4c_ProdTeorL
6402:             .ControlSource = "crSigCnFNf.cticm"
6403:             .Top           = 62
6404:             .Left          = 247
6405:             .Width         = 41
6406:             .Height        = 18
6407:             .FontName      = "Tahoma"
6408:             .FontSize      = 8
6409:             .SpecialEffect = 1
6410:             .Format        = "K"
6411:             .InputMask     = "999.99"
6412:             .Visible       = .T.
6413:         ENDWITH
6414: 
6415:         *-- Cl.Fiscal (top=50)
6416:         loc_oAba.AddObject("lbl_4c_LblClFis", "Label")
6417:         WITH loc_oAba.lbl_4c_LblClFis

*-- Linhas 6428 a 6446:
6428: 
6429:         loc_oAba.AddObject("txt_4c_ProdClFisL", "TextBox")
6430:         WITH loc_oAba.txt_4c_ProdClFisL
6431:             .ControlSource = "crSigCnFNf.lcclas1"
6432:             .Top           = 62
6433:             .Left          = 293
6434:             .Width         = 38
6435:             .Height        = 18
6436:             .FontName      = "Tahoma"
6437:             .FontSize      = 8
6438:             .SpecialEffect = 1
6439:             .Format        = "K"
6440:             .InputMask     = "999.99"
6441:             .Visible       = .T.
6442:         ENDWITH
6443: 
6444:         *-- Sit.Trib (top=50)
6445:         loc_oAba.AddObject("lbl_4c_LblSitTrib", "Label")
6446:         WITH loc_oAba.lbl_4c_LblSitTrib

*-- Linhas 6457 a 6475:
6457: 
6458:         loc_oAba.AddObject("txt_4c_ProdSitTribL", "TextBox")
6459:         WITH loc_oAba.txt_4c_ProdSitTribL
6460:             .ControlSource = "crSigCnFNf.lstrib"
6461:             .Top           = 62
6462:             .Left          = 336
6463:             .Width         = 38
6464:             .Height        = 18
6465:             .FontName      = "Tahoma"
6466:             .FontSize      = 8
6467:             .SpecialEffect = 1
6468:             .Format        = "K"
6469:             .InputMask     = "999.99"
6470:             .Visible       = .T.
6471:         ENDWITH
6472: 
6473:         *-- Origem (top=50)
6474:         loc_oAba.AddObject("lbl_4c_LblOrigem", "Label")
6475:         WITH loc_oAba.lbl_4c_LblOrigem

*-- Linhas 6486 a 6504:
6486: 
6487:         loc_oAba.AddObject("txt_4c_ProdOrigemL", "TextBox")
6488:         WITH loc_oAba.txt_4c_ProdOrigemL
6489:             .ControlSource = "crSigCnFNf.corigem"
6490:             .Top           = 62
6491:             .Left          = 379
6492:             .Width         = 38
6493:             .Height        = 18
6494:             .FontName      = "Tahoma"
6495:             .FontSize      = 8
6496:             .SpecialEffect = 1
6497:             .Format        = "K"
6498:             .InputMask     = "999.99"
6499:             .Visible       = .T.
6500:         ENDWITH
6501: 
6502:         *-- Unidade (top=50)
6503:         loc_oAba.AddObject("lbl_4c_LblUnid", "Label")
6504:         WITH loc_oAba.lbl_4c_LblUnid

*-- Linhas 6515 a 6533:
6515: 
6516:         loc_oAba.AddObject("txt_4c_ProdUnidL", "TextBox")
6517:         WITH loc_oAba.txt_4c_ProdUnidL
6518:             .ControlSource = "crSigCnFNf.lunid"
6519:             .Top           = 62
6520:             .Left          = 422
6521:             .Width         = 38
6522:             .Height        = 18
6523:             .FontName      = "Tahoma"
6524:             .FontSize      = 8
6525:             .SpecialEffect = 1
6526:             .Format        = "K"
6527:             .InputMask     = "999.99"
6528:             .Visible       = .T.
6529:         ENDWITH
6530: 
6531:         *-- Quant (top=50)
6532:         loc_oAba.AddObject("lbl_4c_LblQtde", "Label")
6533:         WITH loc_oAba.lbl_4c_LblQtde

*-- Linhas 6544 a 6562:
6544: 
6545:         loc_oAba.AddObject("txt_4c_ProdQtdeL", "TextBox")
6546:         WITH loc_oAba.txt_4c_ProdQtdeL
6547:             .ControlSource = "crSigCnFNf.lqtde"
6548:             .Top           = 62
6549:             .Left          = 466
6550:             .Width         = 38
6551:             .Height        = 18
6552:             .FontName      = "Tahoma"
6553:             .FontSize      = 8
6554:             .SpecialEffect = 1
6555:             .Format        = "K"
6556:             .InputMask     = "999.99"
6557:             .Visible       = .T.
6558:         ENDWITH
6559: 
6560:         *-- Vlr Unit (top=85)
6561:         loc_oAba.AddObject("lbl_4c_LblVlUnit", "Label")
6562:         WITH loc_oAba.lbl_4c_LblVlUnit

*-- Linhas 6573 a 6591:
6573: 
6574:         loc_oAba.AddObject("txt_4c_ProdVlUnitL", "TextBox")
6575:         WITH loc_oAba.txt_4c_ProdVlUnitL
6576:             .ControlSource = "crSigCnFNf.lvluni"
6577:             .Top           = 97
6578:             .Left          = 32
6579:             .Width         = 38
6580:             .Height        = 18
6581:             .FontName      = "Tahoma"
6582:             .FontSize      = 8
6583:             .SpecialEffect = 1
6584:             .Format        = "K"
6585:             .InputMask     = "999.99"
6586:             .Visible       = .T.
6587:         ENDWITH
6588: 
6589:         *-- Vlr Total (top=85)
6590:         loc_oAba.AddObject("lbl_4c_LblVlTot", "Label")
6591:         WITH loc_oAba.lbl_4c_LblVlTot

*-- Linhas 6602 a 6620:
6602: 
6603:         loc_oAba.AddObject("txt_4c_ProdVlTotL", "TextBox")
6604:         WITH loc_oAba.txt_4c_ProdVlTotL
6605:             .ControlSource = "crSigCnFNf.lvltot"
6606:             .Top           = 97
6607:             .Left          = 75
6608:             .Width         = 38
6609:             .Height        = 18
6610:             .FontName      = "Tahoma"
6611:             .FontSize      = 8
6612:             .SpecialEffect = 1
6613:             .Format        = "K"
6614:             .InputMask     = "999.99"
6615:             .Visible       = .T.
6616:         ENDWITH
6617: 
6618:         *-- Al ICMS (top=85)
6619:         loc_oAba.AddObject("lbl_4c_LblAlICMS", "Label")
6620:         WITH loc_oAba.lbl_4c_LblAlICMS

*-- Linhas 6631 a 6649:
6631: 
6632:         loc_oAba.AddObject("txt_4c_ProdAlICMSL", "TextBox")
6633:         WITH loc_oAba.txt_4c_ProdAlICMSL
6634:             .ControlSource = "crSigCnFNf.lbicm"
6635:             .Top           = 97
6636:             .Left          = 118
6637:             .Width         = 38
6638:             .Height        = 18
6639:             .FontName      = "Tahoma"
6640:             .FontSize      = 8
6641:             .SpecialEffect = 1
6642:             .Format        = "K"
6643:             .InputMask     = "999.99"
6644:             .Visible       = .T.
6645:         ENDWITH
6646: 
6647:         *-- Al IPI (top=85)
6648:         loc_oAba.AddObject("lbl_4c_LblAlIPI", "Label")
6649:         WITH loc_oAba.lbl_4c_LblAlIPI

*-- Linhas 6660 a 6678:
6660: 
6661:         loc_oAba.AddObject("txt_4c_ProdAlIPIL", "TextBox")
6662:         WITH loc_oAba.txt_4c_ProdAlIPIL
6663:             .ControlSource = "crSigCnFNf.ltipi"
6664:             .Top           = 97
6665:             .Left          = 161
6666:             .Width         = 38
6667:             .Height        = 18
6668:             .FontName      = "Tahoma"
6669:             .FontSize      = 8
6670:             .SpecialEffect = 1
6671:             .Format        = "K"
6672:             .InputMask     = "999.99"
6673:             .Visible       = .T.
6674:         ENDWITH
6675: 
6676:         *-- Valor IPI (top=85)
6677:         loc_oAba.AddObject("lbl_4c_LblValIPI", "Label")
6678:         WITH loc_oAba.lbl_4c_LblValIPI

*-- Linhas 6689 a 6707:
6689: 
6690:         loc_oAba.AddObject("txt_4c_ProdValIPIL", "TextBox")
6691:         WITH loc_oAba.txt_4c_ProdValIPIL
6692:             .ControlSource = "crSigCnFNf.cvipi"
6693:             .Top           = 97
6694:             .Left          = 203
6695:             .Width         = 41
6696:             .Height        = 18
6697:             .FontName      = "Tahoma"
6698:             .FontSize      = 8
6699:             .SpecialEffect = 1
6700:             .Format        = "K"
6701:             .InputMask     = "999.99"
6702:             .Visible       = .T.
6703:         ENDWITH
6704: 
6705:         *-- CFOP (top=85)
6706:         loc_oAba.AddObject("lbl_4c_LblCFOP", "Label")
6707:         WITH loc_oAba.lbl_4c_LblCFOP

*-- Linhas 6718 a 6736:
6718: 
6719:         loc_oAba.AddObject("txt_4c_ProdCFOPL", "TextBox")
6720:         WITH loc_oAba.txt_4c_ProdCFOPL
6721:             .ControlSource = "crSigCnFNf.lcfop"
6722:             .Top           = 97
6723:             .Left          = 248
6724:             .Width         = 41
6725:             .Height        = 18
6726:             .FontName      = "Tahoma"
6727:             .FontSize      = 8
6728:             .SpecialEffect = 1
6729:             .Format        = "K"
6730:             .InputMask     = "999.99"
6731:             .Visible       = .T.
6732:         ENDWITH
6733: 
6734:         *-- Peso Metal (top=85)
6735:         loc_oAba.AddObject("lbl_4c_LblPesoMet", "Label")
6736:         WITH loc_oAba.lbl_4c_LblPesoMet

*-- Linhas 6747 a 6765:
6747: 
6748:         loc_oAba.AddObject("txt_4c_ProdPesoMetL", "TextBox")
6749:         WITH loc_oAba.txt_4c_ProdPesoMetL
6750:             .ControlSource = "crSigCnFNf.cpbru"
6751:             .Top           = 97
6752:             .Left          = 293
6753:             .Width         = 41
6754:             .Height        = 18
6755:             .FontName      = "Tahoma"
6756:             .FontSize      = 8
6757:             .SpecialEffect = 1
6758:             .Format        = "K"
6759:             .InputMask     = "999.99"
6760:             .Visible       = .T.
6761:         ENDWITH
6762: 
6763:         *-- Config. Descricao Produto (shape + labels, top=125-248)
6764:         loc_oAba.AddObject("shp_4c_Shape1", "Shape")
6765:         WITH loc_oAba.shp_4c_Shape1

*-- Linhas 6809 a 6827:
6809: 
6810:         loc_oAba.AddObject("txt_4c_QtMaxCarL", "TextBox")
6811:         WITH loc_oAba.txt_4c_QtMaxCarL
6812:             .ControlSource = "crSigCnFNf.tamdesc"
6813:             .Top           = 138
6814:             .Left          = 143
6815:             .Width         = 27
6816:             .Height        = 18
6817:             .FontName      = "Tahoma"
6818:             .FontSize      = 8
6819:             .SpecialEffect = 1
6820:             .Format        = "K"
6821:             .InputMask     = "999.99"
6822:             .Visible       = .T.
6823:         ENDWITH
6824: 
6825:         *-- Descricao Original (top=162)
6826:         loc_oAba.AddObject("lbl_4c_LblDescOrig", "Label")
6827:         WITH loc_oAba.lbl_4c_LblDescOrig

*-- Linhas 6838 a 6856:
6838: 
6839:         loc_oAba.AddObject("txt_4c_DescOrigL", "TextBox")
6840:         WITH loc_oAba.txt_4c_DescOrigL
6841:             .ControlSource = "crSigCnFNf.ldescpro"
6842:             .Top           = 159
6843:             .Left          = 143
6844:             .Width         = 27
6845:             .Height        = 18
6846:             .FontName      = "Tahoma"
6847:             .FontSize      = 8
6848:             .SpecialEffect = 1
6849:             .Format        = "K"
6850:             .InputMask     = "999.99"
6851:             .Visible       = .T.
6852:         ENDWITH
6853: 
6854:         *-- Adendo Tp. Fatura (top=180)
6855:         loc_oAba.AddObject("lbl_4c_LblAdendo", "Label")
6856:         WITH loc_oAba.lbl_4c_LblAdendo

*-- Linhas 6867 a 6885:
6867: 
6868:         loc_oAba.AddObject("txt_4c_AdendoL", "TextBox")
6869:         WITH loc_oAba.txt_4c_AdendoL
6870:             .ControlSource = "crSigCnFNf.ltipi"
6871:             .Top           = 177
6872:             .Left          = 143
6873:             .Width         = 27
6874:             .Height        = 18
6875:             .FontName      = "Tahoma"
6876:             .FontSize      = 8
6877:             .SpecialEffect = 1
6878:             .Format        = "K"
6879:             .InputMask     = "999.99"
6880:             .Visible       = .T.
6881:         ENDWITH
6882: 
6883:         *-- Cor (top=198)
6884:         loc_oAba.AddObject("lbl_4c_LblCor", "Label")
6885:         WITH loc_oAba.lbl_4c_LblCor

*-- Linhas 6896 a 6914:
6896: 
6897:         loc_oAba.AddObject("txt_4c_CorL", "TextBox")
6898:         WITH loc_oAba.txt_4c_CorL
6899:             .ControlSource = "crSigCnFNf.ocor"
6900:             .Top           = 195
6901:             .Left          = 143
6902:             .Width         = 27
6903:             .Height        = 18
6904:             .FontName      = "Tahoma"
6905:             .FontSize      = 8
6906:             .SpecialEffect = 1
6907:             .Format        = "K"
6908:             .InputMask     = "999.99"
6909:             .Visible       = .T.
6910:         ENDWITH
6911: 
6912:         *-- Embalagem (top=216)
6913:         loc_oAba.AddObject("lbl_4c_LblEmb", "Label")
6914:         WITH loc_oAba.lbl_4c_LblEmb

*-- Linhas 6925 a 6943:
6925: 
6926:         loc_oAba.AddObject("txt_4c_EmbL", "TextBox")
6927:         WITH loc_oAba.txt_4c_EmbL
6928:             .ControlSource = "crSigCnFNf.oemb"
6929:             .Top           = 213
6930:             .Left          = 143
6931:             .Width         = 27
6932:             .Height        = 18
6933:             .FontName      = "Tahoma"
6934:             .FontSize      = 8
6935:             .SpecialEffect = 1
6936:             .Format        = "K"
6937:             .InputMask     = "999.99"
6938:             .Visible       = .T.
6939:         ENDWITH
6940: 
6941:         *-- Tamanho (top=234)
6942:         loc_oAba.AddObject("lbl_4c_LblTamanho", "Label")
6943:         WITH loc_oAba.lbl_4c_LblTamanho

*-- Linhas 6954 a 6972:
6954: 
6955:         loc_oAba.AddObject("txt_4c_TamL", "TextBox")
6956:         WITH loc_oAba.txt_4c_TamL
6957:             .ControlSource = "crSigCnFNf.otam"
6958:             .Top           = 231
6959:             .Left          = 143
6960:             .Width         = 27
6961:             .Height        = 18
6962:             .FontName      = "Tahoma"
6963:             .FontSize      = 8
6964:             .SpecialEffect = 1
6965:             .Format        = "K"
6966:             .InputMask     = "999.99"
6967:             .Visible       = .T.
6968:         ENDWITH
6969: 
6970:         *-- Coluna Obs (top=137, right side)
6971:         loc_oAba.AddObject("lbl_4c_LblColObs", "Label")
6972:         WITH loc_oAba.lbl_4c_LblColObs

*-- Linhas 6983 a 7001:
6983: 
6984:         loc_oAba.AddObject("txt_4c_ColObsL", "TextBox")
6985:         WITH loc_oAba.txt_4c_ColObsL
6986:             .ControlSource = "crSigCnFNf.tamcolobs"
6987:             .Top           = 149
6988:             .Left          = 207
6989:             .Width         = 41
6990:             .Height        = 18
6991:             .FontName      = "Tahoma"
6992:             .FontSize      = 8
6993:             .SpecialEffect = 1
6994:             .Format        = "K"
6995:             .InputMask     = "999.99"
6996:             .Visible       = .T.
6997:         ENDWITH
6998: 
6999:         *-- No. Colunas (top=137)
7000:         loc_oAba.AddObject("lbl_4c_LblNoCols", "Label")
7001:         WITH loc_oAba.lbl_4c_LblNoCols

*-- Linhas 7012 a 7030:
7012: 
7013:         loc_oAba.AddObject("txt_4c_NoColsL", "TextBox")
7014:         WITH loc_oAba.txt_4c_NoColsL
7015:             .ControlSource = "crSigCnFNf.nldser"
7016:             .Top           = 149
7017:             .Left          = 279
7018:             .Width         = 41
7019:             .Height        = 18
7020:             .FontName      = "Tahoma"
7021:             .FontSize      = 8
7022:             .SpecialEffect = 1
7023:             .Format        = "K"
7024:             .InputMask     = "999.99"
7025:             .Visible       = .T.
7026:         ENDWITH
7027: 
7028:         *-- No. Linhas (top=137)
7029:         loc_oAba.AddObject("lbl_4c_LblNoLins", "Label")
7030:         WITH loc_oAba.lbl_4c_LblNoLins

*-- Linhas 7041 a 7059:
7041: 
7042:         loc_oAba.AddObject("txt_4c_NoLinsL", "TextBox")
7043:         WITH loc_oAba.txt_4c_NoLinsL
7044:             .ControlSource = "crSigCnFNf.ncdser"
7045:             .Top           = 149
7046:             .Left          = 348
7047:             .Width         = 41
7048:             .Height        = 18
7049:             .FontName      = "Tahoma"
7050:             .FontSize      = 8
7051:             .SpecialEffect = 1
7052:             .Format        = "K"
7053:             .InputMask     = "999.99"
7054:             .Visible       = .T.
7055:         ENDWITH
7056: 
7057:         *-- Total de Quantidade (top=136)
7058:         loc_oAba.AddObject("lbl_4c_LblTotQtd", "Label")
7059:         WITH loc_oAba.lbl_4c_LblTotQtd

*-- Linhas 7070 a 7088:
7070: 
7071:         loc_oAba.AddObject("txt_4c_TotQtdL", "TextBox")
7072:         WITH loc_oAba.txt_4c_TotQtdL
7073:             .ControlSource = "crSigCnFNf.ltqtde"
7074:             .Top           = 148
7075:             .Left          = 419
7076:             .Width         = 41
7077:             .Height        = 18
7078:             .FontName      = "Tahoma"
7079:             .FontSize      = 8
7080:             .SpecialEffect = 1
7081:             .Format        = "K"
7082:             .InputMask     = "999.99"
7083:             .Visible       = .T.
7084:         ENDWITH
7085: 
7086:         loc_oAba.AddObject("lbl_4c_TotQtdX", "Label")
7087:         WITH loc_oAba.lbl_4c_TotQtdX
7088:             .Caption   = "x"

*-- Linhas 7098 a 7116:
7098: 
7099:         loc_oAba.AddObject("txt_4c_TotQtdC", "TextBox")
7100:         WITH loc_oAba.txt_4c_TotQtdC
7101:             .ControlSource = "crSigCnFNf.ctqtde"
7102:             .Top           = 148
7103:             .Left          = 468
7104:             .Width         = 41
7105:             .Height        = 18
7106:             .FontName      = "Tahoma"
7107:             .FontSize      = 8
7108:             .SpecialEffect = 1
7109:             .Format        = "K"
7110:             .InputMask     = "999.99"
7111:             .Visible       = .T.
7112:         ENDWITH
7113: 
7114:         *-- Desconto/Acrescimo (top=193)
7115:         loc_oAba.AddObject("lbl_4c_LblDescAcr", "Label")
7116:         WITH loc_oAba.lbl_4c_LblDescAcr

*-- Linhas 7127 a 7145:
7127: 
7128:         loc_oAba.AddObject("txt_4c_DescAcrL", "TextBox")
7129:         WITH loc_oAba.txt_4c_DescAcrL
7130:             .ControlSource = "crSigCnFNf.cdesconto"
7131:             .Top           = 205
7132:             .Left          = 250
7133:             .Width         = 41
7134:             .Height        = 18
7135:             .FontName      = "Tahoma"
7136:             .FontSize      = 8
7137:             .SpecialEffect = 1
7138:             .Format        = "K"
7139:             .InputMask     = "999.99"
7140:             .Visible       = .T.
7141:         ENDWITH
7142: 
7143:         loc_oAba.AddObject("lbl_4c_DescAcrX", "Label")
7144:         WITH loc_oAba.lbl_4c_DescAcrX
7145:             .Caption   = "x"

*-- Linhas 7155 a 7173:
7155: 
7156:         loc_oAba.AddObject("txt_4c_DescAcrC", "TextBox")
7157:         WITH loc_oAba.txt_4c_DescAcrC
7158:             .ControlSource = "crSigCnFNf.cdesconto"
7159:             .Top           = 205
7160:             .Left          = 299
7161:             .Width         = 41
7162:             .Height        = 18
7163:             .FontName      = "Tahoma"
7164:             .FontSize      = 8
7165:             .SpecialEffect = 1
7166:             .Format        = "K"
7167:             .InputMask     = "999.99"
7168:             .Visible       = .T.
7169:         ENDWITH
7170: 
7171:         *-- Shape para Descricao 3D border (top=134)
7172:         loc_oAba.AddObject("shp_4c_Shape3", "Shape")
7173:         WITH loc_oAba.shp_4c_Shape3

*-- Linhas 7200 a 7218:
7200: 
7201:         loc_oAba.AddObject("txt_4c_BcICMSL", "TextBox")
7202:         WITH loc_oAba.txt_4c_BcICMSL
7203:             .ControlSource = "crSigCnFNf.lbicm"
7204:             .Top = 31
7205:             .Left = 39
7206:             .Width = 41
7207:             .Height = 18
7208:             .FontName = "Tahoma"
7209:             .FontSize = 8
7210:             .SpecialEffect = 1
7211:             .Format = "K"
7212:             .InputMask = "999.99"
7213:             .Visible = .T.
7214:         ENDWITH
7215: 
7216:         loc_oAba.AddObject("lbl_4c_BcICMSX", "Label")
7217:         WITH loc_oAba.lbl_4c_BcICMSX
7218:             .Caption = "x"

*-- Linhas 7228 a 7246:
7228: 
7229:         loc_oAba.AddObject("txt_4c_BcICMSC", "TextBox")
7230:         WITH loc_oAba.txt_4c_BcICMSC
7231:             .ControlSource = "crSigCnFNf.cbicm"
7232:             .Top = 31
7233:             .Left = 88
7234:             .Width = 41
7235:             .Height = 18
7236:             .FontName = "Tahoma"
7237:             .FontSize = 8
7238:             .SpecialEffect = 1
7239:             .Format = "K"
7240:             .InputMask = "999.99"
7241:             .Visible = .T.
7242:         ENDWITH
7243: 
7244:         *-- Valor do ICMS (top=19)
7245:         loc_oAba.AddObject("lbl_4c_LblValICMS", "Label")
7246:         WITH loc_oAba.lbl_4c_LblValICMS

*-- Linhas 7257 a 7275:
7257: 
7258:         loc_oAba.AddObject("txt_4c_ValICMSL", "TextBox")
7259:         WITH loc_oAba.txt_4c_ValICMSL
7260:             .ControlSource = "crSigCnFNf.lticm"
7261:             .Top = 31
7262:             .Left = 147
7263:             .Width = 41
7264:             .Height = 18
7265:             .FontName = "Tahoma"
7266:             .FontSize = 8
7267:             .SpecialEffect = 1
7268:             .Format = "K"
7269:             .InputMask = "999.99"
7270:             .Visible = .T.
7271:         ENDWITH
7272: 
7273:         loc_oAba.AddObject("lbl_4c_ValICMSX", "Label")
7274:         WITH loc_oAba.lbl_4c_ValICMSX
7275:             .Caption = "x"

*-- Linhas 7285 a 7303:
7285: 
7286:         loc_oAba.AddObject("txt_4c_ValICMSC", "TextBox")
7287:         WITH loc_oAba.txt_4c_ValICMSC
7288:             .ControlSource = "crSigCnFNf.cticm"
7289:             .Top = 31
7290:             .Left = 196
7291:             .Width = 41
7292:             .Height = 18
7293:             .FontName = "Tahoma"
7294:             .FontSize = 8
7295:             .SpecialEffect = 1
7296:             .Format = "K"
7297:             .InputMask = "999.99"
7298:             .Visible = .T.
7299:         ENDWITH
7300: 
7301:         *-- Valor do Frete (top=53)
7302:         loc_oAba.AddObject("lbl_4c_LblValFret", "Label")
7303:         WITH loc_oAba.lbl_4c_LblValFret

*-- Linhas 7314 a 7332:
7314: 
7315:         loc_oAba.AddObject("txt_4c_ValFretL", "TextBox")
7316:         WITH loc_oAba.txt_4c_ValFretL
7317:             .ControlSource = "crSigCnFNf.lfrete"
7318:             .Top = 65
7319:             .Left = 39
7320:             .Width = 41
7321:             .Height = 18
7322:             .FontName = "Tahoma"
7323:             .FontSize = 8
7324:             .SpecialEffect = 1
7325:             .Format = "K"
7326:             .InputMask = "999.99"
7327:             .Visible = .T.
7328:         ENDWITH
7329: 
7330:         loc_oAba.AddObject("lbl_4c_ValFretX", "Label")
7331:         WITH loc_oAba.lbl_4c_ValFretX
7332:             .Caption = "x"

*-- Linhas 7342 a 7360:
7342: 
7343:         loc_oAba.AddObject("txt_4c_ValFretC", "TextBox")
7344:         WITH loc_oAba.txt_4c_ValFretC
7345:             .ControlSource = "crSigCnFNf.cfrete"
7346:             .Top = 65
7347:             .Left = 88
7348:             .Width = 41
7349:             .Height = 18
7350:             .FontName = "Tahoma"
7351:             .FontSize = 8
7352:             .SpecialEffect = 1
7353:             .Format = "K"
7354:             .InputMask = "999.99"
7355:             .Visible = .T.
7356:         ENDWITH
7357: 
7358:         *-- Valor do Seguro (top=53)
7359:         loc_oAba.AddObject("lbl_4c_LblValSeg", "Label")
7360:         WITH loc_oAba.lbl_4c_LblValSeg

*-- Linhas 7371 a 7389:
7371: 
7372:         loc_oAba.AddObject("txt_4c_ValSegL", "TextBox")
7373:         WITH loc_oAba.txt_4c_ValSegL
7374:             .ControlSource = "crSigCnFNf.lseguro"
7375:             .Top = 65
7376:             .Left = 147
7377:             .Width = 41
7378:             .Height = 18
7379:             .FontName = "Tahoma"
7380:             .FontSize = 8
7381:             .SpecialEffect = 1
7382:             .Format = "K"
7383:             .InputMask = "999.99"
7384:             .Visible = .T.
7385:         ENDWITH
7386: 
7387:         loc_oAba.AddObject("lbl_4c_ValSegX", "Label")
7388:         WITH loc_oAba.lbl_4c_ValSegX
7389:             .Caption = "x"

*-- Linhas 7399 a 7417:
7399: 
7400:         loc_oAba.AddObject("txt_4c_ValSegC", "TextBox")
7401:         WITH loc_oAba.txt_4c_ValSegC
7402:             .ControlSource = "crSigCnFNf.cseguro"
7403:             .Top = 65
7404:             .Left = 196
7405:             .Width = 41
7406:             .Height = 18
7407:             .FontName = "Tahoma"
7408:             .FontSize = 8
7409:             .SpecialEffect = 1
7410:             .Format = "K"
7411:             .InputMask = "999.99"
7412:             .Visible = .T.
7413:         ENDWITH
7414: 
7415:         *-- Outras Despesas (top=53)
7416:         loc_oAba.AddObject("lbl_4c_LblOutDesp", "Label")
7417:         WITH loc_oAba.lbl_4c_LblOutDesp

*-- Linhas 7428 a 7446:
7428: 
7429:         loc_oAba.AddObject("txt_4c_OutDespL", "TextBox")
7430:         WITH loc_oAba.txt_4c_OutDespL
7431:             .ControlSource = "crSigCnFNf.coutras"
7432:             .Top = 65
7433:             .Left = 255
7434:             .Width = 41
7435:             .Height = 18
7436:             .FontName = "Tahoma"
7437:             .FontSize = 8
7438:             .SpecialEffect = 1
7439:             .Format = "K"
7440:             .InputMask = "999.99"
7441:             .Visible = .T.
7442:         ENDWITH
7443: 
7444:         loc_oAba.AddObject("lbl_4c_OutDespX", "Label")
7445:         WITH loc_oAba.lbl_4c_OutDespX
7446:             .Caption = "x"

*-- Linhas 7456 a 7474:
7456: 
7457:         loc_oAba.AddObject("txt_4c_OutDespC", "TextBox")
7458:         WITH loc_oAba.txt_4c_OutDespC
7459:             .ControlSource = "crSigCnFNf.coutras"
7460:             .Top = 65
7461:             .Left = 304
7462:             .Width = 41
7463:             .Height = 18
7464:             .FontName = "Tahoma"
7465:             .FontSize = 8
7466:             .SpecialEffect = 1
7467:             .Format = "K"
7468:             .InputMask = "999.99"
7469:             .Visible = .T.
7470:         ENDWITH
7471: 
7472:         *-- Valor dos Produtos (top=89)
7473:         loc_oAba.AddObject("lbl_4c_LblValProd", "Label")
7474:         WITH loc_oAba.lbl_4c_LblValProd

*-- Linhas 7485 a 7503:
7485: 
7486:         loc_oAba.AddObject("txt_4c_ValProdL", "TextBox")
7487:         WITH loc_oAba.txt_4c_ValProdL
7488:             .ControlSource = "crSigCnFNf.lvltot"
7489:             .Top = 101
7490:             .Left = 39
7491:             .Width = 41
7492:             .Height = 18
7493:             .FontName = "Tahoma"
7494:             .FontSize = 8
7495:             .SpecialEffect = 1
7496:             .Format = "K"
7497:             .InputMask = "999.99"
7498:             .Visible = .T.
7499:         ENDWITH
7500: 
7501:         loc_oAba.AddObject("lbl_4c_ValProdX", "Label")
7502:         WITH loc_oAba.lbl_4c_ValProdX
7503:             .Caption = "x"

*-- Linhas 7513 a 7531:
7513: 
7514:         loc_oAba.AddObject("txt_4c_ValProdC", "TextBox")
7515:         WITH loc_oAba.txt_4c_ValProdC
7516:             .ControlSource = "crSigCnFNf.cvltot"
7517:             .Top = 101
7518:             .Left = 88
7519:             .Width = 41
7520:             .Height = 18
7521:             .FontName = "Tahoma"
7522:             .FontSize = 8
7523:             .SpecialEffect = 1
7524:             .Format = "K"
7525:             .InputMask = "999.99"
7526:             .Visible = .T.
7527:         ENDWITH
7528: 
7529:         *-- Base de Calculo do IPI (top=89)
7530:         loc_oAba.AddObject("lbl_4c_LblBcIPI", "Label")
7531:         WITH loc_oAba.lbl_4c_LblBcIPI

*-- Linhas 7542 a 7560:
7542: 
7543:         loc_oAba.AddObject("txt_4c_BcIPIL", "TextBox")
7544:         WITH loc_oAba.txt_4c_BcIPIL
7545:             .ControlSource = "crSigCnFNf.lbicm"
7546:             .Top = 101
7547:             .Left = 147
7548:             .Width = 41
7549:             .Height = 18
7550:             .FontName = "Tahoma"
7551:             .FontSize = 8
7552:             .SpecialEffect = 1
7553:             .Format = "K"
7554:             .InputMask = "999.99"
7555:             .Visible = .T.
7556:         ENDWITH
7557: 
7558:         loc_oAba.AddObject("lbl_4c_BcIPIX", "Label")
7559:         WITH loc_oAba.lbl_4c_BcIPIX
7560:             .Caption = "x"

*-- Linhas 7570 a 7588:
7570: 
7571:         loc_oAba.AddObject("txt_4c_BcIPIC", "TextBox")
7572:         WITH loc_oAba.txt_4c_BcIPIC
7573:             .ControlSource = "crSigCnFNf.cbicm"
7574:             .Top = 101
7575:             .Left = 196
7576:             .Width = 41
7577:             .Height = 18
7578:             .FontName = "Tahoma"
7579:             .FontSize = 8
7580:             .SpecialEffect = 1
7581:             .Format = "K"
7582:             .InputMask = "999.99"
7583:             .Visible = .T.
7584:         ENDWITH
7585: 
7586:         *-- Valor Total do IPI (top=89)
7587:         loc_oAba.AddObject("lbl_4c_LblVlTIPI", "Label")
7588:         WITH loc_oAba.lbl_4c_LblVlTIPI

*-- Linhas 7599 a 7617:
7599: 
7600:         loc_oAba.AddObject("txt_4c_VlTIPIL", "TextBox")
7601:         WITH loc_oAba.txt_4c_VlTIPIL
7602:             .ControlSource = "crSigCnFNf.ctipi"
7603:             .Top = 101
7604:             .Left = 255
7605:             .Width = 41
7606:             .Height = 18
7607:             .FontName = "Tahoma"
7608:             .FontSize = 8
7609:             .SpecialEffect = 1
7610:             .Format = "K"
7611:             .InputMask = "999.99"
7612:             .Visible = .T.
7613:         ENDWITH
7614: 
7615:         loc_oAba.AddObject("lbl_4c_VlTIPIX", "Label")
7616:         WITH loc_oAba.lbl_4c_VlTIPIX
7617:             .Caption = "x"

*-- Linhas 7627 a 7645:
7627: 
7628:         loc_oAba.AddObject("txt_4c_VlTIPIC", "TextBox")
7629:         WITH loc_oAba.txt_4c_VlTIPIC
7630:             .ControlSource = "crSigCnFNf.ctipi"
7631:             .Top = 101
7632:             .Left = 304
7633:             .Width = 41
7634:             .Height = 18
7635:             .FontName = "Tahoma"
7636:             .FontSize = 8
7637:             .SpecialEffect = 1
7638:             .Format = "K"
7639:             .InputMask = "999.99"
7640:             .Visible = .T.
7641:         ENDWITH
7642: 
7643:         *-- Valor Total da Nota (top=89)
7644:         loc_oAba.AddObject("lbl_4c_LblVlTNota", "Label")
7645:         WITH loc_oAba.lbl_4c_LblVlTNota

*-- Linhas 7656 a 7674:
7656: 
7657:         loc_oAba.AddObject("txt_4c_VlTNotaL", "TextBox")
7658:         WITH loc_oAba.txt_4c_VlTNotaL
7659:             .ControlSource = "crSigCnFNf.ltnota"
7660:             .Top = 101
7661:             .Left = 363
7662:             .Width = 41
7663:             .Height = 18
7664:             .FontName = "Tahoma"
7665:             .FontSize = 8
7666:             .SpecialEffect = 1
7667:             .Format = "K"
7668:             .InputMask = "999.99"
7669:             .Visible = .T.
7670:         ENDWITH
7671: 
7672:         loc_oAba.AddObject("lbl_4c_VlTNotaX", "Label")
7673:         WITH loc_oAba.lbl_4c_VlTNotaX
7674:             .Caption = "x"

*-- Linhas 7684 a 7702:
7684: 
7685:         loc_oAba.AddObject("txt_4c_VlTNotaC", "TextBox")
7686:         WITH loc_oAba.txt_4c_VlTNotaC
7687:             .ControlSource = "crSigCnFNf.ctnota"
7688:             .Top = 101
7689:             .Left = 412
7690:             .Width = 41
7691:             .Height = 18
7692:             .FontName = "Tahoma"
7693:             .FontSize = 8
7694:             .SpecialEffect = 1
7695:             .Format = "K"
7696:             .InputMask = "999.99"
7697:             .Visible = .T.
7698:         ENDWITH
7699: 
7700:         *-- Fonte (top=89)
7701:         loc_oAba.AddObject("lbl_4c_LblFonte", "Label")
7702:         WITH loc_oAba.lbl_4c_LblFonte

*-- Linhas 7713 a 7731:
7713: 
7714:         loc_oAba.AddObject("txt_4c_FonteL", "TextBox")
7715:         WITH loc_oAba.txt_4c_FonteL
7716:             .ControlSource = "crSigCnFNf.ltpfrete"
7717:             .Top = 101
7718:             .Left = 461
7719:             .Width = 23
7720:             .Height = 18
7721:             .FontName = "Tahoma"
7722:             .FontSize = 8
7723:             .SpecialEffect = 1
7724:             .Format = "K"
7725:             .InputMask = "999.99"
7726:             .Visible = .T.
7727:         ENDWITH
7728: 
7729:         *-- Base do ICMS ST (top=125)
7730:         loc_oAba.AddObject("lbl_4c_LblBcST", "Label")
7731:         WITH loc_oAba.lbl_4c_LblBcST

*-- Linhas 7742 a 7760:
7742: 
7743:         loc_oAba.AddObject("txt_4c_BcSTL", "TextBox")
7744:         WITH loc_oAba.txt_4c_BcSTL
7745:             .ControlSource = "crSigCnFNf.lbicm"
7746:             .Top = 137
7747:             .Left = 39
7748:             .Width = 41
7749:             .Height = 18
7750:             .FontName = "Tahoma"
7751:             .FontSize = 8
7752:             .SpecialEffect = 1
7753:             .Format = "K"
7754:             .InputMask = "999.99"
7755:             .Visible = .T.
7756:         ENDWITH
7757: 
7758:         loc_oAba.AddObject("lbl_4c_BcSTX", "Label")
7759:         WITH loc_oAba.lbl_4c_BcSTX
7760:             .Caption = "x"

*-- Linhas 7770 a 7788:
7770: 
7771:         loc_oAba.AddObject("txt_4c_BcSTC", "TextBox")
7772:         WITH loc_oAba.txt_4c_BcSTC
7773:             .ControlSource = "crSigCnFNf.cbicm"
7774:             .Top = 137
7775:             .Left = 88
7776:             .Width = 41
7777:             .Height = 18
7778:             .FontName = "Tahoma"
7779:             .FontSize = 8
7780:             .SpecialEffect = 1
7781:             .Format = "K"
7782:             .InputMask = "999.99"
7783:             .Visible = .T.
7784:         ENDWITH
7785: 
7786:         *-- Valor do ICMS ST (top=125)
7787:         loc_oAba.AddObject("lbl_4c_LblValST", "Label")
7788:         WITH loc_oAba.lbl_4c_LblValST

*-- Linhas 7799 a 7817:
7799: 
7800:         loc_oAba.AddObject("txt_4c_ValSTL", "TextBox")
7801:         WITH loc_oAba.txt_4c_ValSTL
7802:             .ControlSource = "crSigCnFNf.lticm"
7803:             .Top = 137
7804:             .Left = 147
7805:             .Width = 41
7806:             .Height = 18
7807:             .FontName = "Tahoma"
7808:             .FontSize = 8
7809:             .SpecialEffect = 1
7810:             .Format = "K"
7811:             .InputMask = "999.99"
7812:             .Visible = .T.
7813:         ENDWITH
7814: 
7815:         loc_oAba.AddObject("lbl_4c_ValSTX", "Label")
7816:         WITH loc_oAba.lbl_4c_ValSTX
7817:             .Caption = "x"

*-- Linhas 7827 a 7845:
7827: 
7828:         loc_oAba.AddObject("txt_4c_ValSTC", "TextBox")
7829:         WITH loc_oAba.txt_4c_ValSTC
7830:             .ControlSource = "crSigCnFNf.cticm"
7831:             .Top = 137
7832:             .Left = 196
7833:             .Width = 41
7834:             .Height = 18
7835:             .FontName = "Tahoma"
7836:             .FontSize = 8
7837:             .SpecialEffect = 1
7838:             .Format = "K"
7839:             .InputMask = "999.99"
7840:             .Visible = .T.
7841:         ENDWITH
7842: 
7843:         *-- IR e ISS (top=180 shape, top=166 %, top=180 labels)
7844:         loc_oAba.AddObject("shp_4c_IRShape", "Shape")
7845:         WITH loc_oAba.shp_4c_IRShape

*-- Linhas 7878 a 7896:
7878: 
7879:         loc_oAba.AddObject("txt_4c_IRVal", "TextBox")
7880:         WITH loc_oAba.txt_4c_IRVal
7881:             .ControlSource = "crSigCnFNf.pirs"
7882:             .Top = 193
7883:             .Left = 44
7884:             .Width = 46
7885:             .Height = 18
7886:             .FontName = "Tahoma"
7887:             .FontSize = 8
7888:             .SpecialEffect = 1
7889:             .Format = "K"
7890:             .InputMask = "999.99"
7891:             .Visible = .T.
7892:         ENDWITH
7893: 
7894:         loc_oAba.AddObject("lbl_4c_LblISS", "Label")
7895:         WITH loc_oAba.lbl_4c_LblISS
7896:             .Caption = "I.S.S."

*-- Linhas 7906 a 7924:
7906: 
7907:         loc_oAba.AddObject("txt_4c_ISSVal", "TextBox")
7908:         WITH loc_oAba.txt_4c_ISSVal
7909:             .ControlSource = "crSigCnFNf.piss"
7910:             .Top = 193
7911:             .Left = 93
7912:             .Width = 46
7913:             .Height = 18
7914:             .FontName = "Tahoma"
7915:             .FontSize = 8
7916:             .SpecialEffect = 1
7917:             .Format = "K"
7918:             .InputMask = "999.99"
7919:             .Visible = .T.
7920:         ENDWITH
7921:     ENDPROC
7922: 
7923:     *--------------------------------------------------------------------------
7924:     PROTECTED PROCEDURE ConfigurarTransporteTab()

*-- Linhas 7964 a 7982:
7964: 
7965:         loc_oAba.AddObject("txt_4c_TrNomeL", "TextBox")
7966:         WITH loc_oAba.txt_4c_TrNomeL
7967:             .ControlSource = "crSigCnFNf.ltrnome"
7968:             .Top = 36
7969:             .Left = 17
7970:             .Width = 41
7971:             .Height = 18
7972:             .FontName = "Tahoma"
7973:             .FontSize = 8
7974:             .SpecialEffect = 1
7975:             .Format = "K"
7976:             .InputMask = "999.99"
7977:             .Visible = .T.
7978:         ENDWITH
7979: 
7980:         loc_oAba.AddObject("lbl_4c_TrNomeX", "Label")
7981:         WITH loc_oAba.lbl_4c_TrNomeX
7982:             .Caption = "x"

*-- Linhas 7992 a 8010:
7992: 
7993:         loc_oAba.AddObject("txt_4c_TrNomeC", "TextBox")
7994:         WITH loc_oAba.txt_4c_TrNomeC
7995:             .ControlSource = "crSigCnFNf.ctrnome"
7996:             .Top = 36
7997:             .Left = 66
7998:             .Width = 41
7999:             .Height = 18
8000:             .FontName = "Tahoma"
8001:             .FontSize = 8
8002:             .SpecialEffect = 1
8003:             .Format = "K"
8004:             .InputMask = "999.99"
8005:             .Visible = .T.
8006:         ENDWITH
8007: 
8008:         *-- CGC/CPF transportador (top=24)
8009:         loc_oAba.AddObject("lbl_4c_LblTrCgc", "Label")
8010:         WITH loc_oAba.lbl_4c_LblTrCgc

*-- Linhas 8021 a 8039:
8021: 
8022:         loc_oAba.AddObject("txt_4c_TrCgcL", "TextBox")
8023:         WITH loc_oAba.txt_4c_TrCgcL
8024:             .ControlSource = "crSigCnFNf.ltrcgc"
8025:             .Top = 36
8026:             .Left = 125
8027:             .Width = 41
8028:             .Height = 18
8029:             .FontName = "Tahoma"
8030:             .FontSize = 8
8031:             .SpecialEffect = 1
8032:             .Format = "K"
8033:             .InputMask = "999.99"
8034:             .Visible = .T.
8035:         ENDWITH
8036: 
8037:         loc_oAba.AddObject("lbl_4c_TrCgcX", "Label")
8038:         WITH loc_oAba.lbl_4c_TrCgcX
8039:             .Caption = "x"

*-- Linhas 8049 a 8067:
8049: 
8050:         loc_oAba.AddObject("txt_4c_TrCgcC", "TextBox")
8051:         WITH loc_oAba.txt_4c_TrCgcC
8052:             .ControlSource = "crSigCnFNf.ctrcgc"
8053:             .Top = 36
8054:             .Left = 174
8055:             .Width = 41
8056:             .Height = 18
8057:             .FontName = "Tahoma"
8058:             .FontSize = 8
8059:             .SpecialEffect = 1
8060:             .Format = "K"
8061:             .InputMask = "999.99"
8062:             .Visible = .T.
8063:         ENDWITH
8064: 
8065:         *-- Insc.Estadual transportador (top=24)
8066:         loc_oAba.AddObject("lbl_4c_LblTrIest", "Label")
8067:         WITH loc_oAba.lbl_4c_LblTrIest

*-- Linhas 8078 a 8096:
8078: 
8079:         loc_oAba.AddObject("txt_4c_TrIestL", "TextBox")
8080:         WITH loc_oAba.txt_4c_TrIestL
8081:             .ControlSource = "crSigCnFNf.ltrie"
8082:             .Top = 36
8083:             .Left = 233
8084:             .Width = 41
8085:             .Height = 18
8086:             .FontName = "Tahoma"
8087:             .FontSize = 8
8088:             .SpecialEffect = 1
8089:             .Format = "K"
8090:             .InputMask = "999.99"
8091:             .Visible = .T.
8092:         ENDWITH
8093: 
8094:         loc_oAba.AddObject("lbl_4c_TrIestX", "Label")
8095:         WITH loc_oAba.lbl_4c_TrIestX
8096:             .Caption = "x"

*-- Linhas 8106 a 8124:
8106: 
8107:         loc_oAba.AddObject("txt_4c_TrIestC", "TextBox")
8108:         WITH loc_oAba.txt_4c_TrIestC
8109:             .ControlSource = "crSigCnFNf.ctrie"
8110:             .Top = 36
8111:             .Left = 282
8112:             .Width = 41
8113:             .Height = 18
8114:             .FontName = "Tahoma"
8115:             .FontSize = 8
8116:             .SpecialEffect = 1
8117:             .Format = "K"
8118:             .InputMask = "999.99"
8119:             .Visible = .T.
8120:         ENDWITH
8121: 
8122:         *-- Endereco transportador (top=57)
8123:         loc_oAba.AddObject("lbl_4c_LblTrEnder", "Label")
8124:         WITH loc_oAba.lbl_4c_LblTrEnder

*-- Linhas 8135 a 8153:
8135: 
8136:         loc_oAba.AddObject("txt_4c_TrEnderL", "TextBox")
8137:         WITH loc_oAba.txt_4c_TrEnderL
8138:             .ControlSource = "crSigCnFNf.ltrend"
8139:             .Top = 69
8140:             .Left = 17
8141:             .Width = 41
8142:             .Height = 18
8143:             .FontName = "Tahoma"
8144:             .FontSize = 8
8145:             .SpecialEffect = 1
8146:             .Format = "K"
8147:             .InputMask = "999.99"
8148:             .Visible = .T.
8149:         ENDWITH
8150: 
8151:         loc_oAba.AddObject("lbl_4c_TrEnderX", "Label")
8152:         WITH loc_oAba.lbl_4c_TrEnderX
8153:             .Caption = "x"

*-- Linhas 8163 a 8181:
8163: 
8164:         loc_oAba.AddObject("txt_4c_TrEnderC", "TextBox")
8165:         WITH loc_oAba.txt_4c_TrEnderC
8166:             .ControlSource = "crSigCnFNf.ctrend"
8167:             .Top = 69
8168:             .Left = 66
8169:             .Width = 41
8170:             .Height = 18
8171:             .FontName = "Tahoma"
8172:             .FontSize = 8
8173:             .SpecialEffect = 1
8174:             .Format = "K"
8175:             .InputMask = "999.99"
8176:             .Visible = .T.
8177:         ENDWITH
8178: 
8179:         *-- Municipio transportador (top=57)
8180:         loc_oAba.AddObject("lbl_4c_LblTrMuni", "Label")
8181:         WITH loc_oAba.lbl_4c_LblTrMuni

*-- Linhas 8192 a 8210:
8192: 
8193:         loc_oAba.AddObject("txt_4c_TrMuniL", "TextBox")
8194:         WITH loc_oAba.txt_4c_TrMuniL
8195:             .ControlSource = "crSigCnFNf.ltrmun"
8196:             .Top = 69
8197:             .Left = 124
8198:             .Width = 41
8199:             .Height = 18
8200:             .FontName = "Tahoma"
8201:             .FontSize = 8
8202:             .SpecialEffect = 1
8203:             .Format = "K"
8204:             .InputMask = "999.99"
8205:             .Visible = .T.
8206:         ENDWITH
8207: 
8208:         loc_oAba.AddObject("lbl_4c_TrMuniX", "Label")
8209:         WITH loc_oAba.lbl_4c_TrMuniX
8210:             .Caption = "x"

*-- Linhas 8220 a 8238:
8220: 
8221:         loc_oAba.AddObject("txt_4c_TrMuniC", "TextBox")
8222:         WITH loc_oAba.txt_4c_TrMuniC
8223:             .ControlSource = "crSigCnFNf.ctrmun"
8224:             .Top = 69
8225:             .Left = 173
8226:             .Width = 41
8227:             .Height = 18
8228:             .FontName = "Tahoma"
8229:             .FontSize = 8
8230:             .SpecialEffect = 1
8231:             .Format = "K"
8232:             .InputMask = "999.99"
8233:             .Visible = .T.
8234:         ENDWITH
8235: 
8236:         *-- Estado transportador (top=57)
8237:         loc_oAba.AddObject("lbl_4c_LblTrEst", "Label")
8238:         WITH loc_oAba.lbl_4c_LblTrEst

*-- Linhas 8249 a 8267:
8249: 
8250:         loc_oAba.AddObject("txt_4c_TrEstL", "TextBox")
8251:         WITH loc_oAba.txt_4c_TrEstL
8252:             .ControlSource = "crSigCnFNf.ltrest"
8253:             .Top = 69
8254:             .Left = 232
8255:             .Width = 41
8256:             .Height = 18
8257:             .FontName = "Tahoma"
8258:             .FontSize = 8
8259:             .SpecialEffect = 1
8260:             .Format = "K"
8261:             .InputMask = "999.99"
8262:             .Visible = .T.
8263:         ENDWITH
8264: 
8265:         loc_oAba.AddObject("lbl_4c_TrEstX", "Label")
8266:         WITH loc_oAba.lbl_4c_TrEstX
8267:             .Caption = "x"

*-- Linhas 8277 a 8295:
8277: 
8278:         loc_oAba.AddObject("txt_4c_TrEstC", "TextBox")
8279:         WITH loc_oAba.txt_4c_TrEstC
8280:             .ControlSource = "crSigCnFNf.ctrest"
8281:             .Top = 69
8282:             .Left = 281
8283:             .Width = 41
8284:             .Height = 18
8285:             .FontName = "Tahoma"
8286:             .FontSize = 8
8287:             .SpecialEffect = 1
8288:             .Format = "K"
8289:             .InputMask = "999.99"
8290:             .Visible = .T.
8291:         ENDWITH
8292: 
8293:         *-- Tipo de Frete (top=91)
8294:         loc_oAba.AddObject("lbl_4c_LblTpFret", "Label")
8295:         WITH loc_oAba.lbl_4c_LblTpFret

*-- Linhas 8306 a 8324:
8306: 
8307:         loc_oAba.AddObject("txt_4c_TpFretL", "TextBox")
8308:         WITH loc_oAba.txt_4c_TpFretL
8309:             .ControlSource = "crSigCnFNf.ltpfrete"
8310:             .Top = 103
8311:             .Left = 17
8312:             .Width = 41
8313:             .Height = 18
8314:             .FontName = "Tahoma"
8315:             .FontSize = 8
8316:             .SpecialEffect = 1
8317:             .Format = "K"
8318:             .InputMask = "999.99"
8319:             .Visible = .T.
8320:         ENDWITH
8321: 
8322:         loc_oAba.AddObject("lbl_4c_TpFretX", "Label")
8323:         WITH loc_oAba.lbl_4c_TpFretX
8324:             .Caption = "x"

*-- Linhas 8334 a 8352:
8334: 
8335:         loc_oAba.AddObject("txt_4c_TpFretC", "TextBox")
8336:         WITH loc_oAba.txt_4c_TpFretC
8337:             .ControlSource = "crSigCnFNf.ctpfrete"
8338:             .Top = 103
8339:             .Left = 66
8340:             .Width = 41
8341:             .Height = 18
8342:             .FontName = "Tahoma"
8343:             .FontSize = 8
8344:             .SpecialEffect = 1
8345:             .Format = "K"
8346:             .InputMask = "999.99"
8347:             .Visible = .T.
8348:         ENDWITH
8349: 
8350:         *-- Placa do Veiculo (top=91)
8351:         loc_oAba.AddObject("lbl_4c_LblPlaca", "Label")
8352:         WITH loc_oAba.lbl_4c_LblPlaca

*-- Linhas 8363 a 8381:
8363: 
8364:         loc_oAba.AddObject("txt_4c_PlacaL", "TextBox")
8365:         WITH loc_oAba.txt_4c_PlacaL
8366:             .ControlSource = "crSigCnFNf.lplaca"
8367:             .Top = 103
8368:             .Left = 124
8369:             .Width = 41
8370:             .Height = 18
8371:             .FontName = "Tahoma"
8372:             .FontSize = 8
8373:             .SpecialEffect = 1
8374:             .Format = "K"
8375:             .InputMask = "999.99"
8376:             .Visible = .T.
8377:         ENDWITH
8378: 
8379:         loc_oAba.AddObject("lbl_4c_PlacaX", "Label")
8380:         WITH loc_oAba.lbl_4c_PlacaX
8381:             .Caption = "x"

*-- Linhas 8391 a 8409:
8391: 
8392:         loc_oAba.AddObject("txt_4c_PlacaC", "TextBox")
8393:         WITH loc_oAba.txt_4c_PlacaC
8394:             .ControlSource = "crSigCnFNf.cplaca"
8395:             .Top = 103
8396:             .Left = 173
8397:             .Width = 41
8398:             .Height = 18
8399:             .FontName = "Tahoma"
8400:             .FontSize = 8
8401:             .SpecialEffect = 1
8402:             .Format = "K"
8403:             .InputMask = "999.99"
8404:             .Visible = .T.
8405:         ENDWITH
8406: 
8407:         *-- Estado do Veiculo (top=91)
8408:         loc_oAba.AddObject("lbl_4c_LblEstVeic", "Label")
8409:         WITH loc_oAba.lbl_4c_LblEstVeic

*-- Linhas 8420 a 8438:
8420: 
8421:         loc_oAba.AddObject("txt_4c_EstVeicL", "TextBox")
8422:         WITH loc_oAba.txt_4c_EstVeicL
8423:             .ControlSource = "crSigCnFNf.lplacauf"
8424:             .Top = 103
8425:             .Left = 232
8426:             .Width = 41
8427:             .Height = 18
8428:             .FontName = "Tahoma"
8429:             .FontSize = 8
8430:             .SpecialEffect = 1
8431:             .Format = "K"
8432:             .InputMask = "999.99"
8433:             .Visible = .T.
8434:         ENDWITH
8435: 
8436:         loc_oAba.AddObject("lbl_4c_EstVeicX", "Label")
8437:         WITH loc_oAba.lbl_4c_EstVeicX
8438:             .Caption = "x"

*-- Linhas 8448 a 8466:
8448: 
8449:         loc_oAba.AddObject("txt_4c_EstVeicC", "TextBox")
8450:         WITH loc_oAba.txt_4c_EstVeicC
8451:             .ControlSource = "crSigCnFNf.cplacauf"
8452:             .Top = 103
8453:             .Left = 281
8454:             .Width = 41
8455:             .Height = 18
8456:             .FontName = "Tahoma"
8457:             .FontSize = 8
8458:             .SpecialEffect = 1
8459:             .Format = "K"
8460:             .InputMask = "999.99"
8461:             .Visible = .T.
8462:         ENDWITH
8463: 
8464:         *-- Shape Volumes Transportados (top=132)
8465:         loc_oAba.AddObject("shp_4c_Vols", "Shape")
8466:         WITH loc_oAba.shp_4c_Vols

*-- Linhas 8500 a 8518:
8500: 
8501:         loc_oAba.AddObject("txt_4c_QtVolL", "TextBox")
8502:         WITH loc_oAba.txt_4c_QtVolL
8503:             .ControlSource = "crSigCnFNf.lqtvol"
8504:             .Top = 161
8505:             .Left = 17
8506:             .Width = 41
8507:             .Height = 18
8508:             .FontName = "Tahoma"
8509:             .FontSize = 8
8510:             .SpecialEffect = 1
8511:             .Format = "K"
8512:             .InputMask = "999.99"
8513:             .Visible = .T.
8514:         ENDWITH
8515: 
8516:         loc_oAba.AddObject("lbl_4c_QtVolX", "Label")
8517:         WITH loc_oAba.lbl_4c_QtVolX
8518:             .Caption = "x"

*-- Linhas 8528 a 8546:
8528: 
8529:         loc_oAba.AddObject("txt_4c_QtVolC", "TextBox")
8530:         WITH loc_oAba.txt_4c_QtVolC
8531:             .ControlSource = "crSigCnFNf.cqtvol"
8532:             .Top = 161
8533:             .Left = 66
8534:             .Width = 41
8535:             .Height = 18
8536:             .FontName = "Tahoma"
8537:             .FontSize = 8
8538:             .SpecialEffect = 1
8539:             .Format = "K"
8540:             .InputMask = "999.99"
8541:             .Visible = .T.
8542:         ENDWITH
8543: 
8544:         *-- Especie (top=149)
8545:         loc_oAba.AddObject("lbl_4c_LblEsp", "Label")
8546:         WITH loc_oAba.lbl_4c_LblEsp

*-- Linhas 8557 a 8575:
8557: 
8558:         loc_oAba.AddObject("txt_4c_EspL", "TextBox")
8559:         WITH loc_oAba.txt_4c_EspL
8560:             .ControlSource = "crSigCnFNf.lesp"
8561:             .Top = 161
8562:             .Left = 124
8563:             .Width = 41
8564:             .Height = 18
8565:             .FontName = "Tahoma"
8566:             .FontSize = 8
8567:             .SpecialEffect = 1
8568:             .Format = "K"
8569:             .InputMask = "999.99"
8570:             .Visible = .T.
8571:         ENDWITH
8572: 
8573:         loc_oAba.AddObject("lbl_4c_EspX", "Label")
8574:         WITH loc_oAba.lbl_4c_EspX
8575:             .Caption = "x"

*-- Linhas 8585 a 8603:
8585: 
8586:         loc_oAba.AddObject("txt_4c_EspC", "TextBox")
8587:         WITH loc_oAba.txt_4c_EspC
8588:             .ControlSource = "crSigCnFNf.cesp"
8589:             .Top = 161
8590:             .Left = 173
8591:             .Width = 41
8592:             .Height = 18
8593:             .FontName = "Tahoma"
8594:             .FontSize = 8
8595:             .SpecialEffect = 1
8596:             .Format = "K"
8597:             .InputMask = "999.99"
8598:             .Visible = .T.
8599:         ENDWITH
8600: 
8601:         *-- Marca (top=149)
8602:         loc_oAba.AddObject("lbl_4c_LblMarca", "Label")
8603:         WITH loc_oAba.lbl_4c_LblMarca

*-- Linhas 8614 a 8632:
8614: 
8615:         loc_oAba.AddObject("txt_4c_MarcaL", "TextBox")
8616:         WITH loc_oAba.txt_4c_MarcaL
8617:             .ControlSource = "crSigCnFNf.lmarca"
8618:             .Top = 161
8619:             .Left = 232
8620:             .Width = 41
8621:             .Height = 18
8622:             .FontName = "Tahoma"
8623:             .FontSize = 8
8624:             .SpecialEffect = 1
8625:             .Format = "K"
8626:             .InputMask = "999.99"
8627:             .Visible = .T.
8628:         ENDWITH
8629: 
8630:         loc_oAba.AddObject("lbl_4c_MarcaX", "Label")
8631:         WITH loc_oAba.lbl_4c_MarcaX
8632:             .Caption = "x"

*-- Linhas 8642 a 8660:
8642: 
8643:         loc_oAba.AddObject("txt_4c_MarcaC", "TextBox")
8644:         WITH loc_oAba.txt_4c_MarcaC
8645:             .ControlSource = "crSigCnFNf.cmarca"
8646:             .Top = 161
8647:             .Left = 281
8648:             .Width = 41
8649:             .Height = 18
8650:             .FontName = "Tahoma"
8651:             .FontSize = 8
8652:             .SpecialEffect = 1
8653:             .Format = "K"
8654:             .InputMask = "999.99"
8655:             .Visible = .T.
8656:         ENDWITH
8657: 
8658:         *-- Numero (top=183)
8659:         loc_oAba.AddObject("lbl_4c_LblNumVol", "Label")
8660:         WITH loc_oAba.lbl_4c_LblNumVol

*-- Linhas 8671 a 8689:
8671: 
8672:         loc_oAba.AddObject("txt_4c_NumVolL", "TextBox")
8673:         WITH loc_oAba.txt_4c_NumVolL
8674:             .ControlSource = "crSigCnFNf.lnumero"
8675:             .Top = 195
8676:             .Left = 17
8677:             .Width = 41
8678:             .Height = 18
8679:             .FontName = "Tahoma"
8680:             .FontSize = 8
8681:             .SpecialEffect = 1
8682:             .Format = "K"
8683:             .InputMask = "999.99"
8684:             .Visible = .T.
8685:         ENDWITH
8686: 
8687:         loc_oAba.AddObject("lbl_4c_NumVolX", "Label")
8688:         WITH loc_oAba.lbl_4c_NumVolX
8689:             .Caption = "x"

*-- Linhas 8699 a 8717:
8699: 
8700:         loc_oAba.AddObject("txt_4c_NumVolC", "TextBox")
8701:         WITH loc_oAba.txt_4c_NumVolC
8702:             .ControlSource = "crSigCnFNf.cnumero"
8703:             .Top = 195
8704:             .Left = 66
8705:             .Width = 41
8706:             .Height = 18
8707:             .FontName = "Tahoma"
8708:             .FontSize = 8
8709:             .SpecialEffect = 1
8710:             .Format = "K"
8711:             .InputMask = "999.99"
8712:             .Visible = .T.
8713:         ENDWITH
8714: 
8715:         *-- Peso Bruto (top=183)
8716:         loc_oAba.AddObject("lbl_4c_LblPBru", "Label")
8717:         WITH loc_oAba.lbl_4c_LblPBru

*-- Linhas 8728 a 8746:
8728: 
8729:         loc_oAba.AddObject("txt_4c_PBruL", "TextBox")
8730:         WITH loc_oAba.txt_4c_PBruL
8731:             .ControlSource = "crSigCnFNf.lpbru"
8732:             .Top = 195
8733:             .Left = 124
8734:             .Width = 41
8735:             .Height = 18
8736:             .FontName = "Tahoma"
8737:             .FontSize = 8
8738:             .SpecialEffect = 1
8739:             .Format = "K"
8740:             .InputMask = "999.99"
8741:             .Visible = .T.
8742:         ENDWITH
8743: 
8744:         loc_oAba.AddObject("lbl_4c_PBruX", "Label")
8745:         WITH loc_oAba.lbl_4c_PBruX
8746:             .Caption = "x"

*-- Linhas 8756 a 8774:
8756: 
8757:         loc_oAba.AddObject("txt_4c_PBruC", "TextBox")
8758:         WITH loc_oAba.txt_4c_PBruC
8759:             .ControlSource = "crSigCnFNf.cpbru"
8760:             .Top = 195
8761:             .Left = 173
8762:             .Width = 41
8763:             .Height = 18
8764:             .FontName = "Tahoma"
8765:             .FontSize = 8
8766:             .SpecialEffect = 1
8767:             .Format = "K"
8768:             .InputMask = "999.99"
8769:             .Visible = .T.
8770:         ENDWITH
8771: 
8772:         *-- Peso Liquido (top=183)
8773:         loc_oAba.AddObject("lbl_4c_LblPLiq", "Label")
8774:         WITH loc_oAba.lbl_4c_LblPLiq

*-- Linhas 8785 a 8803:
8785: 
8786:         loc_oAba.AddObject("txt_4c_PLiqL", "TextBox")
8787:         WITH loc_oAba.txt_4c_PLiqL
8788:             .ControlSource = "crSigCnFNf.lpliq"
8789:             .Top = 195
8790:             .Left = 232
8791:             .Width = 41
8792:             .Height = 18
8793:             .FontName = "Tahoma"
8794:             .FontSize = 8
8795:             .SpecialEffect = 1
8796:             .Format = "K"
8797:             .InputMask = "999.99"
8798:             .Visible = .T.
8799:         ENDWITH
8800: 
8801:         loc_oAba.AddObject("lbl_4c_PLiqX", "Label")
8802:         WITH loc_oAba.lbl_4c_PLiqX
8803:             .Caption = "x"

*-- Linhas 8813 a 8831:
8813: 
8814:         loc_oAba.AddObject("txt_4c_PLiqC", "TextBox")
8815:         WITH loc_oAba.txt_4c_PLiqC
8816:             .ControlSource = "crSigCnFNf.cpliq"
8817:             .Top = 195
8818:             .Left = 281
8819:             .Width = 41
8820:             .Height = 18
8821:             .FontName = "Tahoma"
8822:             .FontSize = 8
8823:             .SpecialEffect = 1
8824:             .Format = "K"
8825:             .InputMask = "999.99"
8826:             .Visible = .T.
8827:         ENDWITH
8828: 
8829:         *-- Un Pesos (top=221)
8830:         loc_oAba.AddObject("lbl_4c_LblUnPesos", "Label")
8831:         WITH loc_oAba.lbl_4c_LblUnPesos

*-- Linhas 8842 a 8860:
8842: 
8843:         loc_oAba.AddObject("txt_4c_UnPesos", "TextBox")
8844:         WITH loc_oAba.txt_4c_UnPesos
8845:             .ControlSource = "crSigCnFNf.pesovols"
8846:             .Top = 219
8847:             .Left = 66
8848:             .Width = 41
8849:             .Height = 18
8850:             .FontName = "Tahoma"
8851:             .FontSize = 8
8852:             .SpecialEffect = 1
8853:             .Format = "K"
8854:             .InputMask = "999.99"
8855:             .Visible = .T.
8856:         ENDWITH
8857:     ENDPROC
8858: 
8859:     *--------------------------------------------------------------------------
8860:     PROTECTED PROCEDURE ConfigurarRodapeTab()

*-- Linhas 8991 a 9009:
8991: 
8992:             loc_oAba.AddObject("txt_4c_ClsL" + loc_cFat, "TextBox")
8993:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
8994:                 .ControlSource = "crSigCnFNf.lclas" + loc_cFat
8995:                 .Top = loc_nTop
8996:                 .Left = 80
8997:                 .Width = 41
8998:                 .Height = 18
8999:                 .FontName = "Tahoma"
9000:                 .FontSize = 8
9001:                 .SpecialEffect = 1
9002:                 .Format = "K"
9003:                 .InputMask = "999.99"
9004:                 .Visible = .T.
9005:             ENDWITH
9006: 
9007:             loc_oAba.AddObject("lbl_4c_ClsX" + loc_cFat, "Label")
9008:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9009:                 .Caption = "x"

*-- Linhas 9019 a 9037:
9019: 
9020:             loc_oAba.AddObject("txt_4c_ClsC" + loc_cFat, "TextBox")
9021:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9022:                 .ControlSource = "crSigCnFNf.cclas" + loc_cFat
9023:                 .Top = loc_nTop
9024:                 .Left = 129
9025:                 .Width = 41
9026:                 .Height = 18
9027:                 .FontName = "Tahoma"
9028:                 .FontSize = 8
9029:                 .SpecialEffect = 1
9030:                 .Format = "K"
9031:                 .InputMask = "999.99"
9032:                 .Visible = .T.
9033:             ENDWITH
9034: 
9035:             loc_oAba.AddObject("cbo_4c_Ang" + loc_cFat, "ComboBox")
9036:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9037:                 .Top = loc_nTop

*-- Linhas 9047 a 9080:
9047: 
9048:             loc_oAba.AddObject("txt_4c_CodImp" + loc_cFat, "TextBox")
9049:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9050:                 .ControlSource = "crSigCnFNf.impclas" + loc_cFat
9051:                 .Top = loc_nTop
9052:                 .Left = 221
9053:                 .Width = 100
9054:                 .Height = 18
9055:                 .FontName = "Tahoma"
9056:                 .FontSize = 8
9057:                 .SpecialEffect = 1
9058:                 .Format = "K"
9059:                 .InputMask = ""
9060:                 .Visible = .T.
9061:             ENDWITH
9062: 
9063:             loc_oAba.AddObject("chk_4c_Imp" + loc_cFat, "CheckBox")
9064:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9065:                 .ControlSource = "crSigCnFNf.impc" + loc_cFat
9066:                 .Caption = ""
9067:                 .Top = loc_nTop
9068:                 .Left = 329
9069:                 .Width = 19
9070:                 .Height = 16
9071:                 .FontName = "Tahoma"
9072:                 .FontSize = 7
9073:                 .Visible = .T.
9074:                 .Sparse = .F.
9075:                 .Alignment = 0
9076:                 .ReadOnly = .F.
9077:             ENDWITH
9078: 
9079:             loc_nFat = loc_nFat + 1
9080:         ENDFOR

*-- Linhas 9162 a 9180:
9162: 
9163:             loc_oAba.AddObject("txt_4c_ClsLB" + loc_cFatB, "TextBox")
9164:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9165:                 .ControlSource = "crSigCnFN2.lclas" + loc_cFatB
9166:                 .Top = loc_nTopB
9167:                 .Left = 436
9168:                 .Width = 41
9169:                 .Height = 18
9170:                 .FontName = "Tahoma"
9171:                 .FontSize = 8
9172:                 .SpecialEffect = 1
9173:                 .Format = "K"
9174:                 .InputMask = "999.99"
9175:                 .Visible = .T.
9176:             ENDWITH
9177: 
9178:             loc_oAba.AddObject("lbl_4c_ClsXB" + loc_cFatB, "Label")
9179:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9180:                 .Caption = "x"

*-- Linhas 9190 a 9208:
9190: 
9191:             loc_oAba.AddObject("txt_4c_ClsCB" + loc_cFatB, "TextBox")
9192:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9193:                 .ControlSource = "crSigCnFN2.cclas" + loc_cFatB
9194:                 .Top = loc_nTopB
9195:                 .Left = 485
9196:                 .Width = 41
9197:                 .Height = 18
9198:                 .FontName = "Tahoma"
9199:                 .FontSize = 8
9200:                 .SpecialEffect = 1
9201:                 .Format = "K"
9202:                 .InputMask = "999.99"
9203:                 .Visible = .T.
9204:             ENDWITH
9205: 
9206:             loc_oAba.AddObject("cbo_4c_AngB" + loc_cFatB, "ComboBox")
9207:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9208:                 .Top = loc_nTopB

*-- Linhas 9218 a 9252:
9218: 
9219:             loc_oAba.AddObject("txt_4c_CodImpB" + loc_cFatB, "TextBox")
9220:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9221:                 .ControlSource = "crSigCnFN2.impclas" + loc_cFatB
9222:                 .Top = loc_nTopB
9223:                 .Left = 577
9224:                 .Width = 100
9225:                 .Height = 18
9226:                 .FontName = "Tahoma"
9227:                 .FontSize = 8
9228:                 .SpecialEffect = 1
9229:                 .Format = "K"
9230:                 .InputMask = ""
9231:                 .Visible = .T.
9232:             ENDWITH
9233: 
9234:             IF loc_nFatB <= 12
9235:                 loc_oAba.AddObject("chk_4c_ImpB" + loc_cFatB, "CheckBox")
9236:                 WITH loc_oAba.Controls(loc_oAba.ControlCount)
9237:                     .ControlSource = "crSigCnFN2.impc" + loc_cFatB
9238:                     .Caption = ""
9239:                     .Top = loc_nTopB
9240:                     .Left = 687
9241:                     .Width = 19
9242:                     .Height = 16
9243:                     .FontName = "Tahoma"
9244:                     .FontSize = 7
9245:                     .Visible = .T.
9246:                     .Sparse = .F.
9247:                     .Alignment = 0
9248:                     .ReadOnly = .F.
9249:                 ENDWITH
9250:             ENDIF
9251: 
9252:             loc_nFatB = loc_nFatB + 1

*-- Linhas 9268 a 9286:
9268: 
9269:         loc_oAba.AddObject("txt_4c_NoNFL", "TextBox")
9270:         WITH loc_oAba.txt_4c_NoNFL
9271:             .ControlSource = "crSigCnFNf.lnfsai"
9272:             .Top = 213
9273:             .Left = 36
9274:             .Width = 41
9275:             .Height = 18
9276:             .FontName = "Tahoma"
9277:             .FontSize = 8
9278:             .SpecialEffect = 1
9279:             .Format = "K"
9280:             .InputMask = "999.99"
9281:             .Visible = .T.
9282:         ENDWITH
9283: 
9284:         loc_oAba.AddObject("lbl_4c_NoNFX", "Label")
9285:         WITH loc_oAba.lbl_4c_NoNFX
9286:             .Caption = "x"

*-- Linhas 9296 a 9314:
9296: 
9297:         loc_oAba.AddObject("txt_4c_NoNFC", "TextBox")
9298:         WITH loc_oAba.txt_4c_NoNFC
9299:             .ControlSource = "crSigCnFNf.cnfsai"
9300:             .Top = 213
9301:             .Left = 85
9302:             .Width = 41
9303:             .Height = 18
9304:             .FontName = "Tahoma"
9305:             .FontSize = 8
9306:             .SpecialEffect = 1
9307:             .Format = "K"
9308:             .InputMask = "999.99"
9309:             .Visible = .T.
9310:         ENDWITH
9311: 
9312:         *-- Angulo NF (top=202)
9313:         loc_oAba.AddObject("cbo_4c_AngNF", "ComboBox")
9314:         WITH loc_oAba.cbo_4c_AngNF

*-- Linhas 9352 a 9370:
9352: 
9353:         loc_oAba.AddObject("txt_4c_VlNotaRL", "TextBox")
9354:         WITH loc_oAba.txt_4c_VlNotaRL
9355:             .ControlSource = "crSigCnFNf.ltnota"
9356:             .Top = 213
9357:             .Left = 186
9358:             .Width = 41
9359:             .Height = 18
9360:             .FontName = "Tahoma"
9361:             .FontSize = 8
9362:             .SpecialEffect = 1
9363:             .Format = "K"
9364:             .InputMask = "999.99"
9365:             .Visible = .T.
9366:         ENDWITH
9367: 
9368:         loc_oAba.AddObject("lbl_4c_VlNotaRX", "Label")
9369:         WITH loc_oAba.lbl_4c_VlNotaRX
9370:             .Caption = "x"

*-- Linhas 9380 a 9398:
9380: 
9381:         loc_oAba.AddObject("txt_4c_VlNotaRC", "TextBox")
9382:         WITH loc_oAba.txt_4c_VlNotaRC
9383:             .ControlSource = "crSigCnFNf.ctnota"
9384:             .Top = 213
9385:             .Left = 235
9386:             .Width = 41
9387:             .Height = 18
9388:             .FontName = "Tahoma"
9389:             .FontSize = 8
9390:             .SpecialEffect = 1
9391:             .Format = "K"
9392:             .InputMask = "999.99"
9393:             .Visible = .T.
9394:         ENDWITH
9395: 
9396:         loc_oAba.AddObject("cbo_4c_AngVlNota", "ComboBox")
9397:         WITH loc_oAba.cbo_4c_AngVlNota
9398:             .Top = 213

*-- Linhas 9435 a 9453:
9435: 
9436:         loc_oAba.AddObject("txt_4c_NoSeloL", "TextBox")
9437:         WITH loc_oAba.txt_4c_NoSeloL
9438:             .ControlSource = "crSigCnFNf.lcnfselo"
9439:             .Top = 213
9440:             .Left = 343
9441:             .Width = 41
9442:             .Height = 18
9443:             .FontName = "Tahoma"
9444:             .FontSize = 8
9445:             .SpecialEffect = 1
9446:             .Format = "K"
9447:             .InputMask = "999.99"
9448:             .Visible = .T.
9449:         ENDWITH
9450: 
9451:         loc_oAba.AddObject("lbl_4c_NoSeloX", "Label")
9452:         WITH loc_oAba.lbl_4c_NoSeloX
9453:             .Caption = "x"

*-- Linhas 9463 a 9481:
9463: 
9464:         loc_oAba.AddObject("txt_4c_NoSeloC", "TextBox")
9465:         WITH loc_oAba.txt_4c_NoSeloC
9466:             .ControlSource = "crSigCnFNf.lcselo"
9467:             .Top = 213
9468:             .Left = 392
9469:             .Width = 41
9470:             .Height = 18
9471:             .FontName = "Tahoma"
9472:             .FontSize = 8
9473:             .SpecialEffect = 1
9474:             .Format = "K"
9475:             .InputMask = "999.99"
9476:             .Visible = .T.
9477:         ENDWITH
9478: 
9479:         loc_oAba.AddObject("cbo_4c_AngSelo", "ComboBox")
9480:         WITH loc_oAba.cbo_4c_AngSelo
9481:             .Top = 213

*-- Linhas 9518 a 9536:
9518: 
9519:         loc_oAba.AddObject("txt_4c_NFSeloL", "TextBox")
9520:         WITH loc_oAba.txt_4c_NFSeloL
9521:             .ControlSource = "crSigCnFNf.lnfsai"
9522:             .Top = 213
9523:             .Left = 499
9524:             .Width = 41
9525:             .Height = 18
9526:             .FontName = "Tahoma"
9527:             .FontSize = 8
9528:             .SpecialEffect = 1
9529:             .Format = "K"
9530:             .InputMask = "999.99"
9531:             .Visible = .T.
9532:         ENDWITH
9533: 
9534:         loc_oAba.AddObject("lbl_4c_NFSeloX", "Label")
9535:         WITH loc_oAba.lbl_4c_NFSeloX
9536:             .Caption = "x"

*-- Linhas 9546 a 9564:
9546: 
9547:         loc_oAba.AddObject("txt_4c_NFSeloC", "TextBox")
9548:         WITH loc_oAba.txt_4c_NFSeloC
9549:             .ControlSource = "crSigCnFNf.cnfsai"
9550:             .Top = 213
9551:             .Left = 548
9552:             .Width = 41
9553:             .Height = 18
9554:             .FontName = "Tahoma"
9555:             .FontSize = 8
9556:             .SpecialEffect = 1
9557:             .Format = "K"
9558:             .InputMask = "999.99"
9559:             .Visible = .T.
9560:         ENDWITH
9561: 
9562:         loc_oAba.AddObject("cbo_4c_AngNFSelo", "ComboBox")
9563:         WITH loc_oAba.cbo_4c_AngNFSelo
9564:             .Top = 213

*-- Linhas 9610 a 9628:
9610: 
9611:         loc_oAba.AddObject("txt_4c_ObsL", "TextBox")
9612:         WITH loc_oAba.txt_4c_ObsL
9613:             .ControlSource = "crSigCnFNf.tamlinobs"
9614:             .Top = 254
9615:             .Left = 44
9616:             .Width = 41
9617:             .Height = 18
9618:             .FontName = "Tahoma"
9619:             .FontSize = 8
9620:             .SpecialEffect = 1
9621:             .Format = "K"
9622:             .InputMask = "999.99"
9623:             .Visible = .T.
9624:         ENDWITH
9625: 
9626:         loc_oAba.AddObject("lbl_4c_ObsX", "Label")
9627:         WITH loc_oAba.lbl_4c_ObsX
9628:             .Caption = "x"

*-- Linhas 9638 a 9656:
9638: 
9639:         loc_oAba.AddObject("txt_4c_ObsC", "TextBox")
9640:         WITH loc_oAba.txt_4c_ObsC
9641:             .ControlSource = "crSigCnFNf.tamcolobs"
9642:             .Top = 254
9643:             .Left = 93
9644:             .Width = 41
9645:             .Height = 18
9646:             .FontName = "Tahoma"
9647:             .FontSize = 8
9648:             .SpecialEffect = 1
9649:             .Format = "K"
9650:             .InputMask = "999.99"
9651:             .Visible = .T.
9652:         ENDWITH
9653: 
9654:         loc_oAba.AddObject("lbl_4c_LblNoCols2", "Label")
9655:         WITH loc_oAba.lbl_4c_LblNoCols2
9656:             .Caption = "No. Colunas"

*-- Linhas 9666 a 9684:
9666: 
9667:         loc_oAba.AddObject("txt_4c_ObsNoCol", "TextBox")
9668:         WITH loc_oAba.txt_4c_ObsNoCol
9669:             .ControlSource = "crSigCnFNf.nldser"
9670:             .Top = 254
9671:             .Left = 194
9672:             .Width = 41
9673:             .Height = 18
9674:             .FontName = "Tahoma"
9675:             .FontSize = 8
9676:             .SpecialEffect = 1
9677:             .Format = "K"
9678:             .InputMask = "999.99"
9679:             .Visible = .T.
9680:         ENDWITH
9681: 
9682:         loc_oAba.AddObject("lbl_4c_LblNoLins2", "Label")
9683:         WITH loc_oAba.lbl_4c_LblNoLins2
9684:             .Caption = "No. Linhas"

*-- Linhas 9694 a 9712:
9694: 
9695:         loc_oAba.AddObject("txt_4c_ObsNoLin", "TextBox")
9696:         WITH loc_oAba.txt_4c_ObsNoLin
9697:             .ControlSource = "crSigCnFNf.ncdser"
9698:             .Top = 254
9699:             .Left = 256
9700:             .Width = 41
9701:             .Height = 18
9702:             .FontName = "Tahoma"
9703:             .FontSize = 8
9704:             .SpecialEffect = 1
9705:             .Format = "K"
9706:             .InputMask = "999.99"
9707:             .Visible = .T.
9708:         ENDWITH
9709: 
9710:         *-- Angulo obs
9711:         loc_oAba.AddObject("cbo_4c_AngObs", "ComboBox")
9712:         WITH loc_oAba.cbo_4c_AngObs

*-- Linhas 9750 a 9768:
9750: 
9751:         loc_oAba.AddObject("txt_4c_NPedSubL1", "TextBox")
9752:         WITH loc_oAba.txt_4c_NPedSubL1
9753:             .ControlSource = "crSigCnFNf.ldupnum"
9754:             .Top = 254
9755:             .Left = 332
9756:             .Width = 41
9757:             .Height = 18
9758:             .FontName = "Tahoma"
9759:             .FontSize = 8
9760:             .SpecialEffect = 1
9761:             .Format = "K"
9762:             .InputMask = "999.99"
9763:             .Visible = .T.
9764:         ENDWITH
9765: 
9766:         loc_oAba.AddObject("lbl_4c_NPedSubX1", "Label")
9767:         WITH loc_oAba.lbl_4c_NPedSubX1
9768:             .Caption = "x"

*-- Linhas 9778 a 9796:
9778: 
9779:         loc_oAba.AddObject("txt_4c_NPedSubC1", "TextBox")
9780:         WITH loc_oAba.txt_4c_NPedSubC1
9781:             .ControlSource = "crSigCnFNf.cdupnum"
9782:             .Top = 254
9783:             .Left = 381
9784:             .Width = 41
9785:             .Height = 18
9786:             .FontName = "Tahoma"
9787:             .FontSize = 8
9788:             .SpecialEffect = 1
9789:             .Format = "K"
9790:             .InputMask = "999.99"
9791:             .Visible = .T.
9792:         ENDWITH
9793: 
9794:         loc_oAba.AddObject("lbl_4c_LblNPedSub2", "Label")
9795:         WITH loc_oAba.lbl_4c_LblNPedSub2
9796:             .Caption = "N" + CHR(186) + " Pedidos (SubNivel)"

*-- Linhas 9806 a 9824:
9806: 
9807:         loc_oAba.AddObject("txt_4c_NPedSubL2", "TextBox")
9808:         WITH loc_oAba.txt_4c_NPedSubL2
9809:             .ControlSource = "crSigCnFNf.ldupnum"
9810:             .Top = 254
9811:             .Left = 499
9812:             .Width = 41
9813:             .Height = 18
9814:             .FontName = "Tahoma"
9815:             .FontSize = 8
9816:             .SpecialEffect = 1
9817:             .Format = "K"
9818:             .InputMask = "999.99"
9819:             .Visible = .T.
9820:         ENDWITH
9821: 
9822:         loc_oAba.AddObject("lbl_4c_NPedSubX2", "Label")
9823:         WITH loc_oAba.lbl_4c_NPedSubX2
9824:             .Caption = "x"

*-- Linhas 9834 a 9852:
9834: 
9835:         loc_oAba.AddObject("txt_4c_NPedSubC2", "TextBox")
9836:         WITH loc_oAba.txt_4c_NPedSubC2
9837:             .ControlSource = "crSigCnFNf.cdupnum"
9838:             .Top = 254
9839:             .Left = 548
9840:             .Width = 41
9841:             .Height = 18
9842:             .FontName = "Tahoma"
9843:             .FontSize = 8
9844:             .SpecialEffect = 1
9845:             .Format = "K"
9846:             .InputMask = "999.99"
9847:             .Visible = .T.
9848:         ENDWITH
9849: 
9850:         loc_oAba.AddObject("cbo_4c_AngNPed2", "ComboBox")
9851:         WITH loc_oAba.cbo_4c_AngNPed2
9852:             .Top = 254

*-- Linhas 9895 a 9913:
9895: 
9896:         loc_oAba.AddObject("txt_4c_FatDtEmiL", "TextBox")
9897:         WITH loc_oAba.txt_4c_FatDtEmiL
9898:             .ControlSource = "crSigCnFNf.ldtemi"
9899:             .Top = 43
9900:             .Left = 99
9901:             .Width = 41
9902:             .Height = 18
9903:             .FontName = "Tahoma"
9904:             .FontSize = 8
9905:             .SpecialEffect = 1
9906:             .Format = "K"
9907:             .InputMask = "999.99"
9908:             .Visible = .T.
9909:         ENDWITH
9910: 
9911:         loc_oAba.AddObject("lbl_4c_FatDtEmiX", "Label")
9912:         WITH loc_oAba.lbl_4c_FatDtEmiX
9913:             .Caption = "x"

*-- Linhas 9923 a 9941:
9923: 
9924:         loc_oAba.AddObject("txt_4c_FatDtEmiC", "TextBox")
9925:         WITH loc_oAba.txt_4c_FatDtEmiC
9926:             .ControlSource = "crSigCnFNf.cdtemi"
9927:             .Top = 43
9928:             .Left = 148
9929:             .Width = 41
9930:             .Height = 18
9931:             .FontName = "Tahoma"
9932:             .FontSize = 8
9933:             .SpecialEffect = 1
9934:             .Format = "K"
9935:             .InputMask = "999.99"
9936:             .Visible = .T.
9937:         ENDWITH
9938: 
9939:         *-- No NF Fatura (top=31)
9940:         loc_oAba.AddObject("lbl_4c_LblNFatNum", "Label")
9941:         WITH loc_oAba.lbl_4c_LblNFatNum

*-- Linhas 9952 a 9970:
9952: 
9953:         loc_oAba.AddObject("txt_4c_NFatNumL", "TextBox")
9954:         WITH loc_oAba.txt_4c_NFatNumL
9955:             .ControlSource = "crSigCnFNf.lfatnum"
9956:             .Top = 43
9957:             .Left = 231
9958:             .Width = 41
9959:             .Height = 18
9960:             .FontName = "Tahoma"
9961:             .FontSize = 8
9962:             .SpecialEffect = 1
9963:             .Format = "K"
9964:             .InputMask = "999.99"
9965:             .Visible = .T.
9966:         ENDWITH
9967: 
9968:         loc_oAba.AddObject("lbl_4c_NFatNumX", "Label")
9969:         WITH loc_oAba.lbl_4c_NFatNumX
9970:             .Caption = "x"

*-- Linhas 9980 a 9998:
9980: 
9981:         loc_oAba.AddObject("txt_4c_NFatNumC", "TextBox")
9982:         WITH loc_oAba.txt_4c_NFatNumC
9983:             .ControlSource = "crSigCnFNf.cfatnum"
9984:             .Top = 43
9985:             .Left = 280
9986:             .Width = 41
9987:             .Height = 18
9988:             .FontName = "Tahoma"
9989:             .FontSize = 8
9990:             .SpecialEffect = 1
9991:             .Format = "K"
9992:             .InputMask = "999.99"
9993:             .Visible = .T.
9994:         ENDWITH
9995: 
9996:         *-- Data de Saida (top=67)
9997:         loc_oAba.AddObject("lbl_4c_LblFatDtSai", "Label")
9998:         WITH loc_oAba.lbl_4c_LblFatDtSai

*-- Linhas 10009 a 10027:
10009: 
10010:         loc_oAba.AddObject("txt_4c_FatDtSaiL", "TextBox")
10011:         WITH loc_oAba.txt_4c_FatDtSaiL
10012:             .ControlSource = "crSigCnFNf.ldtsaidas"
10013:             .Top = 79
10014:             .Left = 98
10015:             .Width = 41
10016:             .Height = 18
10017:             .FontName = "Tahoma"
10018:             .FontSize = 8
10019:             .SpecialEffect = 1
10020:             .Format = "K"
10021:             .InputMask = "999.99"
10022:             .Visible = .T.
10023:         ENDWITH
10024: 
10025:         loc_oAba.AddObject("lbl_4c_FatDtSaiX", "Label")
10026:         WITH loc_oAba.lbl_4c_FatDtSaiX
10027:             .Caption = "x"

*-- Linhas 10037 a 10055:
10037: 
10038:         loc_oAba.AddObject("txt_4c_FatDtSaiC", "TextBox")
10039:         WITH loc_oAba.txt_4c_FatDtSaiC
10040:             .ControlSource = "crSigCnFNf.cdtsaidas"
10041:             .Top = 79
10042:             .Left = 147
10043:             .Width = 41
10044:             .Height = 18
10045:             .FontName = "Tahoma"
10046:             .FontSize = 8
10047:             .SpecialEffect = 1
10048:             .Format = "K"
10049:             .InputMask = "999.99"
10050:             .Visible = .T.
10051:         ENDWITH
10052: 
10053:         *-- Numero Duplicata (top=67)
10054:         loc_oAba.AddObject("lbl_4c_LblDuplNum", "Label")
10055:         WITH loc_oAba.lbl_4c_LblDuplNum

*-- Linhas 10066 a 10084:
10066: 
10067:         loc_oAba.AddObject("txt_4c_DuplNumL", "TextBox")
10068:         WITH loc_oAba.txt_4c_DuplNumL
10069:             .ControlSource = "crSigCnFNf.ldupnum"
10070:             .Top = 79
10071:             .Left = 231
10072:             .Width = 41
10073:             .Height = 18
10074:             .FontName = "Tahoma"
10075:             .FontSize = 8
10076:             .SpecialEffect = 1
10077:             .Format = "K"
10078:             .InputMask = "999.99"
10079:             .Visible = .T.
10080:         ENDWITH
10081: 
10082:         loc_oAba.AddObject("lbl_4c_DuplNumX", "Label")
10083:         WITH loc_oAba.lbl_4c_DuplNumX
10084:             .Caption = "x"

*-- Linhas 10094 a 10112:
10094: 
10095:         loc_oAba.AddObject("txt_4c_DuplNumC", "TextBox")
10096:         WITH loc_oAba.txt_4c_DuplNumC
10097:             .ControlSource = "crSigCnFNf.cdupnum"
10098:             .Top = 79
10099:             .Left = 280
10100:             .Width = 41
10101:             .Height = 18
10102:             .FontName = "Tahoma"
10103:             .FontSize = 8
10104:             .SpecialEffect = 1
10105:             .Format = "K"
10106:             .InputMask = "999.99"
10107:             .Visible = .T.
10108:         ENDWITH
10109: 
10110:         *-- Valor Total da Nota (top=103)
10111:         loc_oAba.AddObject("lbl_4c_LblFatVlNota", "Label")
10112:         WITH loc_oAba.lbl_4c_LblFatVlNota

*-- Linhas 10123 a 10141:
10123: 
10124:         loc_oAba.AddObject("txt_4c_FatVlNotaL", "TextBox")
10125:         WITH loc_oAba.txt_4c_FatVlNotaL
10126:             .ControlSource = "crSigCnFNf.ltnota"
10127:             .Top = 115
10128:             .Left = 99
10129:             .Width = 41
10130:             .Height = 18
10131:             .FontName = "Tahoma"
10132:             .FontSize = 8
10133:             .SpecialEffect = 1
10134:             .Format = "K"
10135:             .InputMask = "999.99"
10136:             .Visible = .T.
10137:         ENDWITH
10138: 
10139:         loc_oAba.AddObject("lbl_4c_FatVlNotaX", "Label")
10140:         WITH loc_oAba.lbl_4c_FatVlNotaX
10141:             .Caption = "x"

*-- Linhas 10151 a 10169:
10151: 
10152:         loc_oAba.AddObject("txt_4c_FatVlNotaC", "TextBox")
10153:         WITH loc_oAba.txt_4c_FatVlNotaC
10154:             .ControlSource = "crSigCnFNf.ctnota"
10155:             .Top = 115
10156:             .Left = 148
10157:             .Width = 41
10158:             .Height = 18
10159:             .FontName = "Tahoma"
10160:             .FontSize = 8
10161:             .SpecialEffect = 1
10162:             .Format = "K"
10163:             .InputMask = "999.99"
10164:             .Visible = .T.
10165:         ENDWITH
10166: 
10167:         *-- Valor por Extenso (top=103)
10168:         loc_oAba.AddObject("lbl_4c_LblValExt", "Label")
10169:         WITH loc_oAba.lbl_4c_LblValExt

*-- Linhas 10180 a 10198:
10180: 
10181:         loc_oAba.AddObject("txt_4c_ValExtL", "TextBox")
10182:         WITH loc_oAba.txt_4c_ValExtL
10183:             .ControlSource = "crSigCnFNf.lvalext"
10184:             .Top = 115
10185:             .Left = 231
10186:             .Width = 41
10187:             .Height = 18
10188:             .FontName = "Tahoma"
10189:             .FontSize = 8
10190:             .SpecialEffect = 1
10191:             .Format = "K"
10192:             .InputMask = "999.99"
10193:             .Visible = .T.
10194:         ENDWITH
10195: 
10196:         loc_oAba.AddObject("lbl_4c_ValExtX", "Label")
10197:         WITH loc_oAba.lbl_4c_ValExtX
10198:             .Caption = "x"

*-- Linhas 10208 a 10226:
10208: 
10209:         loc_oAba.AddObject("txt_4c_ValExtC", "TextBox")
10210:         WITH loc_oAba.txt_4c_ValExtC
10211:             .ControlSource = "crSigCnFNf.cvalext"
10212:             .Top = 115
10213:             .Left = 280
10214:             .Width = 41
10215:             .Height = 18
10216:             .FontName = "Tahoma"
10217:             .FontSize = 8
10218:             .SpecialEffect = 1
10219:             .Format = "K"
10220:             .InputMask = "999.99"
10221:             .Visible = .T.
10222:         ENDWITH
10223: 
10224:         *-- Vencimento (top=138)
10225:         loc_oAba.AddObject("lbl_4c_LblFatVecto", "Label")
10226:         WITH loc_oAba.lbl_4c_LblFatVecto

*-- Linhas 10237 a 10255:
10237: 
10238:         loc_oAba.AddObject("txt_4c_FatVectoL", "TextBox")
10239:         WITH loc_oAba.txt_4c_FatVectoL
10240:             .ControlSource = "crSigCnFNf.lfatvec"
10241:             .Top = 150
10242:             .Left = 99
10243:             .Width = 41
10244:             .Height = 18
10245:             .FontName = "Tahoma"
10246:             .FontSize = 8
10247:             .SpecialEffect = 1
10248:             .Format = "K"
10249:             .InputMask = "999.99"
10250:             .Visible = .T.
10251:         ENDWITH
10252: 
10253:         loc_oAba.AddObject("lbl_4c_FatVectoX", "Label")
10254:         WITH loc_oAba.lbl_4c_FatVectoX
10255:             .Caption = "x"

*-- Linhas 10265 a 10283:
10265: 
10266:         loc_oAba.AddObject("txt_4c_FatVectoC", "TextBox")
10267:         WITH loc_oAba.txt_4c_FatVectoC
10268:             .ControlSource = "crSigCnFNf.cfatvec"
10269:             .Top = 150
10270:             .Left = 148
10271:             .Width = 41
10272:             .Height = 18
10273:             .FontName = "Tahoma"
10274:             .FontSize = 8
10275:             .SpecialEffect = 1
10276:             .Format = "K"
10277:             .InputMask = "999.99"
10278:             .Visible = .T.
10279:         ENDWITH
10280:     ENDPROC
10281: 
10282:     *--------------------------------------------------------------------------
10283:     PROTECTED PROCEDURE ConfigurarServicosTab()

*-- Linhas 10300 a 10318:
10300: 
10301:         loc_oAba.AddObject("txt_4c_SrvDescL", "TextBox")
10302:         WITH loc_oAba.txt_4c_SrvDescL
10303:             .ControlSource = "crSigCnFNf.ldescser"
10304:             .Top = 43
10305:             .Left = 107
10306:             .Width = 41
10307:             .Height = 18
10308:             .FontName = "Tahoma"
10309:             .FontSize = 8
10310:             .SpecialEffect = 1
10311:             .Format = "K"
10312:             .InputMask = "999.99"
10313:             .Visible = .T.
10314:         ENDWITH
10315: 
10316:         loc_oAba.AddObject("lbl_4c_SrvDescX", "Label")
10317:         WITH loc_oAba.lbl_4c_SrvDescX
10318:             .Caption = "x"

*-- Linhas 10328 a 10346:
10328: 
10329:         loc_oAba.AddObject("txt_4c_SrvDescC", "TextBox")
10330:         WITH loc_oAba.txt_4c_SrvDescC
10331:             .ControlSource = "crSigCnFNf.cdescser"
10332:             .Top = 43
10333:             .Left = 156
10334:             .Width = 41
10335:             .Height = 18
10336:             .FontName = "Tahoma"
10337:             .FontSize = 8
10338:             .SpecialEffect = 1
10339:             .Format = "K"
10340:             .InputMask = "999.99"
10341:             .Visible = .T.
10342:         ENDWITH
10343: 
10344:         *-- No. Colunas (top=31)
10345:         loc_oAba.AddObject("lbl_4c_LblSrvNoCols", "Label")
10346:         WITH loc_oAba.lbl_4c_LblSrvNoCols

*-- Linhas 10357 a 10375:
10357: 
10358:         loc_oAba.AddObject("txt_4c_SrvNoCols", "TextBox")
10359:         WITH loc_oAba.txt_4c_SrvNoCols
10360:             .ControlSource = "crSigCnFNf.nldser"
10361:             .Top = 43
10362:             .Left = 214
10363:             .Width = 41
10364:             .Height = 18
10365:             .FontName = "Tahoma"
10366:             .FontSize = 8
10367:             .SpecialEffect = 1
10368:             .Format = "K"
10369:             .InputMask = "999.99"
10370:             .Visible = .T.
10371:         ENDWITH
10372: 
10373:         *-- No. Linhas (top=31)
10374:         loc_oAba.AddObject("lbl_4c_LblSrvNoLins", "Label")
10375:         WITH loc_oAba.lbl_4c_LblSrvNoLins

*-- Linhas 10386 a 10404:
10386: 
10387:         loc_oAba.AddObject("txt_4c_SrvNoLins", "TextBox")
10388:         WITH loc_oAba.txt_4c_SrvNoLins
10389:             .ControlSource = "crSigCnFNf.ncdser"
10390:             .Top = 43
10391:             .Left = 273
10392:             .Width = 41
10393:             .Height = 18
10394:             .FontName = "Tahoma"
10395:             .FontSize = 8
10396:             .SpecialEffect = 1
10397:             .Format = "K"
10398:             .InputMask = "999.99"
10399:             .Visible = .T.
10400:         ENDWITH
10401: 
10402:         *-- Valor I.S.S (top=81)
10403:         loc_oAba.AddObject("lbl_4c_LblValISS", "Label")
10404:         WITH loc_oAba.lbl_4c_LblValISS

*-- Linhas 10415 a 10433:
10415: 
10416:         loc_oAba.AddObject("txt_4c_ValISSL", "TextBox")
10417:         WITH loc_oAba.txt_4c_ValISSL
10418:             .ControlSource = "crSigCnFNf.lvaliss"
10419:             .Top = 93
10420:             .Left = 107
10421:             .Width = 41
10422:             .Height = 18
10423:             .FontName = "Tahoma"
10424:             .FontSize = 8
10425:             .SpecialEffect = 1
10426:             .Format = "K"
10427:             .InputMask = "999.99"
10428:             .Visible = .T.
10429:         ENDWITH
10430: 
10431:         loc_oAba.AddObject("lbl_4c_ValISSX", "Label")
10432:         WITH loc_oAba.lbl_4c_ValISSX
10433:             .Caption = "x"

*-- Linhas 10443 a 10461:
10443: 
10444:         loc_oAba.AddObject("txt_4c_ValISSC", "TextBox")
10445:         WITH loc_oAba.txt_4c_ValISSC
10446:             .ControlSource = "crSigCnFNf.cvaliss"
10447:             .Top = 93
10448:             .Left = 156
10449:             .Width = 41
10450:             .Height = 18
10451:             .FontName = "Tahoma"
10452:             .FontSize = 8
10453:             .SpecialEffect = 1
10454:             .Format = "K"
10455:             .InputMask = "999.99"
10456:             .Visible = .T.
10457:         ENDWITH
10458: 
10459:         *-- Valor Total Servicos (top=113)
10460:         loc_oAba.AddObject("lbl_4c_LblValSrv", "Label")
10461:         WITH loc_oAba.lbl_4c_LblValSrv

*-- Linhas 10472 a 10490:
10472: 
10473:         loc_oAba.AddObject("txt_4c_ValSrvL", "TextBox")
10474:         WITH loc_oAba.txt_4c_ValSrvL
10475:             .ControlSource = "crSigCnFNf.lvalser"
10476:             .Top = 125
10477:             .Left = 107
10478:             .Width = 41
10479:             .Height = 18
10480:             .FontName = "Tahoma"
10481:             .FontSize = 8
10482:             .SpecialEffect = 1
10483:             .Format = "K"
10484:             .InputMask = "999.99"
10485:             .Visible = .T.
10486:         ENDWITH
10487: 
10488:         loc_oAba.AddObject("lbl_4c_ValSrvX", "Label")
10489:         WITH loc_oAba.lbl_4c_ValSrvX
10490:             .Caption = "x"

*-- Linhas 10500 a 10518:
10500: 
10501:         loc_oAba.AddObject("txt_4c_ValSrvC", "TextBox")
10502:         WITH loc_oAba.txt_4c_ValSrvC
10503:             .ControlSource = "crSigCnFNf.cvalser"
10504:             .Top = 125
10505:             .Left = 156
10506:             .Width = 41
10507:             .Height = 18
10508:             .FontName = "Tahoma"
10509:             .FontSize = 8
10510:             .SpecialEffect = 1
10511:             .Format = "K"
10512:             .InputMask = "999.99"
10513:             .Visible = .T.
10514:         ENDWITH
10515:     ENDPROC
10516: 
10517:     *--------------------------------------------------------------------------
10518:     PROTECTED PROCEDURE ConfigurarOutrosTab()

*-- Linhas 10558 a 10576:
10558: 
10559:         loc_oAba.AddObject("txt_4c_EspPad", "TextBox")
10560:         WITH loc_oAba.txt_4c_EspPad
10561:             .ControlSource = "crSigCnFNf.esppads"
10562:             .Top = 65
10563:             .Left = 243
10564:             .Width = 92
10565:             .Height = 18
10566:             .FontName = "Tahoma"
10567:             .FontSize = 8
10568:             .SpecialEffect = 1
10569:             .Format = "K"
10570:             .InputMask = ""
10571:             .Visible = .T.
10572:         ENDWITH
10573: 
10574:         *-- Marca Padrao (top=42)
10575:         loc_oAba.AddObject("lbl_4c_LblMarPad", "Label")
10576:         WITH loc_oAba.lbl_4c_LblMarPad

*-- Linhas 10587 a 10605:
10587: 
10588:         loc_oAba.AddObject("txt_4c_MarPad", "TextBox")
10589:         WITH loc_oAba.txt_4c_MarPad
10590:             .ControlSource = "crSigCnFNf.marpads"
10591:             .Top = 40
10592:             .Left = 243
10593:             .Width = 92
10594:             .Height = 18
10595:             .FontName = "Tahoma"
10596:             .FontSize = 8
10597:             .SpecialEffect = 1
10598:             .Format = "K"
10599:             .InputMask = ""
10600:             .Visible = .T.
10601:         ENDWITH
10602: 
10603:         *-- Fator de Peso Bruto (top=93)
10604:         loc_oAba.AddObject("lbl_4c_LblFatPBru", "Label")
10605:         WITH loc_oAba.lbl_4c_LblFatPBru

*-- Linhas 10616 a 10634:
10616: 
10617:         loc_oAba.AddObject("txt_4c_FatPBru", "TextBox")
10618:         WITH loc_oAba.txt_4c_FatPBru
10619:             .ControlSource = "crSigCnFNf.fatbrutos"
10620:             .Top = 91
10621:             .Left = 243
10622:             .Width = 58
10623:             .Height = 18
10624:             .FontName = "Tahoma"
10625:             .FontSize = 8
10626:             .SpecialEffect = 1
10627:             .Format = "K"
10628:             .InputMask = "999.99"
10629:             .Visible = .T.
10630:         ENDWITH
10631: 
10632:         *-- Peso por Volume (top=117)
10633:         loc_oAba.AddObject("lbl_4c_LblPesVol", "Label")
10634:         WITH loc_oAba.lbl_4c_LblPesVol

*-- Linhas 10645 a 10663:
10645: 
10646:         loc_oAba.AddObject("txt_4c_PesVol", "TextBox")
10647:         WITH loc_oAba.txt_4c_PesVol
10648:             .ControlSource = "crSigCnFNf.pesovols"
10649:             .Top = 115
10650:             .Left = 243
10651:             .Width = 66
10652:             .Height = 18
10653:             .FontName = "Tahoma"
10654:             .FontSize = 8
10655:             .SpecialEffect = 1
10656:             .Format = "K"
10657:             .InputMask = "999.99"
10658:             .Visible = .T.
10659:         ENDWITH
10660: 
10661:         loc_oAba.AddObject("lbl_4c_LblGrs", "Label")
10662:         WITH loc_oAba.lbl_4c_LblGrs
10663:             .Caption = "( grs )"

*-- Linhas 10687 a 10721:
10687: 
10688:         loc_oAba.AddObject("txt_4c_EmpPad", "TextBox")
10689:         WITH loc_oAba.txt_4c_EmpPad
10690:             .ControlSource = "crSigCnFNf.emps"
10691:             .Top = 140
10692:             .Left = 243
10693:             .Width = 31
10694:             .Height = 18
10695:             .FontName = "Tahoma"
10696:             .FontSize = 8
10697:             .SpecialEffect = 1
10698:             .Format = "K"
10699:             .InputMask = ""
10700:             .Visible = .T.
10701:         ENDWITH
10702: 
10703:         *-- Validar Sequencia de Notas (top=162)
10704:         loc_oAba.AddObject("chk_4c_ValidSeqNota", "CheckBox")
10705:         WITH loc_oAba.chk_4c_ValidSeqNota
10706:             .ControlSource = "crSigCnFNf.vseqnota"
10707:             .Caption = "Validar Sequ" + CHR(234) + "ncia de Notas :"
10708:             .Top = 162
10709:             .Left = 88
10710:             .Width = 155
10711:             .Height = 15
10712:             .FontName = "Tahoma"
10713:             .FontSize = 7
10714:             .Visible = .T.
10715:             .Sparse = .F.
10716:             .Alignment = 0
10717:             .ReadOnly = .F.
10718:         ENDWITH
10719: 
10720:         *-- Dados da Operacao - Localizacao (top=53, left=405)
10721:         loc_oAba.AddObject("lbl_4c_LblLoc", "Label")

*-- Linhas 10733 a 10751:
10733: 
10734:         loc_oAba.AddObject("txt_4c_LocL", "TextBox")
10735:         WITH loc_oAba.txt_4c_LocL
10736:             .ControlSource = "crSigCnFNf.loploc"
10737:             .Top = 65
10738:             .Left = 405
10739:             .Width = 41
10740:             .Height = 18
10741:             .FontName = "Tahoma"
10742:             .FontSize = 8
10743:             .SpecialEffect = 1
10744:             .Format = "K"
10745:             .InputMask = "999.99"
10746:             .Visible = .T.
10747:         ENDWITH
10748: 
10749:         loc_oAba.AddObject("lbl_4c_LocX", "Label")
10750:         WITH loc_oAba.lbl_4c_LocX
10751:             .Caption = "x"

*-- Linhas 10761 a 10779:
10761: 
10762:         loc_oAba.AddObject("txt_4c_LocC", "TextBox")
10763:         WITH loc_oAba.txt_4c_LocC
10764:             .ControlSource = "crSigCnFNf.coploc"
10765:             .Top = 65
10766:             .Left = 454
10767:             .Width = 41
10768:             .Height = 18
10769:             .FontName = "Tahoma"
10770:             .FontSize = 8
10771:             .SpecialEffect = 1
10772:             .Format = "K"
10773:             .InputMask = "999.99"
10774:             .Visible = .T.
10775:         ENDWITH
10776: 
10777:         *-- Vendedor (top=85, left=405)
10778:         loc_oAba.AddObject("lbl_4c_LblVend", "Label")
10779:         WITH loc_oAba.lbl_4c_LblVend

*-- Linhas 10790 a 10808:
10790: 
10791:         loc_oAba.AddObject("txt_4c_VendL", "TextBox")
10792:         WITH loc_oAba.txt_4c_VendL
10793:             .ControlSource = "crSigCnFNf.lopnvd"
10794:             .Top = 97
10795:             .Left = 405
10796:             .Width = 41
10797:             .Height = 18
10798:             .FontName = "Tahoma"
10799:             .FontSize = 8
10800:             .SpecialEffect = 1
10801:             .Format = "K"
10802:             .InputMask = "999.99"
10803:             .Visible = .T.
10804:         ENDWITH
10805: 
10806:         loc_oAba.AddObject("lbl_4c_VendX", "Label")
10807:         WITH loc_oAba.lbl_4c_VendX
10808:             .Caption = "x"

*-- Linhas 10818 a 10836:
10818: 
10819:         loc_oAba.AddObject("txt_4c_VendC", "TextBox")
10820:         WITH loc_oAba.txt_4c_VendC
10821:             .ControlSource = "crSigCnFNf.copnvd"
10822:             .Top = 97
10823:             .Left = 454
10824:             .Width = 41
10825:             .Height = 18
10826:             .FontName = "Tahoma"
10827:             .FontSize = 8
10828:             .SpecialEffect = 1
10829:             .Format = "K"
10830:             .InputMask = "999.99"
10831:             .Visible = .T.
10832:         ENDWITH
10833: 
10834:         *-- Nome do Vendedor (top=85, left=507)
10835:         loc_oAba.AddObject("lbl_4c_LblNomeVend", "Label")
10836:         WITH loc_oAba.lbl_4c_LblNomeVend

*-- Linhas 10847 a 10865:
10847: 
10848:         loc_oAba.AddObject("txt_4c_NomeVendL", "TextBox")
10849:         WITH loc_oAba.txt_4c_NomeVendL
10850:             .ControlSource = "crSigCnFNf.lopcvd"
10851:             .Top = 97
10852:             .Left = 507
10853:             .Width = 41
10854:             .Height = 18
10855:             .FontName = "Tahoma"
10856:             .FontSize = 8
10857:             .SpecialEffect = 1
10858:             .Format = "K"
10859:             .InputMask = "999.99"
10860:             .Visible = .T.
10861:         ENDWITH
10862: 
10863:         loc_oAba.AddObject("lbl_4c_NomeVendX", "Label")
10864:         WITH loc_oAba.lbl_4c_NomeVendX
10865:             .Caption = "x"

*-- Linhas 10875 a 10893:
10875: 
10876:         loc_oAba.AddObject("txt_4c_NomeVendC", "TextBox")
10877:         WITH loc_oAba.txt_4c_NomeVendC
10878:             .ControlSource = "crSigCnFNf.copcvd"
10879:             .Top = 97
10880:             .Left = 556
10881:             .Width = 41
10882:             .Height = 18
10883:             .FontName = "Tahoma"
10884:             .FontSize = 8
10885:             .SpecialEffect = 1
10886:             .Format = "K"
10887:             .InputMask = "999.99"
10888:             .Visible = .T.
10889:         ENDWITH
10890: 
10891:         *-- Responsavel (top=117, left=405)
10892:         loc_oAba.AddObject("lbl_4c_LblResp", "Label")
10893:         WITH loc_oAba.lbl_4c_LblResp

*-- Linhas 10904 a 10922:
10904: 
10905:         loc_oAba.AddObject("txt_4c_RespL", "TextBox")
10906:         WITH loc_oAba.txt_4c_RespL
10907:             .ControlSource = "crSigCnFNf.lopnrp"
10908:             .Top = 129
10909:             .Left = 405
10910:             .Width = 41
10911:             .Height = 18
10912:             .FontName = "Tahoma"
10913:             .FontSize = 8
10914:             .SpecialEffect = 1
10915:             .Format = "K"
10916:             .InputMask = "999.99"
10917:             .Visible = .T.
10918:         ENDWITH
10919: 
10920:         loc_oAba.AddObject("lbl_4c_RespX", "Label")
10921:         WITH loc_oAba.lbl_4c_RespX
10922:             .Caption = "x"

*-- Linhas 10932 a 10950:
10932: 
10933:         loc_oAba.AddObject("txt_4c_RespC", "TextBox")
10934:         WITH loc_oAba.txt_4c_RespC
10935:             .ControlSource = "crSigCnFNf.copnrp"
10936:             .Top = 129
10937:             .Left = 454
10938:             .Width = 41
10939:             .Height = 18
10940:             .FontName = "Tahoma"
10941:             .FontSize = 8
10942:             .SpecialEffect = 1
10943:             .Format = "K"
10944:             .InputMask = "999.99"
10945:             .Visible = .T.
10946:         ENDWITH
10947: 
10948:         *-- Nome do Responsavel (top=117, left=507)
10949:         loc_oAba.AddObject("lbl_4c_LblNomeResp", "Label")
10950:         WITH loc_oAba.lbl_4c_LblNomeResp

*-- Linhas 10961 a 10979:
10961: 
10962:         loc_oAba.AddObject("txt_4c_NomeRespL", "TextBox")
10963:         WITH loc_oAba.txt_4c_NomeRespL
10964:             .ControlSource = "crSigCnFNf.lopcvd"
10965:             .Top = 129
10966:             .Left = 507
10967:             .Width = 41
10968:             .Height = 18
10969:             .FontName = "Tahoma"
10970:             .FontSize = 8
10971:             .SpecialEffect = 1
10972:             .Format = "K"
10973:             .InputMask = "999.99"
10974:             .Visible = .T.
10975:         ENDWITH
10976: 
10977:         loc_oAba.AddObject("lbl_4c_NomeRespX", "Label")
10978:         WITH loc_oAba.lbl_4c_NomeRespX
10979:             .Caption = "x"

*-- Linhas 10989 a 11007:
10989: 
10990:         loc_oAba.AddObject("txt_4c_NomeRespC", "TextBox")
10991:         WITH loc_oAba.txt_4c_NomeRespC
10992:             .ControlSource = "crSigCnFNf.copcvd"
10993:             .Top = 129
10994:             .Left = 556
10995:             .Width = 41
10996:             .Height = 18
10997:             .FontName = "Tahoma"
10998:             .FontSize = 8
10999:             .SpecialEffect = 1
11000:             .Format = "K"
11001:             .InputMask = "999.99"
11002:             .Visible = .T.
11003:         ENDWITH
11004: 
11005:         *-- N Vias (top=184)
11006:         loc_oAba.AddObject("lbl_4c_LblNVias", "Label")
11007:         WITH loc_oAba.lbl_4c_LblNVias

*-- Linhas 11018 a 11036:
11018: 
11019:         loc_oAba.AddObject("txt_4c_NVias", "TextBox")
11020:         WITH loc_oAba.txt_4c_NVias
11021:             .ControlSource = "crSigCnFNf.tipos"
11022:             .Top = 184
11023:             .Left = 243
11024:             .Width = 31
11025:             .Height = 18
11026:             .FontName = "Tahoma"
11027:             .FontSize = 8
11028:             .SpecialEffect = 1
11029:             .Format = "K"
11030:             .InputMask = ""
11031:             .Visible = .T.
11032:         ENDWITH
11033: 
11034:         *-- Fator Proporcao Linha (top=205)
11035:         loc_oAba.AddObject("lbl_4c_LblFatPropLin", "Label")
11036:         WITH loc_oAba.lbl_4c_LblFatPropLin

*-- Linhas 11047 a 11065:
11047: 
11048:         loc_oAba.AddObject("txt_4c_FatPropLin", "TextBox")
11049:         WITH loc_oAba.txt_4c_FatPropLin
11050:             .ControlSource = "crSigCnFNf.tamanhos"
11051:             .Top = 203
11052:             .Left = 243
11053:             .Width = 66
11054:             .Height = 18
11055:             .FontName = "Tahoma"
11056:             .FontSize = 8
11057:             .SpecialEffect = 1
11058:             .Format = "K"
11059:             .InputMask = "999.99"
11060:             .Visible = .T.
11061:         ENDWITH
11062:     ENDPROC
11063: 
11064: 
11065: 

