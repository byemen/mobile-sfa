function InAppUpdate() {
}

InAppUpdate.prototype.InAppProgress = null;
InAppUpdate.prototype.updatePolicy = {};
InAppUpdate.prototype.updatePolicy.refreshUpdatePolicy = null;
InAppUpdate.prototype.updatePolicy.engineUpdatePolicy = null;
InAppUpdate.prototype.updatePolicy.applicationUpdatePolicy = null;
InAppUpdate.prototype.firstLaunch = null;
InAppUpdate.prototype.engineStatus = false;
InAppUpdate.prototype.applicationStatus = false;

InAppUpdate.prototype.init = function(success, fail) {
    try {
        Cordova.exec("InAppUpdate.initialize", success, fail);
    } catch (e) {
        alert(e);
    }
};

InAppUpdate.prototype.ping = function(success, fail) {
    Cordova.exec("InAppUpdate.ping", success, fail);
};

InAppUpdate.prototype.checkUpdate = function(success, fail, options) {
    Cordova.exec("InAppUpdate.getFileList", success, fail);
};

InAppUpdate.prototype.checkRefreshUpdate = function(success, fail, options) {
    Cordova.exec("InAppUpdate.getRefreshFileList",success, fail);
};

InAppUpdate.prototype.doBackup = function(success, fail) {
    Cordova.exec("InAppUpdate.doBackup",success, fail);
};


InAppUpdate.prototype.doRestore = function(success, fail) {
    Cordova.exec("InAppUpdate.doRestore", success, fail);
};

InAppUpdate.prototype.patchGo = function(success, fail, options) {
    Cordova.exec("InAppUpdate.patchGo", success, fail);
};

InAppUpdate.prototype.restoreGo = function(success, fail, options) {
    Cordova.exec("InAppUpdate.restoreGo", success, fail);
};

InAppUpdate.prototype.getRefreshUpdate = function(success, fail, options) {
    Cordova.exec("InAppUpdate.refreshGo", success, fail);
};

InAppUpdate.prototype.getEngineUpdate = function(success, fail, options) {
    Cordova.exec("InAppUpdate.engineUpdateGo", success, fail);
};

InAppUpdate.prototype.getEngineRecovery = function(success, fail, options) {
    Cordova.exec("InAppUpdate.engineRestoreGo", success, fail);
};

InAppUpdate.prototype.getAppUpdate = function(success, fail, options) {
    Cordova.exec("InAppUpdate.applicationUpdateGo", success, fail);
};

InAppUpdate.prototype.getAppRecovery = function(success, fail, options) {
    Cordova.exec("InAppUpdate.applicationRestoreGo", success, fail);
};

InAppUpdate.prototype.copyResource = function(success, fail, options) {
    Cordova.exec("InAppUpdate.copyResource", success, fail);
};

InAppUpdate.prototype.showProgress = function(progressBox) {
    if(this.InAppProgress) {
        this.InAppProgress.spin(document.getElementById(progressBox));
    } else {
        var InAppProgressOpts = {
            lines : 10,
            length : 8,
            width : 4,
            radius : 10,
            color : '#000',
            speed : 1,
            trail : 56,
            shadow : true
        };
        var spinnerBox;
        if(!progressBox) {
            spinnerBox = "progressBox";
        } else {
            spinnerBox = progressBox;
        }
        this.InAppProgress = new Spinner(InAppProgressOpts).spin(document.getElementById(spinnerBox));
    }
};

InAppUpdate.prototype.hideProgress = function() {
    this.InAppProgress.stop();
};

InAppUpdate.prototype.launch = function() {
    Cordova.exec("InAppUpdate.launch");
};

InAppUpdate.prototype.getRefreshUpdatePolicy = function() {
    return this.updatePolicy.refreshUpdatePolicy;
};

InAppUpdate.prototype.getApplicationUpdatePolicy = function() {
    return this.updatePolicy.applicationUpdatePolicy;
};

InAppUpdate.prototype.getEngineUpdatePolicy = function() {
    return this.updatePolicy.engineUpdatePolicy;    
};

InAppUpdate.prototype.isFirstLaunch = function() {
    return this.firstLaunch;    
};

InAppUpdate.prototype.clean = function() {
    Cordova.exec("InAppUpdate.clean");  
};

InAppUpdate.prototype.setLogFunction = function(functionName) {
    Cordova.exec("InAppUpdate.setLogFunction", functionName);
};

InAppUpdate.prototype.setProgressFunction = function(functionName) {
    Cordova.exec("InAppUpdate.setProgressFunction", functionName);
};

InAppUpdate.prototype.setStatusFunction = function(functionName) {
    Cordova.exec("InAppUpdate.setStatusFunction", functionName);
};
              
Cordova.addConstructor(function() {
     if(!window.plugins) {
      window.plugins = {};
      }
      window.plugins.inappupdate = new InAppUpdate();
});                  
