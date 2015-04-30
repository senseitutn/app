package com.example.reproductormp4;



import java.io.File;

import org.bytedeco.javacv.Frame;
import org.bytedeco.javacv.FrameGrabber;
import org.bytedeco.javacv.FrameGrabber.Exception;
import org.bytedeco.javacv.OpenCVFrameGrabber;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.media.MediaMetadataRetriever;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.os.SystemClock;
import android.view.Menu;
import android.view.MenuItem;
import android.view.SurfaceView;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.LinearLayout;



public class PlayerActivity extends Activity implements OnClickListener{
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_player);
		
		LinearLayout reproductorLayout = (LinearLayout) findViewById(R.id.reproductor_layout);

		SurfaceView reproductorSurfaceView = new SurfaceView(this);
		reproductorSurfaceView.setLayoutParams(new LinearLayout.LayoutParams(
		                                     LinearLayout.LayoutParams.MATCH_PARENT,
		                                     LinearLayout.LayoutParams.MATCH_PARENT));

		reproductorLayout.addView(reproductorSurfaceView);
				
		reproductorSurfaceView.setOnClickListener(this); 
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.player, menu);
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
	public void onClick(View surfaceView) {
		SurfaceView reproductorSurfaceView = (SurfaceView) surfaceView;
		
		MediaMetadataRetriever mediaMetadataRetriever = new MediaMetadataRetriever();	
		File downloadsDirectory = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
		mediaMetadataRetriever.setDataSource(downloadsDirectory.getAbsolutePath() + "/Relaxatron.mp4");
	    Uri videoFileUri=Uri.parse(downloadsDirectory.getAbsolutePath() + "/Relaxatron.mp4");
	    MediaPlayer mp = MediaPlayer.create(getBaseContext(), videoFileUri);
		
//        int millis = mp.getDuration();
        
	    long deltaTimeDiferenceAcumulator = 0;
	    long maxDeltaDiference = 0;
	    long deltaTimeDiference = SystemClock.elapsedRealtime();
	    long elapsedLastTime = SystemClock.elapsedRealtime();
	    while (true){
	    	deltaTimeDiference = SystemClock.elapsedRealtime() - elapsedLastTime;
	    	elapsedLastTime = SystemClock.elapsedRealtime();
			deltaTimeDiferenceAcumulator += deltaTimeDiference;
			if (deltaTimeDiference > maxDeltaDiference) {
				maxDeltaDiference = deltaTimeDiference;
			}
			Canvas canvas = reproductorSurfaceView.getHolder().lockCanvas();
			canvas.drawBitmap(mediaMetadataRetriever.getFrameAtTime(deltaTimeDiferenceAcumulator * 1000, MediaMetadataRetriever.OPTION_NEXT_SYNC), 0, 0, null);
			reproductorSurfaceView.getHolder().unlockCanvasAndPost(canvas);
		}
	}
}
