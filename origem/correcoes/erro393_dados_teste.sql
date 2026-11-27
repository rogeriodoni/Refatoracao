-- =============================================================================
-- Erro393 - Dados de TESTE para "Gera" + "cao de Arquivos CNAB - Pagamentos"
--           (FormSIGPGCNB / SIGPGCNBBO)
--
-- O QUE JA EXISTE (medido em 25/11/2026) - nao precisa criar:
--   SigMvCcr ... 177 lancamentos atendem o filtro da tela
--                (pagos=1, ContaPgs<>2, opers='C', Nopers<>0, emps='001')
--                vencimentos de 23/11/2023 ate 10/01/2027
--   SigCdGcr ... os grupos aparecem na grade: FORNECEDORES(21101),
--                CLIENTES(11201), FUNCIONARIOS(21102), RECEITA DE VENDAS(41102),
--                TRANSITORIA(TRANSITO)
--   SigPcOol ... 0 linhas com Tipos='SIGPGCNB' -> correto: eh a tabela de
--                controle do que JA foi processado, e vazia faz a opcao
--                "Nao Processadas" devolver tudo.
--
-- A LACUNA: **SigCdCeb esta VAZIA** (0 linhas em toda a tabela).
--   Eh o cadastro de convenio bancario. Sem ela o campo "Empresa do convenio"
--   nao acha nada e o GerarCNAB nao tem como despachar o layout - o
--   DO CASE do form le cursor_4c_Convenio.nbancos:
--       001 = Banco do Brasil | 341 = Itau | 237 = Bradesco | 033 = Santander
--
-- O QUE ESTE SCRIPT CRIA: 1 convenio BRADESCO (nbancos 237, layout 240).
--
--   GruContas eh chave POSICIONAL char(20) = Grupos char(10) + contas char(10)
--   (o form monta assim em "Grupos + contas IN (SELECT GruContas ...)").
--   Usamos o par REAL com mais movimento: FORNECEDORES + F000000029
--     grupos  = '21101     '   (10 chars, com padding)
--     contas  = 'F000000029'   (10 chars)
--     -> GruContas = '21101     F000000029'
--   Qualquer outro par faria o convenio nunca casar com os lancamentos.
--
--   A tabela tem 37 colunas, 29 NOT NULL sem default, e esta VAZIA - entao
--   nao da para clonar: o INSERT lista as 37 explicitamente.
--
-- ANTES DE RODAR: criar a pasta de saida do arquivo CNAB
--     mkdir C:\4c\_cnab_teste
--   (eh o valor de "drive"; o form monta o caminho com ALLTRIM(Convenio.Drive))
--
-- COMO TESTAR DEPOIS DE RODAR: ver erro393_como_testar.md
--
-- Marcador (para limpeza): SigCdCeb.cidchaves LIKE 'ZZTCEB%'
-- Idempotente. Limpeza: erro393_limpar_teste.sql
-- =============================================================================
SET NOCOUNT ON;

DELETE FROM SigCdCeb WHERE cidchaves LIKE 'ZZTCEB%';

INSERT INTO SigCdCeb (
    cidchaves, grucontas, grupos, iclis,
    nbancos, bancos, nagencias, digiagen, agencias,
    ncontas, digagctas, contas, tpctas,
    convenios, arqcnabs, drive, tamcnabs,
    nomes, favorecs, locals, ntrans,
    btels, ramals,
    diasprots, instrus, moras, Multa,
    bcoprincs, msgmulta, bcoimprime,
    tpctarqs, tpctbols,
    descedente, descsacado, desclcpgto,
    datatrans, clidesdes
) VALUES (
    'ZZTCEB00000000000001',          -- cidchaves char(20) - marcador de teste
    '21101     F000000029',          -- grucontas char(20) = grupos(10) + contas(10)
    '21101     ',                    -- grupos  char(10) FORNECEDORES
    'F000000029',                    -- iclis   char(10) conta do fornecedor
    '237',                           -- nbancos char(3)  237 = BRADESCO -> CnabBrades240
    'BRADESCO TESTE 4C',             -- bancos  char(35)
    '001234',                        -- nagencias char(6)
    '5',                             -- digiagen  char(1)
    'AGENCIA TESTE 4C',              -- agencias  char(50)
    '0012345678',                    -- ncontas   char(13)
    '9',                             -- digagctas char(1)
    '0012345678',                    -- contas    char(13)
    'CC',                            -- tpctas    char(2)
    '123456789',                     -- convenios char(9)
    'PGTOTST.REM',                   -- arqcnabs  char(12) nome do arquivo gerado
    'C:\4c\_cnab_teste',             -- drive     char(50) PASTA DE SAIDA (criar antes!)
    1,                               -- tamcnabs  numeric(1,0)
    'CONVENIO TESTE 4C',             -- nomes     char(20)
    'FAVORECIDO TESTE 4C',           -- favorecs  char(40)
    'SAO PAULO',                     -- locals    char(10)
    1,                               -- ntrans    numeric(6,0) sequencial de remessa
    '1133334444',                    -- btels     char(14)
    '0000',                          -- ramals    char(4)
    5,                               -- diasprots numeric(3,0)
    '00',                            -- instrus   char(6)
    0.00,                            -- moras     numeric(5,2)
    0.00,                            -- Multa     numeric(5,2)
    1,                               -- bcoprincs numeric(1,0) banco principal
    0,                               -- msgmulta  numeric(1,0)
    0,                               -- bcoimprime numeric(1,0)
    '   ',                           -- tpctarqs  char(3)
    '   ',                           -- tpctbols  char(3)
    'CEDENTE TESTE 4C',              -- descedente char(20)
    'SACADO TESTE 4C',               -- descsacado char(20)
    'PAGAMENTO DE TESTE - GERADO POR erro393_dados_teste.sql',  -- desclcpgto char(70)
    NULL,                            -- datatrans datetime (nullable)
    NULL                             -- clidesdes datetime (nullable)
);

-- ---------- conferencia -----------------------------------------------------
SELECT cidchaves, '['+grucontas+']' AS grucontas, nbancos, RTRIM(bancos) AS banco,
       nagencias, ncontas, RTRIM(drive) AS pasta_saida, RTRIM(arqcnabs) AS arquivo
  FROM SigCdCeb WHERE cidchaves LIKE 'ZZTCEB%';

-- quantos lancamentos o convenio alcanca
SELECT COUNT(*) AS lancamentos_do_convenio
  FROM SigMvCcr a
 WHERE a.pagos = 1 AND a.ContaPgs <> 2 AND a.opers = 'C' AND a.Nopers <> 0
   AND a.emps = '001'
   AND a.grupos + a.contas = '21101     F000000029';
