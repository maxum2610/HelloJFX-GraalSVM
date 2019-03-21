# HelloJFX-GraalSVM
Simple Java JFX app compiled using native-image using SubstrateVM (Graal) running on MAc OSX.

Small test based on this issue:

https://github.com/oracle/graal/issues/994


and based on:

https://github.com/cubuspl42/JavaFX-Graal-HelloWorld
https://github.com/johanvos/simplesvm

How to:

Download and install labsjdk1.8.0_192-jvmci-0.53 (a more recent version should also work)

Download and build https://bitbucket.org/javafxports/8u-dev-rt (so you can add debug info if you want)
Note: before building 8u-dev-rt, point JAVA_HOME, JDK_HOME, and JRE_HOME to labsjdk1.8.0_192-jvmci-0.53

Copy ext/jfxrt.jar and all .dylibs from 8u-dev-rt build into labsjdk1.8.0_192-jvmci-0.53/jre/lib or point JFX_LIB to your 8u-dev-rt build directory.

Set the appropriate paths in build.sh.

Run build.sh




