package com.star.startasker;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.ClipData;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.FileProvider;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.material.bottomsheet.BottomSheetDialog;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.security.AccessController;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.zip.Inflater;

import static java.security.AccessController.*;

public class PostTaskBudget extends AppCompatActivity {

    Button getQuotes;
    ImageView galleryPics;
    TextView estimatedValue;
    EditText amount;
    LinearLayout picsLay,taskBudBack;
    int CAMERA_REQUEST=1888;
    RecyclerView picRecycler;
    List<Uri> uriList=new ArrayList<>();
    Uri file;
    File f;
    ArrayList<File> files=new ArrayList<>();
    String  mCurrentPhotoPath;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_post_task_budget);
        getQuotes=findViewById(R.id.getQuotes);
        galleryPics=findViewById(R.id.galleryPics);
        amount=findViewById(R.id.amount);
        picsLay=findViewById(R.id.picsLayout);
        estimatedValue=findViewById(R.id.estimatedValue);
        taskBudBack=findViewById(R.id.taskBudBack);
        picRecycler=findViewById(R.id.picRecycler);

        picRecycler.setLayoutManager(new LinearLayoutManager(PostTaskBudget.this,RecyclerView.HORIZONTAL,false));

       amount.addTextChangedListener(new TextWatcher() {
           @Override
           public void beforeTextChanged(CharSequence s, int start, int count, int after) {

           }

           @Override
           public void onTextChanged(CharSequence s, int start, int before, int count) {

           }

           @Override
           public void afterTextChanged(Editable s) {
               String value=amount.getText().toString();
               estimatedValue.setText("$ "+value);

           }
       });

        galleryPics.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {


                if (uriList.size()<=3){
                View dialogView = getLayoutInflater().inflate(R.layout.logout_box, null);
                BottomSheetDialog dialog = new BottomSheetDialog(Objects.requireNonNull(PostTaskBudget.this),R.style.BottomSheetDialogTheme);
                dialog.setContentView(dialogView);
                dialog.setCanceledOnTouchOutside(true);
                dialog.setCancelable(true);
                dialog.show();

                TextView cam,gallery;
                cam=dialog.findViewById(R.id.yesOut);
                cam.setText("Take a photo");

                gallery=dialog.findViewById(R.id.noOut);
                gallery.setText("Gallery");

                cam.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {


                        Intent cameraIntent = new Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
                        startActivityForResult(cameraIntent, CAMERA_REQUEST);
                        dialog.dismiss();

                    }
                });
                gallery.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {

                        dialog.dismiss();

                        Intent intent1=new Intent();
                        intent1.setType("image/*");
                        intent1.setAction(Intent.ACTION_GET_CONTENT);
                startActivityForResult(Intent.createChooser(intent1, "Select Picture"), 1);

                    }
                });

            }
                else{
                    Toast.makeText(getApplicationContext(),"You can add only 3 images",Toast.LENGTH_SHORT).show();
                }
            }
        });

