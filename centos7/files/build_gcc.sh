
VER=$1

if test x$1 = x4.6 ; then
    URL=https://bigsearcher.com/mirrors/gcc/releases/gcc-4.6.3/gcc-4.6.3.tar.bz2
elif test x$1 = x7 ; then
    URL=https://bigsearcher.com/mirrors/gcc/releases/gcc-7.4.0/gcc-7.4.0.tar.xz
elif test x$1 = x8 ; then
    URL=https://bigsearcher.com/mirrors/gcc/releases/gcc-8.3.0/gcc-8.3.0.tar.xz
else
    URL=https://bigsearcher.com/mirrors/gcc/releases/gcc-9.1.0/gcc-9.1.0.tar.xz
fi

set -e
if test -z $NJOB ; then
    NJOB=16
fi

PREFIX=/usr/local/gcc-9
rm -rf $PREFIX
PATH=$PREFIX/bin:$PATH
CPATH=$PREFIX/include
LIBRARY_PATH=$PREFIX/lib
export LD_LIBRARY_PATH=$PREFIX/lib
export PATH CPATH LIBRARY_PATH

wget --no-verbose $URL
tar xf gcc-*
cd gcc-*
./contrib/download_prerequisites
mkdir build
cd build
../configure --prefix=$PREFIX --program-suffix=-$VER --disable-multilib --enable-languages=c,c++,fortran --build=i686-pc-linux-gnu --host=i686-pc-linux-gnu
make -j$NJOB
make install
