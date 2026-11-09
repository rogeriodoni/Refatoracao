-- =============================================================================
-- Erro331 - Dados de TESTE para "Relatorio de Cotacao de Compras"
--           (FormSIGRECTP / SIGRECTPBO / SigReCtp.frx)
-- SigCtTdc = cotacao | SigCtTct = itens (Marca01..06 = vencedor A..F)
-- SigCtTfn = fornecedores da cotacao (Grades A..F) | SigCtTps/SigCtTpc = pedidos
-- As 5 tabelas estavam VAZIAS no banco.
--   932901: aprovada (4CONTROL), COM pedido (Situas=1), 3 itens, 2 pedidos
--   932902: NAO aprovada (LOJA), SEM pedido (Situas=0), 2 itens com vencedor
--           + 1 item sem vencedor (o legado nao imprime item sem Marca)
-- Marcadores: cidchaves LIKE 'T331%' ; codigos 932901/932902
-- Idempotente. Limpeza: erro331_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRAN;

DELETE FROM SigCtTpc WHERE cidchaves LIKE 'T331%';
DELETE FROM SigCtTps WHERE cidchaves LIKE 'T331%';
DELETE FROM SigCtTfn WHERE cidchaves LIKE 'T331%';
DELETE FROM SigCtTct WHERE cidchaves LIKE 'T331%';
DELETE FROM SigCtTdc WHERE cidchaves LIKE 'T331%';

-- Cotacoes
INSERT INTO SigCtTdc (cidchaves, codigos, comprador, deptos, dtcotas, dtpagtos, dtsolics, dtvalids, justificas,
    prioris, situas, solicitas, aprovador, aprsols, chkaprovs, contaes, dtaprovs, dtaprsols, localents,
    obsaprovs, obsaprsols, copias)
VALUES
 ('T331TDC0000000000001', 932901, 'TIAGO', '', '2026-11-09', '2026-12-09', '2026-11-01', '2026-11-30',
  'TESTE Erro331 - compra mensal de metal e acabamento', 1, 1, 'TIAGO', '4CONTROL', '', 1, '', '2026-11-09', NULL, 0, '', '', 0),
 ('T331TDC0000000000002', 932902, 'TIAGO', '', '2026-11-06', '2026-12-06', '2026-11-05', '2026-12-05',
  NULL, 1, 0, 'TIAGO', 'LOJA', '', 0, '', NULL, NULL, 0, '', '', 0);

-- Fornecedores (grade A..F)
INSERT INTO SigCtTfn (cidchaves, codigos, contatos, dtents, fornecs, fpags, grades, iclis, tel1s, fretes, vlfretes)
VALUES
 ('T331TFN0000000000001', 932901, 'COMERCIAL', '2026-11-10', 'NUOVA METAIS EIRELI',     '', 'A', 'F000318', '', '', 0),
 ('T331TFN0000000000002', 932901, 'VENDAS',    '2026-11-12', 'MAHARY METALOQUIMICA',    '', 'B', 'F000319', '', '', 0),
 ('T331TFN0000000000003', 932901, 'SAC',       '2026-11-15', 'TESTE FORNECEDOR',        '', 'C', 'F000030', '', '', 0),
 ('T331TFN0000000000004', 932902, 'VENDAS',    '2026-11-20', 'MAHARY METALOQUIMICA',    '', 'A', 'F000319', '', '', 0),
 ('T331TFN0000000000005', 932902, 'COMERCIAL', '2026-11-22', 'NUOVA METAIS EIRELI',     '', 'B', 'F000318', '', '', 0);

-- Itens (Marca01..06 = vencedor A..F; qtdadqs/valadqs = quantidade/valor adquiridos)
INSERT INTO SigCtTct (cidchaves, citens, codigos, cpros, cunis, dpros, empdopnums, justificas,
    marca01, marca02, marca03, marca04, marca05, marca06, obs, qtdadqs, qtds,
    tota01, tota02, tota03, tota04, tota05, tota06, unit01, unit02, unit03, unit04, unit05, unit06,
    valadqs, codcors, codtams)
VALUES
 ('T331TCT0000000000001', 1, 932901, 'AU 750',    'GR', 'OURO 750',              '', 'Melhor preco por grama',
  1,0,0,0,0,0, NULL, 100, 100, 32000,33500,0,0,0,0, 320,335,0,0,0,0, 32000, '', ''),
 ('T331TCT0000000000002', 2, 932901, 'POLIMENTO', 'GR', 'POLIMENTO',             '', 'Prazo de entrega menor',
  0,1,0,0,0,0, NULL, 50, 50, 800,750,0,0,0,0, 16,15,0,0,0,0, 750, '', ''),
 ('T331TCT0000000000003', 3, 932901, '3595',      'PC', 'Corrente de ouro',      '', 'Unico com estoque',
  0,0,1,0,0,0, NULL, 5, 5, 0,0,4500,0,0,0, 0,0,900,0,0,0, 4500, '', ''),
 ('T331TCT0000000000004', 1, 932902, '338',       'PC', 'Anel ouro  338',        '', 'Menor preco',
  1,0,0,0,0,0, NULL, 10, 10, 9800,10200,0,0,0,0, 980,1020,0,0,0,0, 9800, '', ''),
 ('T331TCT0000000000005', 2, 932902, '1741',      'PC', 'Colar em ouro amarelo', '', 'Melhor acabamento',
  0,1,0,0,0,0, NULL, 3, 3, 5700,5400,0,0,0,0, 1900,1800,0,0,0,0, 5400, '', ''),
 ('T331TCT0000000000006', 3, 932902, 'AU 750',    'GR', 'OURO 750',              '', 'Sem vencedor definido',
  0,0,0,0,0,0, NULL, 20, 20, 6600,6700,0,0,0,0, 330,335,0,0,0,0, 0, '', '');

-- Pedidos gerados pela 932901 (EmpDopNums = emps(3) + dopes(20) + STR(numes,6))
INSERT INTO SigCtTps (cidchaves, codigos, empdopnums)
VALUES
 ('T331TPS0000000000001', 932901, '001' + CAST('PEDIDO RESUMO' AS char(20)) + STR(5001, 6)),
 ('T331TPS0000000000002', 932901, '001' + CAST('PEDIDO RESUMO' AS char(20)) + STR(5002, 6));

INSERT INTO SigCtTpc (cidchaves, cmoes, codigos, codobs, contads, contaes, datars, datas, dopes, emps, grupods, obs)
VALUES ('T331TPC0000000000001', 'R', 932901, 0, '', '', NULL, '2026-11-09', 'PEDIDO RESUMO', '001', '', NULL);

COMMIT;

SELECT d.codigos, d.dtcotas, d.chkaprovs, d.situas, d.aprovador, i.cpros, i.qtdadqs, i.valadqs,
       CASE WHEN i.marca01=1 THEN 'A' WHEN i.marca02=1 THEN 'B' WHEN i.marca03=1 THEN 'C' ELSE '-' END AS vencedor
FROM SigCtTdc d JOIN SigCtTct i ON i.codigos = d.codigos
WHERE d.cidchaves LIKE 'T331%' ORDER BY d.codigos, i.citens;
