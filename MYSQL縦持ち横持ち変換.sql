-- MySQl接続後に「source ファイル名」
-- 一旦テーブル削除
drop table SHOP;

-- テーブル作成
CREATE TABLE SHOP(
    SEQ INT NOT NULL,
    USER_ID VARCHAR(5),
    AREA VARCHAR(10),
    SALE DECIMAL(10, 0),
    PRIMARY KEY (SEQ)
);

-- データの挿入
INSERT INTO SHOP
    (SEQ, USER_ID, AREA, SALE)
VALUES
    (1, 'A', 'tokyo', 1000),
    (2, 'A', 'osaka', 2000),
    (3, 'A', 'nagoya', 3000),
    (4, 'B', 'tokyo', 3000),
    (5, 'B', 'osaka', 1000),
    (6, 'B', 'nagoya', 2000),
    (7, 'C', 'tokyo', 1000),
    (8, 'C', 'osaka', 1000),
    (9, 'D', 'tokyo', 1000),
    (10, 'E', 'nagoya', 1000),
    (11, 'A', 'tokyo', 500);

--- 縦持ち → 横持ちへの変換
SELECT
    USER_ID,
    SUM(CASE AREA WHEN 'tokyo' THEN SALE ELSE 0 END) AS TOKYO,
    SUM(CASE AREA WHEN 'osaka' THEN SALE ELSE 0 END) AS OSAKA,
    SUM(CASE AREA WHEN 'nagoya' THEN SALE ELSE 0 END) AS NAGOYA,
    SUM(SALE) AS SALE_TOTAL
FROM
    SHOP
GROUP BY
    USER_ID
ORDER BY
    USER_ID
    
--- Viewの作成(横持ちテーブル作成の省略)
CREATE VIEW V_SHOP AS
SELECT
    USER_ID,
    SUM(CASE AREA WHEN 'tokyo' THEN SALE ELSE 0 END) AS TOKYO,
    SUM(CASE AREA WHEN 'osaka' THEN SALE ELSE 0 END) AS OSAKA,
    SUM(CASE AREA WHEN 'nagoya' THEN SALE ELSE 0 END) AS NAGOYA,
    SUM(SALE) AS SALE_TOTAL
FROM
    SHOP
GROUP BY
    USER_ID
ORDER BY
    USER_ID

--- View作成の確認
select * from V_SHOP

--- 横持ち → 縦持ちへの変換
select USER_ID, 'tokyo' as AREA, TOKYO as SALE from V_SHOP
union all
select USER_ID, 'osaka' as AREA, OSAKA as SALE from V_SHOP
union all
select USER_ID, 'nagoya' as AREA, NAGOYA as SALE from V_SHOP
order by USER_ID