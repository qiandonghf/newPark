package com.wiiy.cms.util;

import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

public class ImageUtil {
	
	public static void main(String[] args) {
		File oldFile = new File("d:/c.jpg");
		File newFile = new File("d:/b.jpg");
		try {
			BufferedImage oldBufferedImage = ImageIO.read(oldFile);
//			BufferedImage newBufferedImage = scaleImage(oldBufferedImage, 500, 200);
//			BufferedImage newBufferedImage = resizeImage(oldBufferedImage, 100, 100);
//			BufferedImage newBufferedImage = flipImage(oldBufferedImage);
			BufferedImage newBufferedImage = rotateImage(oldBufferedImage, 30);
			ImageIO.write(newBufferedImage, "jpeg", newFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("complate");
	}
	
	/**
	 * 计算矩形旋转后所占矩形大小
	 * @param size
	 * @param degree
	 * @return
	 */
	private static Dimension calculateRotateSize(Dimension size, int degree){
		double r = Math.toRadians(degree);
		double w = size.getWidth();
		double h = size.getHeight();
		int width = (int) (Math.abs(w * Math.cos(r)) + Math.abs(h * Math.sin(r)));
		int height = (int) (Math.abs(w * Math.sin(r)) + Math.abs(h * Math.cos(r)));
		return new Dimension(width, height);
	}
	
	/**
	 * 顺时针旋转图片
	 * @param image 原图
	 * @param degree 顺时针旋转角度
	 * @return 旋转后的新图
	 */
	public static BufferedImage rotateImage(BufferedImage image, int degree){
    	int imageWidth = image.getWidth();
    	int imageHeight = image.getHeight();
    	int size = (int) Math.hypot(imageWidth, imageHeight);
        BufferedImage temp = new BufferedImage(size, size, image.getType());
        Graphics g = temp.getGraphics();
        g.drawImage(image, (size-imageWidth)/2, (size-imageHeight)/2, null);
        g.dispose();
        AffineTransform transform = new AffineTransform();
        transform.rotate(Math.toRadians(degree), size/2, size/2);
        AffineTransformOp imageOp = new AffineTransformOp(transform, null);
        BufferedImage filteredImage = new BufferedImage(size, size, image.getType());
        imageOp.filter(temp, filteredImage);
        Dimension realSize = calculateRotateSize(new Dimension(imageWidth, imageHeight), degree);
        temp = new BufferedImage(realSize.width, realSize.height, image.getType());
        g = temp.getGraphics();
        g.drawImage(filteredImage, 0, 0, temp.getWidth(), temp.getHeight(), (size-temp.getWidth())/2, (size-temp.getHeight())/2, (size-temp.getWidth())/2+temp.getWidth(), (size-temp.getHeight())/2+temp.getHeight(), null);
        g.dispose();
        return temp;
    }

	/**
	 * 缩放图片(保持比例缩放，长不超过最大长 宽不超过最大宽，在最大长宽范围内显示最大)
	 * @param image 原图
	 * @param width 缩放后宽度
	 * @param height 缩放后高度
	 * @return 缩放后的新图
	 */
	public static BufferedImage scaleImage(BufferedImage image, int maxWidth, int maxHeight) {
		double ratio = Math.max((double)image.getWidth()/maxWidth, (double)image.getHeight()/maxHeight);
		BufferedImage bi = new BufferedImage((int)(image.getWidth()/ratio), (int)(image.getHeight()/ratio), image.getType());
		Graphics2D g2d = bi.createGraphics();
		g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
		g2d.drawImage(image, 0, 0, bi.getWidth(), bi.getHeight(), 0, 0, image.getWidth(), image.getHeight(), null);
		g2d.dispose();
		return bi;
	}
	
	/**
	 * 调整图片(不保持比例)
	 * @param image 原图
	 * @param width 缩放后宽度
	 * @param height 缩放后高度
	 * @return 缩放后的新图
	 */
	public static BufferedImage resizeImage(BufferedImage image, int width, int height) {
		BufferedImage bi = new BufferedImage(width, height, image.getType());
		Graphics2D g2d = bi.createGraphics();
		g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
		g2d.drawImage(image, 0, 0, width, height, 0, 0, image.getWidth(), image.getHeight(), null);
		g2d.dispose();
		return bi;
	}

	/**
	 * 水平翻转
	 * @param image 原图
	 * @return 翻转后的新图
	 */
	public static BufferedImage flipImage(BufferedImage image) {
		BufferedImage bi = new BufferedImage(image.getWidth(), image.getHeight(), image.getType());
		Graphics2D g2d = bi.createGraphics();
		g2d.drawImage(image, 0, 0, bi.getWidth(), bi.getHeight(), bi.getWidth(), 0, 0, bi.getHeight(), null);
		g2d.dispose();
		return bi;
	}
	
	public static void limitPhoto(String path){
		try {
			String rootPath = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"upload/";
			String photoPath = System.getProperty("org.springframework.osgi.web.deployer.tomcat.workspace")+"upload/"+path;
			File f=new File(photoPath);
			BufferedImage scaleImage1 = ImageUtil.scaleImage(ImageIO.read(f), 335, 240);
			BufferedImage scaleImage2 = ImageUtil.scaleImage(ImageIO.read(f), 600, 400);
			String fileName = photoPath.substring(0,photoPath.lastIndexOf("."));
			String lastName = photoPath.substring(photoPath.lastIndexOf("."));
			String smallPhoto =fileName+"335-240"+lastName;
			String bigPhoto = fileName+"600-400"+lastName;
			File imageFile1 = new File(smallPhoto);
			File imageFile2 = new File(bigPhoto);
//		imageFile1.createNewFile();
//		imageFile2.createNewFile();
			ImageIO.write(scaleImage1, photoPath.substring(photoPath.lastIndexOf(".")+1), imageFile1);
			ImageIO.write(scaleImage2, photoPath.substring(photoPath.lastIndexOf(".")+1), imageFile2);
			scaleImage1=null;
			scaleImage2=null;
			imageFile1=null;
			imageFile2=null;
			rootPath=null;
			photoPath=null;
			smallPhoto=null;
			bigPhoto=null;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

