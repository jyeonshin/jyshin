package mul.cam.food.service.impl;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import mul.cam.food.dao.BbsDao;
import mul.cam.food.dto.BbsComment;
import mul.cam.food.dto.BbsDto;
import mul.cam.food.dto.MemberDto;
import mul.cam.food.service.BbsService;

@Service
public class BbsServiceImpl implements BbsService {
	@Autowired
	BbsDao dao;
	
	@Override
	public boolean bbswrite(BbsDto dto) {
		int cnt = dao.bbswrite(dto);

		return cnt > 0 ? true : false;
	}
	
	@Override
	public List<BbsDto> getlist() {
		
		return dao.getlist();
	}
	
	@Override
	public JsonObject SummerNoteImageFile(MultipartFile file) {
		
		JsonObject jsonObject = new JsonObject();
		String fileRoot = "C:\\summernoteImg\\";
		String originalFileName = file.getOriginalFilename();
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
		
		String saveFileName = UUID.randomUUID()+extension;
			
		File targetFile = new File(fileRoot+saveFileName);
		
		try {
			InputStream fileStream = file.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);
			jsonObject.addProperty("url", "/summernoteImg/"+saveFileName);
			jsonObject.addProperty("responseCode", "succcess");
		} catch(IOException e) {
			FileUtils.deleteQuietly(targetFile);
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}	
		return jsonObject;
	}

	// 상세보기
	@Override
	public BbsDto detailBbs(int seq) {		
		return dao.detailBbs(seq);
	}

	// 게시판 수정
	@Override
	public boolean updateBbs(BbsDto dto) {		
		int n = dao.updateBbs(dto);
		return n>0?true:false;
	}
	
	// 게시판 삭제
	@Override
	public boolean deleteBbs(int seq) {		
		int n = dao.deleteBbs(seq);
		return n>0?true:false;
	}
	
	// 댓글 쓰기
	@Override
	public boolean commentWrite(BbsComment bbs) {	
		int n = dao.commentWrite(bbs);
		return n>0?true:false;
	}
	
	// 댓글 목록
	@Override
	public List<BbsComment> commentList(int seq) {	
		return dao.commentList(seq);
	}
	
	// 댓글 수정
	@Override
	public boolean updateComment(BbsComment bbs) {
		int n = dao.updateComment(bbs);
		return n>0?true:false;
	}
	
	// 댓글 삭제
	@Override
	public boolean deleteComment(BbsComment bbs) {
		int n = dao.deleteComment(bbs);
		return n>0?true:false;
	}

}
