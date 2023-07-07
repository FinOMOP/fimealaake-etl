-- drug_concept_stage
------------------------
-- this is a union of all the attributes, selected separately:
-- Drug product, Brand name, Ingredient, Unit, Dose Form

CREATE OR REPLACE VIEW stg_fimealaake.export_ohdsi_drug_concept_stage AS


-- Drug product

  SELECT 
      concat(array_to_string(array_agg(la.ainenimi), ' / '),' ', p.vahvuus, ', ', lm.laakemuotonimie, ' [',p.laakenimi,'] by ', p.haltija) AS concept_name,
      'Drug Product' AS concept_class_id,
      concat('fimea-product-',p.pakkausnro) AS concept_code,
      p.vnrnro AS vnr_code,
      NULL AS previous_concept_name,
      NULL AS concept_name_fi,
      NULL AS concept_name_sv,
      1 AS product_count 
  FROM stg_fimealaake.pakkaus p
  INNER JOIN stg_fimealaake.laakeaine la ON p.pakkausnro = la.pakkausnro
  INNER JOIN stg_fimealaake.laakemuoto lm ON p.laakemuototun = lm.laakemuototun
  GROUP BY p.vahvuus, p.laakenimi, p.haltija, p.pakkausnro, lm.laakemuotonimie  
  --ORDER BY p.laakenimi ASC


-- Brand name
UNION

  SELECT
      laakenimi AS concept_name,
      'Brand Name' AS concept_class_id,
      laakenimi AS concept_code,
      NULL AS vnr_code,
      laakenimi_edellinen AS previous_concept_name,
      NULL AS concept_name_fi,
      NULL AS concept_name_sv,
      count(*) AS product_count
  FROM stg_fimealaake.pakkaus
  GROUP BY laakenimi, laakenimi_edellinen
  --ORDER BY laakenimi

-- Ingredient
UNION


  SELECT
      ainenimi  AS concept_name,
      'Ingredient' AS concept_class_id,
      concat('fimea-ingredient-',ainetun) AS concept_code,
      NULL AS vnr_code,
      NULL AS previous_concept_name,
      NULL AS concept_name_fi,
      NULL AS concept_name_sv,
      pakkaus_lkm AS product_count
  FROM stg_fimealaake.laakeaine_list
  --ORDER BY ainenimi


-- Dose form
UNION

  SELECT DISTINCT
      laakemuotonimie AS concept_name,
      'Dose Form' AS concept_class_id,
      concat('fimea-dose-form-',laakemuototun) AS concept_code,
      NULL AS vnr_code,
      NULL AS previous_concept_name,
      laakemuotonimi AS concept_name_fi,
      laakemuotonimir AS concept_name_sv,
      (SELECT count(*) FROM stg_fimealaake.pakkaus WHERE pakkaus.laakemuototun = laakemuoto.laakemuototun) AS product_count 
  FROM stg_fimealaake.laakemuoto
  --ORDER BY laakemuotonimie


-- Dose


UNION

  SELECT
      yksikko AS concept_name,
      'Unit' AS concept_class_id,
      yksikko AS concept_code,
      NULL AS vnr_code,
      NULL AS previous_concept_name,
      yksikko AS concept_name_fi,
      NULL AS concept_name_sv,
      count(*) AS product_count
  FROM stg_fimealaake.pakkaus
  GROUP BY yksikko;
