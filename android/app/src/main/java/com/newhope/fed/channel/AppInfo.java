package com.newhope.fed.channel;

import android.content.Context;

import org.json.JSONException;
import org.json.JSONObject;

import io.flutter.plugin.common.MethodChannel;

public class AppInfo {

    private Context mContext;
    private MethodChannel.Result mResult;

    public AppInfo(Context context, MethodChannel.Result result) {
        this.mContext = context;
        this.mResult = result;
    }


    //todo 待确定数据
    public void appBaseInfo() {
        JSONObject object = new JSONObject();
        try {
            object.putOpt("packageName", mContext.getApplicationInfo().packageName);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        mResult.success(object.toString());
    }
}
