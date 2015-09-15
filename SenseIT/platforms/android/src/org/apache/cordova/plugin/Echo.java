package org.apache.cordova.plugin;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.SphereEntertainment.SenseIt.UnityPlayerActivity;

import android.content.Context;
import android.content.Intent;
import android.sax.StartElementListener;

/**
 * This class echoes a string called from JavaScript.
 */
public class Echo extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("echo")) {
            String message = args.getString(0);
            Context context = this.cordova.getActivity().getApplicationContext();
            UnityPlayerActivity.sensationName = "Neimar";
    		UnityPlayerActivity.sensationFramesSize = "2394";
    		Intent lanzable =  new Intent(context, UnityPlayerActivity.class);
    		lanzable.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    		context.startActivity(lanzable);
            this.echo(message, callbackContext);
            return true;
        }
        return false;
    }

    private void echo(String message, CallbackContext callbackContext) {
        if (message != null && message.length() > 0) {
            callbackContext.success(message);
        } else {
            callbackContext.error("Expected one non-empty string argument.");
        }
    }
}
