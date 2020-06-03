package trilateralLimeBasic;
import lime.graphics.RenderContext;
import lime.graphics.WebGLRenderContext;
import lime.app.Application;
import trilateralLimeBasic.AppGL;
import trilateralLimeBasic.NonGL;
// your main application needs to extend this only to overriding createAppGL
// put your main code in extended AppGL.
// TODO: some more thought required in terms of structures for mousing and keys.
class MainLime extends Application {
    var ready: Bool = false;
    var runSeconds: Float = 0; // maybe delay to start.
    var other: NonGL;
    var appGL: AppGL;
    public function new() {
        super();
    }
    public override
    function onWindowCreate (): Void {
        var context = window.context;
        other = new NonGL( window.width, window.height);
        appGL = createAppGL();
        switch( context.type ){
            case OPENGL, OPENGLES, WEBGL:
                appGL.setup( context.webgl );
            default:
                other.setup( context );
        }
        ready = true;
    }
    // YOU NEED TO OVERRIDE THIS IN YOUR TRILATERAL APPLICATION
    // cast as AppGL.
    public
    function createAppGL(): AppGL {
        return new AppGL( window.width, window.height );
    }
    public override
    function update( deltaTime: Int ): Void {
        runSeconds = deltaTime /1000;   
        if( !ready ) return;
        other.update();
        appGL.update();
    }
    public override
    function render ( context: RenderContext ): Void {
        if( !ready ) return;
        switch( context.type ){
            case OPENGL, OPENGLES, WEBGL:
                appGL.render( context.webgl );
            default:
                other.render( context );
        }
    }
}