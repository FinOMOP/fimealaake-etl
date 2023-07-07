-- drug_concept_stage
------------------------
-- this is a mapping table of all the attributes concept codes to product concept code:
-- Brand name, Ingredient, Unit, Dose Form

CREATE OR REPLACE VIEW stg_fimealaake.export_ohdsi_internal_relationship_stage AS


-- Brand name

  SELECT
      'fimea-product-' || p.pakkausnro AS concept_code_1,
      laakenimi AS concept_code_2
  FROM stg_fimealaake.pakkaus p

-- Ingredient
UNION


  SELECT
      'fimea-product-' || la.pakkausnro AS concept_code_1,
      concat('fimea-ingredient-',ainetun) AS concept_code_2
  FROM stg_fimealaake.laakeaine la


-- Dose form
UNION

  SELECT
      'fimea-product-' || p.pakkausnro AS concept_code_1,
      concat('fimea-dose-form-',p.laakemuototun) AS concept_code_2 
  FROM stg_fimealaake.pakkaus p


-- Dose

UNION

  SELECT
      'fimea-product-' || p.pakkausnro AS concept_code_1,
      p.yksikko AS concept_code_2
  FROM stg_fimealaake.pakkaus p;
