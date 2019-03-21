	# exit when any command fails
set -e

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT

	
	export JAVA_HOME='/Library/Java/JavaVirtualMachines/labsjdk1.8.0_192-jvmci-0.53-forJFXBuild/Contents/Home'
    export JDK_HOME='/Library/Java/JavaVirtualMachines/labsjdk1.8.0_192-jvmci-0.53-forJFXBuild/Contents/Home'
    export JRE_HOME='/Library/Java/JavaVirtualMachines/labsjdk1.8.0_192-jvmci-0.53-forJFXBuild/Contents/Home'



#export JAVA_HOME='/Library/Java/JavaVirtualMachines/labsjdk1.8.0_192-jvmci-0.53/Contents/Home'
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/labsjdk1.8.0_202-jvmci-0.56-fastdebug/Contents/Home


#JFX_LIB=/Users/brunoposthuma/GRAAL_TESTS/8u-dev-rt/build/sdk/rt/lib
#JFX_LIB=/Users/brunoposthuma/GRAAL_TESTS/openjavafx-macos-sdk/sdk/lib
JFX_LIB=$JAVA_HOME/jre/lib

#WAS SVMBUILD=/Library/Java/JavaVirtualMachines/graalvm-ce-1.0.0-rc14/Contents/Home/jre
SVMBUILD=/Library/Java/JavaVirtualMachines/graalvm-ce-1.0.0-rc14/Contents/Home
SVMLIB=$SVMBUILD/lib

echo "Using defines:\n============"
echo "JAVA_HOME="$JAVA_HOME
echo "SVMBUILD="$SVMBUILD
echo "SVMLIB="$SVMLIB
echo "JFX_LIB="$JFX_LIB



PWD=`pwd`



echo "Compiling java src\n============"
javac -cp $JFX_LIB/ext/jfxrt.jar -d classes src/java/HelloJFX.java
echo "done\n============"

echo "Compiling to native\n============"

classes/build-native-image.sh $JAVA_HOME $JFX_LIB $SVMBUILD

echo "done\n============"

echo "Compiling C++ and linking to native\n============"
SVMBUILD=/Library/Java/JavaVirtualMachines/graalvm-ce-1.0.0-rc14/Contents/Home/jre
SDK=/Applications/Xcode9.4.1.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk
PWD=`pwd`


mkdir -p $PWD/build/mac
echo "compiling\n=========\n"
gcc -c -o $PWD/build/mac/launcher.o $PWD/src/native/mac/launcher.c
gcc -c -o $PWD/build/mac/AppDelegate.o $PWD/src/native/mac/AppDelegate.m
echo "linking\n=======\n"
gcc -v -isysroot $SDK -fobjc-arc -o build/mac/hellojfx  build/mac/AppDelegate.o build/mac/launcher.o classes/hellojfx.dylib -L$SVMBUILD/lib/svm/clibraries/darwin-amd64 -lffi -Wl,-framework,CoreFoundation -Wl,-framework,Appkit -lpthread -lz -ldl -lstrictmath -llibchelper
echo "running\n=======\n"
export PATH=$JAVA_HOME/bin:$JDK_HOME/bin:$JFX_LIB:$PATH
./build/mac/hellojfx
echo "done\n============"