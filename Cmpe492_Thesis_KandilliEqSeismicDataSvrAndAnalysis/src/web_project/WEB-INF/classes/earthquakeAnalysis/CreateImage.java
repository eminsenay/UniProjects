package earthquakeAnalysis;

import java.awt.*;
import java.awt.image.*;
import java.io.*;
import javax.imageio.ImageIO;

public class CreateImage {

	public static void main (String[] args)
	{
		double magnitude = 1.0;
		String folderPath = "/home/bosisler/eclipseworkspace/491earthquake/WebContent/images/";
		String fileType = "png";
		
		while (magnitude <= 12)
		{
			double radius = getRadiusFromMagnitude(magnitude);
			// Create an image to save
			RenderedImage rendImage = myCreateImage(radius);
			String filePath = folderPath + (float)magnitude;
			boolean success = saveImage(rendImage, filePath, fileType);
			if (!success)
				break;
			magnitude += 0.1;
		}
	}
	
	public static double getRadiusFromMagnitude (double magnitude)
	{
		return magnitude*2;
	}
	
	public static boolean saveImage(RenderedImage rendImage, String path, String type)
	{
		// Write generated image to a file
		try {
			String correctPath = path + "." + type;
			File file = new File(correctPath);
			//System.out.println(file.getCanonicalPath());
			ImageIO.write(rendImage, type, file);
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	// Returns a generated image.
	public static RenderedImage myCreateImage(double radius) {
		
		int width =(int)(2*radius);
		int height = width;

		// Create a buffered image in which to draw
		BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

		// Create a graphics contents on the buffered image
		Graphics2D g2d = bufferedImage.createGraphics();

		// Draw graphics
		g2d.setColor(Color.white);
		g2d.fillRect(0, 0, width, height);
		g2d.setColor(Color.black);
		g2d.fillOval(0, 0, width, height);

		// Graphics context no longer needed so dispose it
		g2d.dispose();

		return bufferedImage;
	}

}
