


-- atc

\copy {SCHEMA}.atc from {INPUTDIR}/atc.txt delimiter ';' encoding 'ISO-8859-1' csv header

-- laakemuoto

\copy {SCHEMA}.laakemuoto from {INPUTDIR}/laakemuoto.txt delimiter ';' encoding 'ISO-8859-1' csv header

-- sailytysastia

\copy {SCHEMA}.sailytysastia from {INPUTDIR}/sailytysastia.txt delimiter ';' encoding 'ISO-8859-1' csv header

-- maaraamisehto (& maaraamisehto_m to same table)

\copy {SCHEMA}.maaraamisehto from {INPUTDIR}/maaraamisehto.txt delimiter ';' encoding 'ISO-8859-1' csv header
\copy {SCHEMA}.maaraamisehto from {INPUTDIR}/maaraamisehto_m.txt delimiter ';' encoding 'ISO-8859-1' csv header

-- pakkaus

\copy {SCHEMA}.pakkaus_pysyva from {INPUTDIR}/pakkaus.txt delimiter ';' encoding 'ISO-8859-1' csv header

\copy {SCHEMA}.pakkaus_maaraaikainen from {INPUTDIR}/pakkaus_m.txt delimiter ';' encoding 'ISO-8859-1' csv header


-- merge pakkaus_p & pakkaus_m


INSERT INTO {SCHEMA}.pakkaus SELECT pakkaus_pysyva.*, 'FALSE' FROM {SCHEMA}.pakkaus_pysyva;
INSERT INTO {SCHEMA}.pakkaus SELECT pakkaus_maaraaikainen.*, 'TRUE' FROM {SCHEMA}.pakkaus_maaraaikainen;


-- laakeaine

\copy {SCHEMA}.laakeaine from {INPUTDIR}/laakeaine.txt delimiter ';' encoding 'ISO-8859-1' csv header


