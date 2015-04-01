window.echo = function(str, callback) {
    cordova.exec(callback, function(err) {
                 callback('Nothing to echo.');
                 }, "MyPlugin", "echo", [str]);
};

function doEcho () {
    window.echo("echome", function(echoValue) {
                alert(echoValue == "echome"); // should alert true.
                });
}

function onSuccess(contacts) {
    alert('Found ' + contacts.length + ' contacts.');
};

function onError(contactError) {
    alert('onError!');
};

function getContacts() {
    // find all contacts with 'Bob' in any name field
    var options      = new ContactFindOptions();
    options.filter   = "";
    options.multiple = true;
    var fields       = ["displayName", "name"];
    navigator.contacts.find(fields, onSuccess, onError, options);
}


var HelloPlugin = {
callNativeFunction: function (success, fail, resultType) {
    //    console.log ("Welcome");
    return cordova.exec( success, fail, "MyPlugin", "nativeFunction", [resultType]);
},
callNativeFunction2: function (success, fail, resultType) {
    //    console.log ("Welcome");
    return cordova.exec( success, fail, "MyPlugin", "nativeFunction2", [resultType]);
},
callNativeFunctionP2PSettingPage: function (success, fail, resultType) {
    //    console.log ("Welcome");
    return cordova.exec( success, fail, "MyPlugin", "showP2PSettingPage", [resultType]);
},
callNativeFunctionP2PAlertView: function (success, fail, resultType) {
    //    console.log ("Welcome");
    return cordova.exec( success, fail, "MyPlugin", "showP2PAlertView", [resultType]);
},
callNativeFunctionToBrowser: function (success, fail, resultType) {
    //    console.log ("Welcome");
    return cordova.exec( success, fail, "MyPlugin", "toBrowser", [resultType]);
},
callNativeFunctionToGetUDID: function (success, fail, resultType) {
    //    console.log ("Welcome");
    return cordova.exec( success, fail, "MyPlugin", "getUDID", [resultType]);
}
};
function nativePluginResultHandler (result)
{
    alert("SUCCESS nativePlugin: \r\n"+result );
}

function nativePluginErrorHandler (error)
{
    alert("ERROR nativePlugin: \r\n"+error );
}

function callNativePlugin( returnSuccess )
{
    alert("Invoking..");
    HelloPlugin.callNativeFunction( nativePluginResultHandler, nativePluginErrorHandler, returnSuccess );
}



function getContactsJS( returnSuccess ) {
    alert("Invoking..getContacts");
    HelloPlugin.callNativeFunction( getContactsSUCCESS, getContactsERROR, returnSuccess );
}
function getContactsSUCCESS (result)
{
    alert("SUCCESS getPhoneNum: \r\n"+result );
}
function getContactsERROR (error)
{
    alert("ERROR getPhoneNum: \r\n"+error );
}

function showSettingView( returnSuccess )
{
//    alert("Invoking..showSettingView");
    HelloPlugin.callNativeFunctionP2PSettingPage( nativePluginResultHandler, nativePluginErrorHandler, returnSuccess);
}
function showMessage( returnSuccess)
{
//    alert("Invoking..showMessage");
    HelloPlugin.callNativeFunctionP2PAlertView( nativePluginResultHandler, nativePluginErrorHandler, returnSuccess);
}
function ToBrowser( returnSuccess){
    HelloPlugin.callNativeFunctionToBrowser( nativePluginResultHandler, nativePluginErrorHandler, returnSuccess);
}

function getUDID( returnSuccess ) {
    HelloPlugin.callNativeFunctionToGetUDID( getUDIDSUCCESS, getUDIDERROR, returnSuccess );
}
function getUDIDSUCCESS (result)
{
    alert("SUCCESS getUDID: \r\n"+result );
}
function getUDIDERROR (error)
{
    alert("ERROR getUDID: \r\n"+error );
}
