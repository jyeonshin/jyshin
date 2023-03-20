package mul.cam.food.controller;
import java.io.File;
import java.net.MalformedURLException;
import java.net.URLDecoder;
import java.net.http.HttpHeaders;
import java.nio.file.FileStore;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import mul.cam.food.dto.BbsComment;
import mul.cam.food.dto.BbsDto;
import mul.cam.food.service.BbsService;


@Controller
public class BbsController {

	@Autowired
	BbsService service;
	
	@GetMapping(value = "mainhome.do")
	public String mainhome(Model model) {
//		System.out.println("MemberController mainhome() " + new Date());	
		
		List<BbsDto> food = service.getlist();

		model.addAttribute("food", food);
		
		return "mainhome";
	}
	
	
	// 게시물 상세보기
	@GetMapping(value = "bbsdetail.do")
	public String bbsdetail(Model model, int seq) {
		System.out.println("BbsController bbsdetail " + new Date());
		BbsDto dto = service.detailBbs(seq);
		model.addAttribute("bbsdto", dto);
		
		return "bbsdetail";
	}		
	
	// 게시글 수정
	@RequestMapping(value = "bbsupdate.do", method = RequestMethod.POST)
	public String bbsupdate(Model model, BbsDto dto, int seq) {
		model.addAttribute("dto", dto);
		
		return "bbsupdate";
	}
	
	// 게시글 수정 이후
	@RequestMapping(value = "bbsupdateAf.do", method = RequestMethod.POST)
	public String bbsupdateAf(Model model, BbsDto dto) {
		System.out.println(dto.toString());
		boolean isS = service.updateBbs(dto);
		
		String bbsupdate = "BBS_UPDATE_OK";
		if(!isS) {			
			bbsupdate = "BBS_UPDATE_NG";
			System.out.println("게시물 수정에 실패했습니다");
		}
		model.addAttribute("bbsupdate", bbsupdate);
		model.addAttribute("seq", dto.getSeq());
		
		return "message";
	}
	
	// 썸머노트 이미지 파일
	@RequestMapping(value="SummerNoteImageFile" , method = RequestMethod.POST)
	public @ResponseBody JsonObject SummerNoteImageFile(@RequestParam("file") MultipartFile file) {

		JsonObject jsonObject = service.SummerNoteImageFile(file);
		 System.out.println(jsonObject);
		return jsonObject;
	}

	

	// 게시물 삭제
	@PostMapping(value = "bbsdelete.do")
	public String bbsdelete(Model model, int seq) {
		System.out.println("BbsController BbsDelete " + new Date());
		boolean isS = service.deleteBbs(seq);
		if(isS) {
			System.out.println("게시물 삭제에 성공했습니다");
		}else {
			System.out.println("게시물 삭제에 실패했습니다");
		}
		model.addAttribute("result", "delete success");
		
		return "message";
		
	}
	
	// 댓글 목록 
		@ResponseBody
		@GetMapping(value = "commentList.do")
		public List<BbsComment> commentList(int seq) {
			List<BbsComment> list = service.commentList(seq);
			return list;
		}
	
		
		// 댓글 작성
		@PostMapping(value = "commentWriteAf.do")
		public String commentWriteAf(BbsComment bbs) {
			System.out.println("BbsController BbsComment " + new Date());
			System.out.println(bbs.toString());
			boolean isS = service.commentWrite(bbs);
			if(isS) {
				System.out.println("댓글작성에 성공했습니다");
			}else {
				System.out.println("댓글작성에 실패했습니다");
			}
			
			return "redirect:/bbsdetail.do?seq=" + bbs.getSeq();
		}
	
	// 댓글 수정
	
	// 댓글 삭제
}