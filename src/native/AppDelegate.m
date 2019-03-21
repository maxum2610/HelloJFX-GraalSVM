#import "AppDelegate.h"
#include <pthread.h>
#include <dlfcn.h>

extern void *JavaMainWrapper__run__5087f5482cc9a6abc971913ece43acb471d2631b();
@interface AppDelegate ()
@end

@implementation AppDelegate

-(void)startVM:(id)selector {
    NSLog(@"Starting Gluon VM...");
    pthread_t me = pthread_self();
    fprintf(stderr, "========================> Starting on thread: %p\n",me);
    
  //NSLog(@"Loading libhellofxsvm.dylib");  
    //void *libJLI = dlopen("libhellofxsvm.dylib", RTLD_NOW);        
         //   if (libJLI != NULL) {
         //   fprintf(stderr, "libhellofxsvm.dylib NOT LOADED\n");
         //   }
    
    
    
    (*JavaMainWrapper__run__5087f5482cc9a6abc971913ece43acb471d2631b)(1);
    NSLog(@"Started Gluon VM...");
    
}

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification  {
    pthread_t me = pthread_self();
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification  {
    pthread_t me = pthread_self();
    fprintf(stderr, "AppDelegate:ApplicationDidFinishLaunching called, me = %p\n", me);
    [self performSelectorInBackground:@selector(startVM:) withObject:nil];
}

- (void)applicationDidFinishLaunchingWithOptions:(NSNotification *)aNotification  {
fprintf(stderr, "AppDelegate:DIDFINISHLAUNCHING with options\n");
     [self performSelectorInBackground:@selector(startVM:) withObject:nil];
}


@end

void outBox(int argc, char** argv) {
    pthread_t me = pthread_self();
    fprintf(stderr, "======>>>>>>>> AppDelegate:outbox, on thread %p, argc = %d and argv = %p\n", me,argc, argv);

    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    AppDelegate* appDelegate = [[AppDelegate alloc] init];
    NSApplication.sharedApplication.delegate = appDelegate;
    fprintf(stderr, "in outbox2, on thread %p\n", me);
    [NSApplication sharedApplication];
    fprintf(stderr, "sharedall called\n");
    [NSApp run];
    fprintf(stderr, "in outbox3, on thread %p\n", me);

    [pool release];

    fprintf(stderr, "Outbox exit now\n");
}

