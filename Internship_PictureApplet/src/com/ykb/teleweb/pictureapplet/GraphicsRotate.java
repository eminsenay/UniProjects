/*
 * Created on 08.Aðu.2005
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
package com.ykb.teleweb.pictureapplet;

import java.awt.*;
import java.awt.geom.*;
import java.awt.image.*;
import java.net.*;
import javax.swing.*;

/**
 * The filter class for images. Takes the images, filters
 * (rotates or zooms) them, and finally draws them.
 * @author Emin Þenay
 */
public class GraphicsRotate
{
	// The first width and height of the panel
	static final int WIDTH = 685, HEIGHT = 655;

	public Image image;
	private static BufferedImage bimage;
	
	/**
	 * Default constructor
	 */
	public GraphicsRotate() {}
	
	/**
	 * Returns the size of the picture
	 */
	public Dimension getPictureSize()
	{
		Dimension d = null;
		if (bimage != null)
		{
			int w = bimage.getWidth();
			int h = bimage.getHeight();
			d = new Dimension(w,h);
		}
		return d;
	}
	

	/**
	 * Takes the image from the given URL and sets it to an Image object.
	 * @param imgURL The URL of the image.
	 * @param c The component which will contain the image.
	 */
	public void setImage(URL imgURL, Component c)
	{
		// Take the image from the URL
		image = new ImageIcon(imgURL).getImage();
		// Create a BufferedImage big enough to hold the Image loaded
		// in the constructor.  Then copy that image into the new
		// BufferedImage object so that we can process it.
		bimage = new BufferedImage(image.getWidth(c),
								 image.getHeight(c),
								 BufferedImage.TYPE_INT_RGB);
		Graphics2D ig = bimage.createGraphics();
		ig.drawImage(image, 0, 0, c);  // copy the image
	}
	
	/** Returns the WIDTH
	 * @return WIDTH
	 */
	public int getWidth() { return WIDTH; }
	
	/** Returns the HEIGHT
	 * @return HEIGHT
	 */            
	public int getHeight() { return HEIGHT; }  

	/**
	 * Draws the original or rotated image
	 * @param g Graphics object to draw
	 * @param c Component to be drawn
	 * @param rotateNum Number that shows the left rotate - right rotate number from the beginning of the loading a new file 
	 * @param rotationType 1 -> rotation will be counter clockwise 2 -> rotation will be clockwise
	 * @param ZoomDegree 2 -> How much that the image is zoomed
	 */
	public void draw(Graphics2D g, Component c, int rotateNum, int rotationType, double ZoomDegree)
	{
		try {
			
			// This part is to take the images to the center of the pane
			/*while (rotateNum < 0)
				rotateNum += 4;
			
			switch (rotateNum%4)
			{
				case 0: case 2:
					g.translate((WIDTH-ZoomDegree*image.getWidth(c))/2,(HEIGHT-ZoomDegree*image.getHeight(c))/2);
					break;
				case 1: case 3:
					g.translate((WIDTH-ZoomDegree*image.getHeight(c))/2,(HEIGHT-ZoomDegree*image.getWidth(c))/2);
					break;
				default:
					break;
			}*/
			
			// Rotate the image
			if (rotationType == 1)//to left
			{
				BufferedImage left = rotateLeft(bimage);
				bimage = left;
				g.drawImage(left,0,0,c);	
			}
			else if (rotationType == 2) //to right
			{
				BufferedImage right = rotateRight(bimage);
				bimage = right;
				g.drawImage(right,0,0,c);	
			}
			// Draw the original image
			else if (rotationType == 0)
				g.drawImage(bimage,0,0,c);
		} catch (Throwable t){
		}
	}
	
	
	/**
	 * When rotated images are zoomed, this function is called. When zoom button is pressed, everytime
	 * zooming is done from the original image. Therefore, rotation is lost and needs to be done again.
	 * The function takes the zoomed image and the left rotation - right rotation (rotateNum), then
	 * rotates the image according to rotateNum.
	 * @param g Graphics object to draw
	 * @param c Component to be drawn 
	 * @param zoomedImage The zoomed image to be rotated
	 * @param rotateNum Number that shows the left rotate - right rotate number from the beginning of the loading a new file
	 * @param ZoomDegree How much the image is zoomed
	 */
	private void draw(Graphics2D g, Component c, BufferedImage zoomedImage, int rotateNum, double ZoomDegree)
	{
		try {
			while (rotateNum < 0)
				rotateNum += 4;
			// Translates are to draw the image on the center of the pane
			switch (rotateNum%4)
			{
				case 0:
				//	g.translate((WIDTH-ZoomDegree*image.getWidth(c))/2,(HEIGHT-ZoomDegree*image.getHeight(c))/2);
					bimage = null;
					bimage = zoomedImage; 
					break;
				case 1:
				//	g.translate((WIDTH-ZoomDegree*image.getHeight(c))/2,(HEIGHT-ZoomDegree*image.getWidth(c))/2);
					BufferedImage left = rotateLeft(zoomedImage);
					bimage = left;
					break;
				case 2: 
				//	g.translate((WIDTH-ZoomDegree*image.getWidth(c))/2,(HEIGHT-ZoomDegree*image.getHeight(c))/2);
					BufferedImage left1 = rotateLeft(zoomedImage);
					BufferedImage center = rotateLeft(left1);
					bimage = center;
					break;
				case 3:
					//	g.translate((WIDTH-ZoomDegree*image.getHeight(c))/2,(HEIGHT-ZoomDegree*image.getWidth(c))/2);
					BufferedImage right = rotateRight(zoomedImage);
					bimage = right;
					break;
				default:
					break;
			}
		} catch (Throwable t){
		}
	}
	
	/**
	 * Draws the zoomed image
	 * @param g Graphics object to draw
	 * @param c Component to be drawn 
	 * @param ZoomDegree How much the image is zoomed
	 * @param rotateNum Number that shows the left rotate - right rotate number from the beginning of the loading a new file
	 */
	public void draw(Graphics2D g, Component c, double zoomDegree, int rotateNum)
	{
		// Asýl resmi tekrar al
		bimage = new BufferedImage(image.getWidth(c),
								 image.getHeight(c),
								 BufferedImage.TYPE_INT_RGB);
		Graphics2D ig = bimage.createGraphics();
		ig.drawImage(image, 0, 0, c);  // copy the image
		
		// Resmi büyüt ya da küçült
		BufferedImage zoomedImg = zoomImg(bimage,zoomDegree);
		
		// Resmi tekrar eski dönmüþ haline getir
		draw(g,c,zoomedImg,rotateNum,zoomDegree);
		g.drawImage(bimage,0,0,c);
	}
	
		
	/**
	 * Rotates the image clockwise
	 * @param bi The image to be rotated
	 * @return The rotated image
	 */
	public BufferedImage rotateRight(BufferedImage bi) 
	{ 
		// Define an affine transform to rotate the image
		AffineTransform afRight = AffineTransform.getRotateInstance(Math.toRadians(90)); 
		afRight.translate(0,bi.getHeight() * -1); 
		AffineTransformOp rOp = new AffineTransformOp(afRight,null); 	
		
		// Filter (rotate) the image, return rotated image
		BufferedImage dstbi = rOp.filter(bi, null); 	
		return dstbi; 
	} 
		
	/**
	 * Rotates the image counter clockwise
	 * @param bi The image to be rotated
	 * @return The rotated image
	 */
	public BufferedImage rotateLeft(BufferedImage bi) 
	{
		// Define an affine transform to rotate the image 
		AffineTransform afLeft = AffineTransform.getRotateInstance( 
		Math.toRadians(270)); 
		afLeft.translate(bi.getWidth() * -1,0); 
		AffineTransformOp lOp = new AffineTransformOp(afLeft,null); 

		// Filter (rotate) the image, return rotated image
		BufferedImage dstbi = lOp.filter(bi, null); 
		return dstbi; 
	} 
	
	/**
	 * Zooms the image.
	 * @param bi The image to be zoomed.
	 * @param zoomDegree How much dows the image zoomed
	 * @return The zoomed image
	 */
	public BufferedImage zoomImg(BufferedImage bi,double zoomDegree)
	{
		// Define an affine transform to zoom the image
		AffineTransform zm = AffineTransform.getScaleInstance(zoomDegree,zoomDegree);
		AffineTransformOp zmop = new AffineTransformOp(zm,null);
		
		// Zoom the image, return zoomed image
		BufferedImage b = zmop.filter(bi,null);
		return b;
	}
	

}
