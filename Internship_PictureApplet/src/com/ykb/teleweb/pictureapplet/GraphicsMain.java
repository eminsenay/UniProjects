/*
 * Created on 08.Aðu.2005
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
package com.ykb.teleweb.pictureapplet;

import javax.swing.*;
import java.net.*;
import java.awt.*;



/**
 * Asýl class. Thumbnail ve resimlerin düzgün bir þekilde görüntülenebilmesi
 * için bir dýþ panel bulundurur ve bu panelin içinde thumbnail ve resim komponentlerinin
 * bulunduðu classlarý çaðýrýr.  
 *
 * @author Emin Þenay
 *
 */
public class GraphicsMain extends JApplet
{
	
	// Dýþ panel
	private javax.swing.JPanel jContentPane = null;
	// Thumbnail paneli
	ThumbnailPane thumbnailPane = null;
	// Resimlerin gösterildiði panel
	GraphicsMainPane ex = null;
	
	// Butonlarýn gösterildiði panel ve butonlar
	private javax.swing.JPanel buttonPane = null;
	private javax.swing.JButton jButton = null;
	private javax.swing.JButton jButton1 = null;
	private javax.swing.JButton jButton2 = null;
	private javax.swing.JButton jButton3 = null;
	private javax.swing.JButton jButton4 = null;
	
	// Resimlerin gösterildiði paneli kapsayan bir scroll paneli
	private javax.swing.JScrollPane mainPicturePane = null;
	//Resim ve thumbnaillerin panellerini bulunduran bir split pane
	private javax.swing.JSplitPane picturePane = null;
	/**
	 * This is the default constructor
	 */
	public GraphicsMain() {
		super();
		init();
	}
	/**
	 * This method initializes this
	 *
	 * @return void
	 */
	public void init() {
		this.setSize(800, 700);
		this.setContentPane(getJContentPane());
	}
	/**
	 * This method initializes jContentPane
	 * 
	 * @return javax.swing.JPanel
	 */
	private javax.swing.JPanel getJContentPane()
	{
		if (jContentPane == null)
		{
			jContentPane = new javax.swing.JPanel();
			jContentPane.setLayout(new java.awt.BorderLayout());
			
			//Split paneli ve buton panelini ekle
			jContentPane.add(getPicturePane(), java.awt.BorderLayout.CENTER);
			jContentPane.add(getButtonPane(), java.awt.BorderLayout.NORTH);
		}
		return jContentPane;
	}
	/**
	 * This method initializes the picture pane that shows the images
	 * 
	 * @return GraphicsPane
	 */
	public GraphicsMainPane getJMainPane()
	{
		ex = new GraphicsMainPane();
		return ex;
	}
	
	/**
	 * This method initializes the thumbnail pane that shows thumbnails
	 * 
	 * @return GraphicsPane
	 */
	public JScrollPane getJThumbnailPane()
	{
		try {
			thumbnailPane = new ThumbnailPane(ex);
			thumbnailPane.setPreferredSize(new Dimension(100,100));
		} catch(MalformedURLException e) {
			e.printStackTrace();
		}
		return thumbnailPane;
	}
	
	/**
	 * This method initializes jButton
	 * 
	 * @return javax.swing.JButton
	 */
	private javax.swing.JButton getJButton() {
		if(jButton == null)
		{
			jButton = new javax.swing.JButton();
			jButton.setText("Load ");
			jButton.setActionCommand("Load");
			jButton.addActionListener(this.thumbnailPane);
		}
		return jButton;
	}
	/**
	 * This method initializes buttonPane
	 * 
	 * @return javax.swing.JPanel
	 */
	private javax.swing.JPanel getButtonPane() {
		if(buttonPane == null) {
			buttonPane = new javax.swing.JPanel();
			buttonPane.add(getJButton(), null);
			buttonPane.add(getJButton1(), null);
			buttonPane.add(getJButton2(), null);
			buttonPane.add(getJButton3(), null);
			buttonPane.add(getJButton4(), null);
		}
		return buttonPane;
	}
	/**
	 * This method initializes jButton1 (RotateLeft)
	 * 
	 * @return javax.swing.JButton
	 */
	private javax.swing.JButton getJButton1() {
		if(jButton1 == null) {
			jButton1 = new javax.swing.JButton();
			jButton1.setText("rotateLeft");
			jButton1.addActionListener(this.thumbnailPane);
			jButton1.setActionCommand("RotateLeft");
		}
		return jButton1;
	}
	/**
	 * This method initializes jButton2 (RotateRight)
	 * 
	 * @return javax.swing.JButton
	 */
	private javax.swing.JButton getJButton2() {
		if(jButton2 == null) {
			jButton2 = new javax.swing.JButton();
			jButton2.setText("rotateRight");
			jButton2.addActionListener(this.thumbnailPane);
			jButton2.setActionCommand("RotateRight");
		}
		return jButton2;
	}
	/**
	 * This method initializes jButton3 (ZoomPlus)
	 * 
	 * @return javax.swing.JButton
	 */
	private javax.swing.JButton getJButton3() {
		if(jButton3 == null) {
			jButton3 = new javax.swing.JButton();
			jButton3.setText("Zoom +");
			jButton3.addActionListener(this.thumbnailPane);
			jButton3.setActionCommand("ZoomPlus");
		}
		return jButton3;
	}
	/**
	 * This method initializes jButton4 (ZoomMinus)
	 * 
	 * @return javax.swing.JButton
	 */
	private javax.swing.JButton getJButton4() {
		if(jButton4 == null) {
			jButton4 = new javax.swing.JButton();
			jButton4.setText("Zoom -");
			jButton4.addActionListener(this.thumbnailPane);
			jButton4.setActionCommand("ZoomMinus");
		}
		return jButton4;
	}
	/**
	 * This method initializes mainPicturePane
	 * (the scrollpane that contains the pane which shows the images) 
	 * 
	 * @return javax.swing.JScrollPane
	 */
	private javax.swing.JScrollPane getMainPicturePane() {
		if(mainPicturePane == null) {
			mainPicturePane = new javax.swing.JScrollPane();
			mainPicturePane.setViewportView(getJMainPane());
		}
		return mainPicturePane;
	}
	/**
	 * This method initializes picturePane
	 * (the split pane that contains the thumbnail pane and the main picture pane)
	 * 
	 * @return javax.swing.JSplitPane
	 */
	private javax.swing.JSplitPane getPicturePane() {
		if(picturePane == null) {
			picturePane = new javax.swing.JSplitPane();
			
			// Önce MainPicturePane, sonra JThumbnailPane eklenmesi gerekiyor.
			// JThumbnailPane, MainPicturePane in oluþturduðu GraphicsMainPane i kullanýyor
			picturePane.setRightComponent(getMainPicturePane());
			picturePane.setLeftComponent(getJThumbnailPane());
			
			picturePane.setDividerSize(2);
			picturePane.setDividerLocation(100);
		}
		return picturePane;
	}
}	
	
	
	


