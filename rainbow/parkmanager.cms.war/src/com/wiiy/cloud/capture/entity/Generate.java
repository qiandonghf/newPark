package com.wiiy.cloud.capture.entity;

import java.io.File;

import com.wiiy.commons.generate.GenerateCode;
import com.wiiy.commons.generate.GenerateEntity;






/**
 * 文件生成
 * @author my
 *
 */
public class Generate {
	public static void main(String[] args) {
		//GenerateEntity.run(new File("src/com/wiiy/cloud/capture/entity/Column.hbm.xml"));
		//GenerateEntity.run(new File("src/com/wiiy/cloud/capture/entity/WebContent.hbm.xml"));
		//GenerateEntity.run(new File("src/com/wiiy/cloud/capture/entity/WebContentConfig.hbm.xml"));
		//GenerateEntity.run(new File("src/com/wiiy/cloud/capture/entity/WebParam.hbm.xml"));
//		GenerateEntity.run(new File("src/com/wiiy/core/entity/DesktopItem.hbm.xml"));
		
//		GenerateEntity.run(new File("src/com/wiiy/core/entity/Approval.hbm.xml"));
//		GenerateEntity.run(new File("src/com/wiiy/core/entity/Motto.hbm.xml"));
		
//		GenerateCode.run("com.wiiy.core.entity");
//		GenerateCode.printSpringXMLCode(Approval.class);
//		GenerateCode.run(RoleAuthorityRef.class);
//		GenerateCode.run(UserTopButton.class);
//		GenerateCode.run(Approval.class);
		GenerateCode.run(WebContentConfig.class);
		//GenerateCode.run(Motto.class);
	}
}
