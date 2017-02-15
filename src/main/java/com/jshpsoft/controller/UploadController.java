package com.jshpsoft.controller;

import java.io.File;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;


/**
 * 上传controller
 * @Description: 提供上传功能
 * @author army.liu
 */
@Controller("uploadController")
@RequestMapping("/upload")
public class UploadController {
	
	/**
	 * 
	 * @Description: 文件上传
	 * @author army.liu 
	 * @param 
	 * {
	 *		type,参考Contants.UploadType
	 *			waybill-运单
	 * }
	 * @return 
	 * {
	 * 		orginFileName-原始文件名称
	 * 		attachFilePath-文件存储路径（包含文件名）
	 * 		code-200成功，300失败
	 * 		msg-提示信息
	 * }
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/saveFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveForPreviewImg(
			HttpServletRequest request,
			HttpServletResponse response, 
			HttpSession session
			) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "上传失败");
		
		String type = request.getParameter("type");
		String tempDir = CommonUtil.getStorePathForTempFile( type );
		
		//文件接收的临时目录
		String savePath = tempDir + "/" + session.getId();
		String savePathForFull = request.getSession().getServletContext().getRealPath( savePath ) ;
		File saveParentFile = new File( savePathForFull );
		if( !saveParentFile.exists() ){
			saveParentFile.mkdirs();
		}
		
		//原文件名
		String orginFileNameForBatch = "";
		//文件存储路径
		String attachFilePathForBatch = "";
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		for (Entry<String, MultipartFile> entry : fileMap.entrySet()) {
			MultipartFile multipartFile = entry.getValue();
			String orginFileName = multipartFile.getOriginalFilename();
			
			//新文件名
			String extend = orginFileName.substring( orginFileName.lastIndexOf(".") );//类型
			String newFileName = UUID.randomUUID().toString() + extend;
			
			String attachFilePath = savePath + "/" + newFileName;
			File targetFile = new File( savePathForFull + "/" + newFileName );
			InputStream inputStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(inputStream, targetFile);
			inputStream.close();
			
			orginFileNameForBatch += orginFileName + Constants.SplitStr.UploadFileName;
			attachFilePathForBatch += attachFilePath + Constants.SplitStr.UploadFileName;
		}
		
		if( orginFileNameForBatch.endsWith(Constants.SplitStr.UploadFileName) ){
			orginFileNameForBatch = orginFileNameForBatch.substring(0, orginFileNameForBatch.length()-1);
		}
		if( attachFilePathForBatch.endsWith(Constants.SplitStr.UploadFileName) ){
			attachFilePathForBatch = attachFilePathForBatch.substring(0, attachFilePathForBatch.length()-1);
		}
		result.put("orginFileName", orginFileNameForBatch);
		result.put("attachFilePath", attachFilePathForBatch);
		result.put("code", "200");
		result.put("msg", "上传成功");
		
		return result;
	}
	
}
