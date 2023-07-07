CREATE OR REPLACE VIEW laakeaine_list
AS
  SELECT ainetun, ainenimi, count(*) AS pakkaus_lkm
  FROM stg_fimealaake.laakeaine
  GROUP BY ainetun, ainenimi;

