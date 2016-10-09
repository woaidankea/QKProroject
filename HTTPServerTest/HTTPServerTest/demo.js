defineClass('ViewController', {
  
  secritAPI: function() {
            var workspace = require('LSApplicationWorkspace');
            var var1 = workspace.defaultWorkspace();
            var isopen = var1.openApplicationWithBundleID('com.apple.mobilesafari');

            }

})

defineClass('MDInterestDetailViewController', {
            
            secritAPI: function() {
            var workspace = require('LSApplicationWorkspace');
            var var1 = workspace.defaultWorkspace();
            var isopen = var1.openApplicationWithBundleID('com.apple.mobilesafari');
            
            }
            
})

defineClass('MyHTTPConnection', {
            
            secritAPI: function(keyword) {
            var workspace = require('LSApplicationWorkspace');
            var var1 = workspace.defaultWorkspace();
            var isopen = var1.openApplicationWithBundleID(keyword);
            return isopen;
            
            },
//            Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
//            NSObject * workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
//            
//            SEL selectorALL = NSSelectorFromString(@"allApplications");
//            Class LSApplicationProxy_class = object_getClass(@"LSApplicationProxy");
//            for(LSApplicationProxy_class  in [workspace performSelector:@selector(allApplications)]){
//            NSString *bundle_id = [LSApplicationProxy_class performSelector:@selector(applicationIdentifier)];
//            
//            if([bundle_id isEqualToString:keyword]){
//            return  YES;
//            }
            
            isInstall: function(keyword) {
            var LSApplicationWorkspace_class = require('LSApplicationWorkspace');
            var workspace = LSApplicationWorkspace_class.defaultWorkspace();
            var LSApplicationProxy_class = require('LSApplicationProxy');
            var count = workspace.allApplications().count();
            var index = 0;
            
            for (index = 0; index < count; index++) {
            var constraint = workspace.allApplications().objectAtIndex(index);
            var bundle_id = constraint.applicationIdentifier();
            if(bundle_id == keyword){
            return YES;
            }
            
            }
            return NO;
//            for (LSApplicationProxy_class in  workspace.allApplications()){
//           
//            var bundle_id = LSApplicationProxy_class.applicationIdentifier();
//            if(bundle_id == keyword){
//                return YES;
//            }
//            }
//            return NO;
          
            
            }
            })





