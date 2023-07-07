# fimealaake

- Loading fimea drug database to postgres.

- Convert and export the input files required for OHDSI BuildRxE.


## Fimea drug database download and documentation

https://www.fimea.fi/laakehaut_ja_luettelot/perusrekisteri

https://www.fimea.fi/web/en/databases_and_registers/basic-register

The source files need to be manually downloaded and 


## File naming conventions

SQL-files are named using flyway conventions, typically

- **Vx__filename.sql** for creating and altering tables

- **R__filename.sql** for defining views and functions

If run manually, the order is V1__*, V2__*, .... R__a***, R__b***, ...


Additionally, flyway hook beforeEachMigrate is used to reset the role to
the desired object owner. This is not necessary if the role is set manually.


## ETL

etl/ dir contains etl scripts


1. Copy config-template.sh -> config.sh and edit (do not edit placeholders in copy-files-template.sh, these are replaced automatically in the scripts).

2. Run numbered shell-scripts



## Some noted problems (and fixes) with datamodel and source data


### datamodel modifications

The documentation from fimea implies an underlying data model (quasi ER-diagram and list of tables and fields).
The following changes have to be made to the data model for the data to fit.


#### laakeaine foreign key problem

Laakeaine references both pakkaus_nolla and pakkaus_m (määräaikaiset) from the same id column (pakkausnro).
This is not possible to implement as a foreign key.

Solution:

pakkaus_m is inserted into pakkaus, with an additional boolean field maaraaikainen in the pakkaus table (maaraaikainen BOOLEAN DEFAULT FALSE).

maaraamisehto table is used for both maaraamisehto and maaraamisehto_m


#### data not matching constraints as given in the documentation

- pakkaus, pakkaus_m:

    - Remove null constraint: kerroin, koko, vahvuus, yksikkö, pakkauskoko, atckoodi, atc

    - varchar(19) --> varchar(100): eumyyntilupanro (eg, "EU/1/96/007/002,020-021", "EU/1/96/022/002,019,023,029,035")

- laakeaine

    - Remove null constraint: ainenimi

#### fix data (broken csv)

- there are some empty lines in laakeaine.txt (66648, 67281) These are removed in etl script.


