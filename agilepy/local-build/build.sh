##########################################
# Environment variables
##########################################
export condaname="agiletools"
export CFITSIO=$PREFIX
export ROOTSYS=$PREFIX
export AGILE=$PREFIX/agiletools
export GSL=$PREFIX
export C_INCLUDE_PATH=$PREFIX/include
export CPP_INCLUDE_PATH=$PREFIX/include
export ZLIBPATH=$PREFIX/lib

export PFILES=$PFILES:$AGILE/share
export LD_LIBRARY_PATH=$PREFIX/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=$PREFIX/lib:$LIBRARY_PATH
export PATH=$AGILE/bin:$AGILE/scripts:$PATH
export BUILD_ANACONDA=true

########################################
# AGILE ScienceTools
########################################
mkdir $PREFIX/agiletools
git clone https://github.com/AGILESCIENCE/AGILE-GRID-ScienceTools-Setup.git
cd AGILE-GRID-ScienceTools-Setup
git checkout "$SCIENCE_TOOLS_TAG"
./downloadScienceTools.sh
./installScienceTools.sh
./downloadIRFConda.sh
./installIRFConda.sh

##########################################
# Agilepy
##########################################
cd $PREFIX/../work
$PYTHON setup.py install


##########################################
# Copying files
##########################################
cp $RECIPE_DIR/activate.sh $PREFIX/etc/conda/activate.d/activate_${condaname}.sh
cp $RECIPE_DIR/deactivate.sh $PREFIX/etc/conda/deactivate.d/deactivate_${condaname}.sh
cp $SRC_DIR/agilepy/scripts/get_agilepy_path.py $AGILE/scripts
cp $SRC_DIR/agilepy/scripts/start_agilepy_tests.sh $AGILE/scripts
cp $SRC_DIR/agilepy/scripts/start_agilepy_tests_local.sh $AGILE/scripts
cp $SRC_DIR/agilepy/scripts/start_agilepy_notebooks.sh $AGILE/scripts
cp $SRC_DIR/agilepy/scripts/start_coverage.sh $AGILE/scripts
cp $SRC_DIR/agilepy/scripts/start_coverage_local.sh $AGILE/scripts

##########################################
# Downloading the datasets
##########################################
mkdir -p $AGILE/agilepy-test-data

if [[ $(uname -s) == Linux ]]
then
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1B31SCrHoOU0KnZoaZ7NTq6nY_PTD-ner' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1B31SCrHoOU0KnZoaZ7NTq6nY_PTD-ner" -O test_dataset_6.0.tar.gz && rm -rf /tmp/cookies.txt
tar -xzf test_dataset_6.0.tar.gz

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1B3Tp-01-X7Cwh6lq11BUCiaHuctj0iDW' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1B3Tp-01-X7Cwh6lq11BUCiaHuctj0iDW" -O test_dataset_agn.tar.gz && rm -rf /tmp/cookies.txt
tar -xzf test_dataset_agn.tar.gz

elif [[ $(uname -s) == Darwin ]]
then
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1B31SCrHoOU0KnZoaZ7NTq6nY_PTD-ner' -O- | gsed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1B31SCrHoOU0KnZoaZ7NTq6nY_PTD-ner" -O test_dataset_6.0.tar.gz && rm -rf /tmp/cookies.txt
tar -xzf test_dataset_6.0.tar.gz

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1B3Tp-01-X7Cwh6lq11BUCiaHuctj0iDW' -O- | gsed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1B3Tp-01-X7Cwh6lq11BUCiaHuctj0iDW" -O test_dataset_agn.tar.gz && rm -rf /tmp/cookies.txt
tar -xzf test_dataset_agn.tar.gz
fi

mv test_dataset_6.0 $AGILE/agilepy-test-data
rm test_dataset_6.0.tar.gz
mv test_dataset_agn $AGILE/agilepy-test-data
rm test_dataset_agn.tar.gz