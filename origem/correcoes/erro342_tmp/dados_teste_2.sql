/*==============================================================================
  Erro342 - BLOCO 2: produtos orfaos do historico (modo "Estoque Retroativo")

  Diagnostico (medido em 2026-11-11 contra 192.168.200.10 / DB_MBAHIA):
    3 de 315 linhas de SigMvHst da empresa 001 apontam para produtos que NAO
    existem mais em SigCdPro:
        cpros '1334'  -> 2 linhas, saldo liquido 2
        cpros '3538'  -> 1 linha,  saldo liquido 1
    Ambos no grupo 11210 / conta 1121001, com saldo <> 0, logo passam pelo
    "Having Sum(...) <> 0" e pelo filtro da grade Selecao.

  O modo retroativo usa LEFT JOIN SigCdPro, entao esses produtos chegam com
  Dpros = .NULL.; o cursor CsTempoCp eh criado com "dpros c(40)" (sem NULL),
  e o Gather estoura:  Field DPROS does not accept null values.

  O LEGADO tem o MESMO LEFT JOIN, o MESMO Create Cursor e NENHUM tratamento de
  nulo (SIGREEQR.processamento) - ou seja, ele quebraria igual nesta base.
  Nao eh defeito de migracao: eh integridade de dados do banco de teste.

  Conserto: recriar os 2 produtos clonando um registro existente (181 colunas,
  160 NOT NULL - clonar evita montar o INSERT coluna a coluna). Muda-se apenas
  cpros, dpros e cbars. SigCdPro nao tem IDENTITY nem coluna calculada, e o
  unico indice unico eh sigcdpro_cpros.
==============================================================================*/
USE DB_MBAHIA;
GO

IF OBJECT_ID('tempdb..#modelo') IS NOT NULL DROP TABLE #modelo;

SELECT TOP 1 * INTO #modelo FROM SigCdPro WHERE RTRIM(Linhas) = '' ORDER BY cpros;

/*-- produto 1334 --*/
IF NOT EXISTS (SELECT 1 FROM SigCdPro WHERE RTRIM(cpros) = '1334')
BEGIN
    UPDATE #modelo SET cpros = '1334', dpros = 'PRODUTO 1334 (RECRIADO P/ TESTE)', cbars = 0;
    INSERT INTO SigCdPro SELECT * FROM #modelo;
    PRINT 'SigCdPro: produto 1334 recriado.';
END
ELSE
    PRINT 'SigCdPro: produto 1334 ja existe - nada feito.';

/*-- produto 3538 --*/
IF NOT EXISTS (SELECT 1 FROM SigCdPro WHERE RTRIM(cpros) = '3538')
BEGIN
    UPDATE #modelo SET cpros = '3538', dpros = 'PRODUTO 3538 (RECRIADO P/ TESTE)', cbars = 0;
    INSERT INTO SigCdPro SELECT * FROM #modelo;
    PRINT 'SigCdPro: produto 3538 recriado.';
END
ELSE
    PRINT 'SigCdPro: produto 3538 ja existe - nada feito.';

DROP TABLE #modelo;
GO

/*-- conferencia: nao pode sobrar nenhum orfao --*/
SELECT COUNT(*) AS linhas_historico_orfas
  FROM SigMvHst a LEFT JOIN SigCdPro c ON a.cpros = c.Cpros
 WHERE a.emps = '001' AND c.Cpros IS NULL;
GO

/*==============================================================================
  DESFAZER
    DELETE FROM SigCdPro WHERE RTRIM(cpros) IN ('1334','3538')
                           AND dpros LIKE '%(RECRIADO P/ TESTE)%';
==============================================================================*/
