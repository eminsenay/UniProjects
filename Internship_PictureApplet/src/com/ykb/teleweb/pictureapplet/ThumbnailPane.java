/*
 * Created on 11.A�u.2005
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
package com.ykb.teleweb.pictureapplet;

import java.awt.event.*;
import javax.swing.*;
import java.awt.*;
import java.io.*;
import java.util.Hashtable;
import java.net.*;

/**
 * This class creates a Thumbnail pane which contains the
 * thumbnail pictures, and responses the buttons
 * @author Emin �enay
 */
public class ThumbnailPane extends JScrollPane implements ActionListener{


	Dimension size;		// How much space it requires
	// The panel inside the scroll pane
	private JPanel jPanel = null;

	private static File currentDir = new File(".");
	
	// Hashtable which stores the thumbnail URLs
	private	Hashtable ht = new Hashtable();
	private GraphicsMainPane ex = null;
	
	/**
	 * Default constructor
	 * @param ex GraphicsMainPane object which will show the images
	 * @throws MalformedURLException if some image URL is malformed
	 */
	public ThumbnailPane(GraphicsMainPane ex) throws MalformedURLException
	{
		this.setViewportView(getJPanel());
		this.ex = ex;
	}
	
	/**
	 * ActionListener implementation. Calls appropriate methods when a
	 * button (or image) is pressed 
	 * @param e Action event
	 */
	public void actionPerformed(ActionEvent e)
	{
		String cmd = e.getActionCommand();
		if (cmd.equals("Load"))
		{
			try {
				refreshJPanel();
			} catch (MalformedURLException e1) {
				e1.printStackTrace();
			}
		}
		else if (cmd.equals("RotateLeft"))
		{
			ex.rotateLeft(); 
		}
		else if (cmd.equals("RotateRight"))
		{
			ex.rotateRight();
		} 
		else if (cmd.equals("ZoomPlus"))
		{
			ex.zoomImage(true);
		} 
		else if (cmd.equals("ZoomMinus"))
		{
			ex.zoomImage(false);
		} 
					
		else //cmd, hangi butonun t�kland���n� g�steren bir numara
		{
			// Buton numaras�n� parse edip hashtable dan �izece�in resmin URL sini �ek.
			int i = Integer.parseInt(cmd);
			URL path = (URL)ht.get(new Integer(i)); 
			ex.showImage(path);
		}
	}
	/**
	 * This method initializes jPanel and the image buttons
	 * 
	 * @return javax.swing.JPanel
	 */
	private javax.swing.JPanel getJPanel() throws MalformedURLException
	{
		if(jPanel == null)
		{
			jPanel = new javax.swing.JPanel();
			jPanel.setLayout(new javax.swing.BoxLayout(jPanel, javax.swing.BoxLayout.Y_AXIS));
			chooseFile();
			JButton[] buttons =  getButtons(currentDir.toString()); 
			for (int i = 0 ; i < buttons.length ; i++)
			{
				jPanel.add(buttons[i],null);
				//buttons[i].setSize(100,100);
			}
		}
		return jPanel;
	}
	
	/**
	 * Called when Load button is pressed. Gets the folder
	 * name and new pictures (which are buttons).Then puts all 
	 * buttons to the panel which is inside the scroll pane.
	 * @throws MalformedURLException if some image URL is malformed
	 */
	public void refreshJPanel() throws MalformedURLException
	{
		jPanel.removeAll();
		chooseFile();
		JButton[] buttons =  getButtons(currentDir.toString());
		for (int i = 0 ; i < buttons.length ; i++)
		{
			jPanel.add(buttons[i],null);
		}
		jPanel.repaint();
		jPanel.validate();
		this.validate(); 	
	}

	/**
	 * Verilen klas�rdeki resimlerin listesini d�nd�r�r.
	 * @param directory Klas�r ad�
	 * @return Resimlerin listesi
	 */
	private String[] getImageList(String directory)
	{
		File dir = currentDir;
		
		// Klas�rdeki dosyalardan sonu .jpg ile bitenleri filtrelemek i�in 
		// bir FilenameFilter tan�mla
		FilenameFilter filter = new FilenameFilter()
		{
			public boolean accept(File dir, String name)
			{
				// Dosya uzant�s� kontrol�. (E�er ba�ka bir uzant� eklenecekse buradan eklenecek)
				// Gif deste�i de verilebilir. Normal gifler d�zg�n �al���yor,
				// ancak animated giflerde problem var.
				return (name.endsWith("jpg") || name.endsWith("JPG"));
			}
		};
	
		//filtrelenmi� dosyalar� al ve d�nd�r
		String [] imageFiles = dir.list(filter);
		return imageFiles;
	}
	
	/** Klas�r se�me penceresi ekrana getirir.
	 */
	private void chooseFile()
	{
		//resimlerin bulundu�u klas�r� se�tir
		JFileChooser f = new JFileChooser();
		f.setCurrentDirectory(currentDir);
		f.setDialogTitle("Klas�r Se�iniz");
		f.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
		if (f.showOpenDialog(this) == JFileChooser.APPROVE_OPTION)
		{ 
			currentDir = f.getSelectedFile();
		}
	}
	
	/**
	 * Se�ilen klas�rdeki resimleri butonlar�n i�ine koymak i�in herbirini �nce 
	 * Thumbnail boyutlar�na k���lt�r, daha sonra da bu thumbnailleri
	 * birer ImageIcon, bu ikonlar� da birer JButton i�ine al�r.
	 * @param directory Se�ilen Klas�r.
	 * @return Resimlerin applette g�r�nt�lenmeye haz�r listesi
	 */
	private JButton[] getButtons(String directory) throws MalformedURLException
	{
		//Verilen klas�rdeki resimlerin listesini al
		String ImageFiles[] = getImageList(directory);
		
		ImageIcon[] icons = new ImageIcon[ImageFiles.length];
		JButton[] buttons = new JButton[icons.length];
		
		// Her resim i�in yeni bir ImageIcon ve bu ikon i�in
		// yeni bir buton olu�tur.
		for (int i = 0 ; i < ImageFiles.length ; i++)
		{
			URL imagePath = null;
			
			//Resmin path ini al
			URL deneme = null;
			try{
				deneme = currentDir.toURL();
			} catch (MalformedURLException e){
				e.printStackTrace();
			}
			String temp = new String(deneme + ImageFiles[i]); 

			try {
				//imagePath = new URL(temp);
				imagePath = new URL(deneme,ImageFiles[i]);
			}catch (MalformedURLException e) {
				e.printStackTrace();
			}
			
			//Resmi al, istedi�in boyuta getir.
			final Image img = Toolkit.getDefaultToolkit().getImage(imagePath);
			final Image repli = img.getScaledInstance(50, 50, Image.SCALE_DEFAULT);
			
			//�kon ve butonu olu�tur.
			icons[i] = new ImageIcon(repli);

			buttons[i] = new JButton(icons[i]);
			buttons[i].setHorizontalAlignment(JLabel.CENTER);
			buttons[i].setVerticalAlignment(JLabel.CENTER);
			buttons[i].setBorder(BorderFactory.createEmptyBorder(5, 10, 10, 5));
			buttons[i].addActionListener(this);
			buttons[i].setActionCommand("" + i);
			ht.put(new Integer(i),imagePath);

		}		
		return buttons;
	}	
}

