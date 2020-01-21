export condaname="agiletools"
export CFITSIO=$PREFIX
export ROOTSYS=$PREFIX
export AGILE=$PREFIX/agiletools
export C_INCLUDE_PATH=$PREFIX/include
export CPP_INCLUDE_PATH=$PREFIX/include
export ZLIBPATH=$PREFIX/lib

export PFILES=$PFILES:$AGILE/share
export LD_LIBRARY_PATH=$PREFIX/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=$PREFIX/lib:$LIBRARY_PATH
export PATH=$AGILE/bin:$AGILE/scripts:$PATH



echo "LD_LIBRARY_PATH= $LD_LIBRARY_PATH"
echo "LIBRARY_PATH= $LIBRARY_PATH"
mkdir $PREFIX/agiletools
git clone https://github.com/AGILESCIENCE/AGILE-GRID-ScienceTools-Setup.git
cd AGILE-GRID-ScienceTools-Setup
git checkout master
./downloadScienceTools_notag.sh
./installScienceTools.sh
./downloadIRFConda.sh
./installIRFConda.sh

cd $PREFIX/../work
$PYTHON setup.py install

cp $RECIPE_DIR/activate.sh $PREFIX/etc/conda/activate.d/activate_${condaname}.sh
cp $RECIPE_DIR/deactivate.sh $PREFIX/etc/conda/deactivate.d/deactivate_${condaname}.sh
cp $SRC_DIR/agilepy/testing/unittesting/start_agilepy_tests.sh $AGILE/scripts
