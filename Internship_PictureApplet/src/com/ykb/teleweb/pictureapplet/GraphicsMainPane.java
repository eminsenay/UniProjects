/*
 * Created on 08.A�u.2005
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
package com.ykb.teleweb.pictureapplet;

import java.awt.*;
import javax.swing.*;
import java.net.*;

/**
 * Bu class, i�inde resim g�sterilen bir swing componenti olu�turur.
 * @author Emin �enay
 */
public class GraphicsMainPane extends JComponent
{
	GraphicsRotate example;  // The example to display
	Dimension size;           // How much space it requires

	// Is rotation called first
	boolean isFirstTime = false;
	
	int rotateNum; //D�n�� say�s�, rotateLeftte artar, rotateRightda azal�r, bununla resmin ekran� ortalamas�n� sa�l�yoruz.
	int rotationType; //0 -> hi� d�nm�yor 1 -> sola 2 -> sa�a 
	
	int drawingType; //0 -> yeni resim �iz 1 -> rotate 2 -> zoom 
	
	// Zoom degrees are the ratios of the zoomed picture to the main picture
	double zoomDegrees[] = {0.1,0.25,0.5,0.66,0.75,1,1.5,2,3,4,5};	
	static int zoomIndex; //resmin ka��nc� zoom derecesinde oldu�unu tutar
	
	
	/**
	 * Yeni bir GraphicsMainPane objesi olu�turur
	 * @param example Resmi d�nd�rmek ve b�y�t�p k���ltmek i�in gerekli olan GraphicsRotate objesi
	 */
	public GraphicsMainPane()
	{
		rotationType = 0;
		zoomIndex = 5;
		drawingType = 0;
		rotateNum = 0;
		example = new GraphicsRotate();
		size = new Dimension(example.getWidth(), example.getHeight());
	}

	/** Draw the component and the example it contains
	 * @param g The Graphics object
	 */
	public void paintComponent(Graphics g)
	{	
		super.paintComponent(g);
		if (drawingType == 0) // if this is the first time of the picture
		{
			// ask example to draw itself
			example.draw((Graphics2D) g, this,rotateNum,rotationType,zoomDegrees[zoomIndex]);
		}
		else if (drawingType == 1 && isFirstTime) //if this is the first rotatation
		{
			// ask example to draw itself
			example.draw((Graphics2D) g, this,rotateNum,rotationType,zoomDegrees[zoomIndex]); 
			isFirstTime = false;
		}
		else //If it is zoom or not the first rotation 
		{
			example.draw((Graphics2D)g,this,zoomDegrees[zoomIndex],rotateNum);
		}
	}
	
	/** Resmin saat y�n�n�n tersine d�nmesini sa�lar. */
	public void rotateLeft()
	{	
		rotateNum++;
		drawingType = 1;
		rotationType = 1;
		setSize(1);
		isFirstTime = true;
		repaint();
		revalidate();
	}
	
	/** Resmi saat y�n�nde d�nd�r�r. */
	public void rotateRight()
	{	
		drawingType = 1;
		rotateNum--;
		rotationType = 2;
		setSize(1);
		isFirstTime = true;
		repaint();
		revalidate();
	}
	
	
	/** Yeni bir resim g�stermek i�in kullan�l�r
	 * @param imageURL G�sterilecek resmin bulundu�u URL adresi
	 */
	public void showImage(URL imageURL)
	{
		zoomIndex = 5;
		rotateNum = 0;
		drawingType = 0;
		example.setImage(imageURL,this);
		rotationType = 0;
		setSize(0);
		repaint();
		revalidate();
	}
	
	/** Resmi b�y�tmeye ve k���ltmeye yarar
	 * @param plusZoom True zooms the image
	 */ 
	public void zoomImage(boolean plusZoom)
	{
		//plusZoom olunca zoom yap�yoruz, minus olunca k���lt�yoruz
		if(plusZoom)
		{
			if (zoomIndex < zoomDegrees.length-1)
				zoomIndex++;
		}
		else
		{
			if (zoomIndex > 0)
				zoomIndex--;
		}
		drawingType = 2; //zoom yap�ld���n� belirtiyor
		setSize(2);
		repaint();
		
		revalidate();
	}
	
	/**
	 * Sets the size of the panel
	 * @param type 0 -> new picture 1 -> Picture will be rotated 
	 * 2-> Picture will be zoomed
	 */
	public void setSize(int type)
	{
		Dimension s = null;
		switch (type) 
		{
			case 0: // New picture
				if (example.getPictureSize() != null)	
				{
					size = example.getPictureSize();  
					this.setPreferredSize(size);
				}
				break;
			case 1: // Rotate
				s = example.getPictureSize();
				size.setSize(s.getHeight(),s.getWidth());
				this.setPreferredSize(size);
				break;
			case 2: // Zoom
				s = new Dimension(example.image.getWidth(null),example.image.getHeight(null));
				int newWidth,newHeight;
				
				// Set size according to the rotate number
				int rot = rotateNum;
				while (rot < 0)
					rot += 4;
				// If the image is not rotated or rotated 180 degrees
				if (rot%4 == 0 || rot%4 == 2)
					size.setSize(zoomDegrees[zoomIndex]*s.getWidth(),zoomDegrees[zoomIndex]*s.getHeight());
				// If the image is rotated 90 or 270 degrees, the width and height should be changed
				else
					size.setSize(zoomDegrees[zoomIndex]*s.getHeight(),zoomDegrees[zoomIndex]*s.getWidth());
			
				this.setPreferredSize(size);
				break;
			default:
				break;
		}
	}
	//	These methods specify how big the component must be
	
	/* (non-Javadoc)
	 * @see java.awt.Component#getPreferredSize()
	 */
	public Dimension getPreferredSize() {return size; }
	/* (non-Javadoc)
	 * @see java.awt.Component#getMinimumSize()
	 */
	public Dimension getMinimumSize() { return size; }
}