package com.example.reproductormp4prima;

import java.io.File;

import org.bytedeco.javacv.FFmpegFrameGrabber;
import org.bytedeco.javacv.FrameGrabber.Exception;

import android.app.Activity;
import android.os.Bundle;
import android.os.Environment;
import android.os.SystemClock;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.TextView;

public class PlayerActivity extends Activity implements OnClickListener{

	TextView tiempoYMaximo;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_player);
		
		tiempoYMaximo = (TextView) findViewById(R.id.tiempo_y_maximo);
		
		tiempoYMaximo.setOnClickListener(this);
		tiempoYMaximo.setText("INICIAR");
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
	public void onClick(View v) {

		File downloadsDirectory = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS);
		FFmpegFrameGrabber grabber = new FFmpegFrameGrabber(downloadsDirectory.getAbsolutePath() + "/Relaxatron.mp4");
		
		
		long tiempoInicio = SystemClock.elapsedRealtime();
		long tiempoIncremental = tiempoInicio;
		long tiempoDiferencial = tiempoInicio;
		long tiempoDiferencialMaximo = 0;
		
		try {
			grabber.start();
			
			while (true) {
				tiempoDiferencial = SystemClock.elapsedRealtime() - tiempoIncremental;
				tiempoIncremental = SystemClock.elapsedRealtime();

				grabber.grab();
				
				if (tiempoDiferencial > tiempoDiferencialMaximo){
					tiempoDiferencialMaximo = tiempoDiferencial;
				}
				
			}
			
		} catch (Exception e) {
			tiempoYMaximo.setText("Periodo Maximo = " + tiempoDiferencialMaximo + 
					", Tiempo que tomo = " + (tiempoIncremental - tiempoInicio));
		}
	}
}
