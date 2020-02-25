package com.star.startasker;

import android.annotation.SuppressLint;
import android.content.Context;
import android.util.Log;
import android.widget.Toast;
import com.google.gson.JsonObject;
import org.greenrobot.eventbus.EventBus;
import org.jetbrains.annotations.NotNull;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;
import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;
import static com.facebook.FacebookSdk.getApplicationContext;
import static com.star.startasker.ApiCollection.BASE_URL;
import static com.star.startasker.ProgressDialog.customProgress;

public class RetrofitCallbacks {
    private Context context;
    @SuppressLint("StaticFieldLeak")
    private static RetrofitCallbacks retrofitCallbacks;
    private static Retrofit retrofit = null;

    private static Retrofit getClient() {
        if (retrofit == null) {
            retrofit = new Retrofit.Builder()
                    .baseUrl(BASE_URL)
                    .addConverterFactory(GsonConverterFactory.create())
                    .build();
        }
        return retrofit;
    }

    public static RetrofitCallbacks getInstace() {
        if (retrofitCallbacks == null) {
            retrofitCallbacks = new RetrofitCallbacks();
        }
        return retrofitCallbacks;
    }

    public void fillcontext(Context context) {
        this.context = context;
    }

    public void ApiCallbacks(Context context,String EndUrl, JsonObject jsonobj) {
        this.context = context;
        ApiCollection apiCollection = getClient().create(ApiCollection.class);
        Call<ResponseBody> call = apiCollection.PostDataFromServer(EndUrl,jsonobj);
        call.enqueue(new Callback<ResponseBody>() {
            @Override
            public void onResponse(@NotNull Call<ResponseBody> call, @NotNull Response<ResponseBody> response) {
                if (response.body() != null) {
                    String bodyString = null;
                    try {
             