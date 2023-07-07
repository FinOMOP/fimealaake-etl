#!/bin/bash

# make sure to check the files are available for download at
# https://www.fimea.fi/laakehaut_ja_luettelot/perusrekisteri

# make sure to edit config.sh with the relevant details


source ./config.sh


mkdir -p $INPUTDIR

curl https://www.fimea.fi/documents/160140/1128399/atc.txt/ -o $INPUTDIR/atc.txt
curl https://www.fimea.fi/documents/160140/1128399/laakeaine.txt/ -o $INPUTDIR/laakeaine.txt
curl https://www.fimea.fi/documents/160140/1128399/laakemuoto.txt/ -o $INPUTDIR/laakemuoto.txt
curl https://www.fimea.fi/documents/160140/1128399/maaraamisehto.txt/ -o $INPUTDIR/maaraamisehto.txt
curl https://www.fimea.fi/documents/160140/1128399/maaraaikaisetmaaraamisehto.txt/ -o $INPUTDIR/maaraamisehto_m.txt  # renamed
curl https://www.fimea.fi/documents/160140/1128399/pakkaus1.txt/ -o $INPUTDIR/pakkaus1.txt
curl https://www.fimea.fi/documents/160140/1128399/pakkaus_nolla.txt/ -o $INPUTDIR/pakkaus.txt              # renamed
curl https://www.fimea.fi/documents/160140/1128399/pakkaus-m.txt/ -o $INPUTDIR/pakkaus_m.txt                # renamed
curl https://www.fimea.fi/documents/160140/1128399/saate.txt/ -o $INPUTDIR/saate.txt
curl https://www.fimea.fi/documents/160140/1128399/sailytysastia.txt/ -o $INPUTDIR/sailytysastia.txt

