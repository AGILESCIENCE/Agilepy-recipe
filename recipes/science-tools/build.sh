##########################################
# Environment variables
##########################################
export condaname="agiletools-environment"
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

git clone --branch v6-18-04 https://github.com/root-project/root.git root_src
mkdir root_build && cd root_build
cmake -DCMAKE_INSTALL_PREFIX=$ROOTSYS ../root_src
cmake --build . -- install -j20
source $ROOTSYS/bin/thisroot.sh
cd ..



########################################
# AGILE ScienceTools
########################################
mkdir $PREFIX/agiletools
git checkout "$SCIENCE_TOOLS_TAG"
./downloadScienceTools.sh
./installScienceTools.sh
./downloadIRFConda.sh
./installIRFConda.sh

##########################################
# Copying files
##########################################
cp $RECIPE_DIR/activate.sh $PREFIX/etc/conda/activate.d/activate_${condaname}.sh
cp $RECIPE_DIR/deactivate.sh $PREFIX/etc/conda/deactivate.d/deactivate_${condaname}.sh
