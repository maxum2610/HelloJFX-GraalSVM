import javafx.application.Application;
import javafx.stage.Stage;
import java.util.Enumeration;
import java.util.Properties;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.Button;
import javafx.scene.layout.VBox;

public class HelloJFX extends Application {

    public HelloJFX() {
    }

    @Override
    public void start(Stage primaryStage) {
    
        System.out.println("HelloJFX start");
        
        VBox root = new VBox();
        
        Button button = new Button();
        button.setText("I'm a button...click me");
        button.setOnAction(event -> System.out.println("Hello World! you clicked me"));
        root.getChildren().add(button);
        
        Label label = new Label ("Hello, JavaFX 8, running on " + System.getProperty("java.version"));
        root.getChildren().add(label);
        
        Scene scene = new Scene(root, 400, 480);

		primaryStage.setScene(scene);
		primaryStage.setTitle("HelloJFX");
        primaryStage.show();
    }

    public static void main(String[] args) {
    	
    	System.err.println("HelloJFX start");
    
    //String java_home = "/Library/Java/JavaVirtualMachines/labsjdk1.8.0_202-jvmci-0.56-fastdebug/Contents/Home"; no JFX in jdk
    	String java_home = "/Library/Java/JavaVirtualMachines/labsjdk1.8.0_192-jvmci-0.53-forJFXBuild/Contents/Home";
    	String java_library_path = java_home + "/jre/lib";
    	//String java_library_path = "/Users/brunoposthuma/GRAAL_TESTS/8u-dev-rt/build/sdk/rt/lib";
    	
    	String java_class_path=java_library_path + "/rt.jar:" + java_library_path + "/ext/jfxrt.jar";
        
        System.setProperty("os.target", "mac");
        System.setProperty("javafx.verbose", "true");
        System.setProperty("prism.verbose", "true");
        System.setProperty("java.library.path", java_library_path);
        System.setProperty("java.home", java_home);
        System.setProperty("java.class.path", java_class_path);
        
        
        System.err.println("HelloFX printing System.properties:");
    	Properties p = System.getProperties();
		Enumeration keys = p.keys();
		while (keys.hasMoreElements()) {
    		String key = (String)keys.nextElement();
    		String value = (String)p.get(key);
    		System.out.println(key + ": " + value);
		}
        
        
        System.err.println("HelloFX launching!!!");
        launch();
    }

}
