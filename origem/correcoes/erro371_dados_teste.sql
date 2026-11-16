-- =============================================================================
-- Erro371 (imagem erro371.png) - Dados de TESTE para "Relatorio de Historico de Produtos"
--           (Formsigrehpr / sigrehprBO / SigRehp1.frx)
-- Filtros da imagem: Referencia | Grupo 11210 | Periodo 01/01/2000 a 16/11/2026 |
--                    Empresa 001 | Custo Medio = Sim | Observacao = Nao
-- O historico existente no grupo 11210 so tem ENTRADAS com custo 0 e sem obs.
-- Cria o produto T371 (clone do 210 - grupo BRO, tipoestos 1, unidade PAR) no
-- estoque 001/11210/1121001 com 6 movimentos (entradas e saidas, custo medio,
-- observacao), usando DOCUMENTOS REAIS (PEDIDO RESUMO 30/37, VENDA 29/32/33)
-- para Origem/Destino e Nota Fiscal sairem preenchidos:
--   T371H001 20/12/1999 E 10  -> FORA do periodo (prova o filtro de data)
--   T371H002 10/01/2024 E 10  saldo 10  custo 150,00  PEDIDO RESUMO 30
--   T371H003 05/02/2024 S  3  saldo  7  custo 150,00  VENDA 33 (NF 000030) obs
--   T371H004 15/06/2024 E  5  saldo 12  custo 155,00  PEDIDO RESUMO 37    obs
--   T371H005 20/03/2025 S  4  saldo  8  custo 155,00  VENDA 32 (NF 000029)
--   T371H006 10/11/2026 S  1  saldo  7  custo 155,00  VENDA 29 (NF 000026) obs
-- Codigos de barra 99371001..99371006 no historico; SigCdPro.cbars = 99371003
-- (modo "Codigo de Barras" com 99371003 traz so a venda de 05/02/2024).
-- Marcadores: SigCdPro.cpros='T371' | SigMvEst/SigMvHst.cidchaves LIKE 'T371%'
-- Idempotente. Limpeza: erro371_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;
DELETE FROM SigMvHst WHERE cidchaves LIKE 'T371%';
DELETE FROM SigMvEst WHERE cidchaves LIKE 'T371%';
DELETE FROM SigCdPro WHERE cpros = 'T371';

-- Produto
SELECT * INTO #p FROM SigCdPro WHERE cpros = '210';
UPDATE #p SET cpros = 'T371', dpros = 'PRODUTO TESTE ERRO371', cbars = 99371003; -- cbars proprio (o do 210 colidiria)
INSERT INTO SigCdPro SELECT * FROM #p;
DROP TABLE #p;

-- Saldo de estoque (usado no modo "Geral Por Referencia")
SELECT * INTO #e FROM SigMvEst WHERE cidchaves = '00123120617043450000';
UPDATE #e SET cidchaves = 'T371EST', cpros = 'T371', sqtds = 7, spesos = 0;
INSERT INTO SigMvEst SELECT * FROM #e;
DROP TABLE #e;

-- Historico
SELECT * INTO #h0 FROM SigMvHst WHERE cidchaves = '20231206E000076';
DECLARE @i int = 1;
WHILE @i <= 6
BEGIN
    SELECT * INTO #h FROM #h0;
    UPDATE #h SET
        cidchaves  = 'T371H00' + CAST(@i AS varchar(1)),
        cpros      = 'T371',
        codbarras  = 99371000 + @i,
        datas      = CASE @i WHEN 1 THEN '19991220' WHEN 2 THEN '20240110' WHEN 3 THEN '20240205'
                             WHEN 4 THEN '20240615' WHEN 5 THEN '20250320' ELSE '20261110' END,
        opers      = CASE WHEN @i IN (3,5,6) THEN 'S' ELSE 'E' END,
        qtds       = CASE @i WHEN 1 THEN 10 WHEN 2 THEN 10 WHEN 3 THEN 3 WHEN 4 THEN 5 WHEN 5 THEN 4 ELSE 1 END,
        sqtds      = CASE @i WHEN 1 THEN 10 WHEN 2 THEN 10 WHEN 3 THEN 7 WHEN 4 THEN 12 WHEN 5 THEN 8 ELSE 7 END,
        unitmeds   = CASE WHEN @i <= 3 THEN 150 ELSE 155 END,
        moedmeds   = 'R',
        empos      = '001',
        dopes      = CASE @i WHEN 4 THEN 'PEDIDO RESUMO' WHEN 3 THEN 'VENDA' WHEN 5 THEN 'VENDA' WHEN 6 THEN 'VENDA' ELSE 'PEDIDO RESUMO' END,
        numes      = CASE @i WHEN 1 THEN 30 WHEN 2 THEN 30 WHEN 3 THEN 33 WHEN 4 THEN 37 WHEN 5 THEN 32 ELSE 29 END,
        obs        = CASE @i WHEN 3 THEN 'Venda balcao - teste Erro371'
                             WHEN 4 THEN 'Reposicao de estoque - teste Erro371'
                             WHEN 6 THEN 'Ultima venda do periodo - teste Erro371' ELSE '' END;
    UPDATE #h SET empdopnums = empos + CAST(dopes AS char(20)) + STR(numes, 6);
    INSERT INTO SigMvHst SELECT * FROM #h;
    DROP TABLE #h;
    SET @i = @i + 1;
END
DROP TABLE #h0;

SELECT h.cidchaves, CONVERT(char(10), h.datas, 103) data, h.opers, h.qtds, h.sqtds, h.unitmeds,
       h.empdopnums, c.grupoos, c.contaos, c.grupods, c.contads, c.notas, CAST(h.obs AS varchar(50)) obs
  FROM SigMvHst h LEFT JOIN SigMvCab c ON c.empdopnums = h.empdopnums
 WHERE h.cidchaves LIKE 'T371%' ORDER BY h.cidchaves;
