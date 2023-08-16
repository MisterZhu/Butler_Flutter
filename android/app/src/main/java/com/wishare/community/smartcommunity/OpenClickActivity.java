package com.wishare.community.smartcommunity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.WindowManager;
import com.wishare.community.smartcommunity.OpenClickActivity;

/**
 * Created by jiguang on 17/7/5.
 */

public class OpenClickActivity extends Activity {
    private static final String TAG = "notifiClick-OpenClick";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.v(TAG, "onCreate-handleOpenClick-----");
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
        Intent intent = new Intent(this, MainActivity.class);
        intent.setData(getIntent().getData());
        if (getIntent().getExtras() != null) {
            intent.putExtras(getIntent().getExtras());
        }
        startActivity(intent);
        finish();
    }

}
