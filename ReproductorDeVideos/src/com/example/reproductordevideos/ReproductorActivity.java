package com.example.reproductordevideos;

import java.io.File;

import android.app.Activity;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.MediaController;
import android.widget.VideoView;

public class ReproductorActivity extends Activity implements OnClickListener{

	private MediaController mediaController;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_reproductor);
		
		VideoView reproductor = (VideoView) findViewById(R.id.reproductor);
		File downloadsDirectory = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
		reproductor.setVideoURI(Uri.parse(downloadsDirectory.getAbsolutePath() + "/Relaxatron.mp4"));
		
		findViewById(R.id.play).setOnClickListener(this);
		findViewById(R.id.pause).setOnClickListener(this);
		findViewById(R.id.stop).setOnClickListener(this);
		
		mediaController = new MediaController(this);
		reproductor.setMediaController(mediaController);
		
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.reproductor, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// Handle action bar item clicks here. The action bar will
		// automatically handle clicks on the Home/Up button, so long
		// as you specify a parent activity in AndroidManifest.xml.
		int id = item.getItemId();
		if (id == R.id.action_settings) {
			return true;
		}
		return super.onOptionsItemSelected(item);
	}

	@Override
	public void onClick(View v) {
		VideoView reproductor = (VideoView) findViewById(R.id.reproductor);
	
		switch (v.getId()){
			case R.id.play: reproductor.start(); break;
			case R.id.pause: reproductor.pause(); break;
			case R.id.stop: reproductor.stopPlayback(); break;
		}
	
		
	}
}
