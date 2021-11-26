package ino.web.freeBoard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.freeBoard.common.util.Pagination;
import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.service.FreeBoardService;

@Controller
public class FreeBoardController {

	@Autowired
	private FreeBoardService freeBoardService;

	@RequestMapping("/main.ino")
	public ModelAndView main(HttpServletRequest request, @RequestParam HashMap<String, Object> map,@RequestParam(defaultValue="1") int pagenum){
		ModelAndView mav = new ModelAndView();
		map.put("page1", pagenum);
		map.put("page2", pagenum+4);
		List<FreeBoardDto> list = freeBoardService.freeBoardList(map);
		List<FreeBoardDto> listCount = freeBoardService.Countlist(map);
		Pagination pg = new Pagination(pagenum, listCount.size(), "main.ino");
		mav.setViewName("boardMain");
		mav.addObject("freeBoardList",list);
		mav.addObject("page",pg.getPagination());
		return mav;
	}
	@RequestMapping("/mainOption.ino")
	@ResponseBody
	public Map<String, Object> mainOption(HttpServletRequest request, @RequestParam HashMap<String, Object> map,@RequestParam(defaultValue="1") int pagenum){
		Map<String, Object> map1 = new HashMap<String, Object>();
		map.put("page1", pagenum);
		map.put("page2", pagenum+4);
		List<FreeBoardDto> result = freeBoardService.freeBoardList(map);
		List<FreeBoardDto> listCount = freeBoardService.Countlist(map);
		Pagination pg = new Pagination(pagenum, listCount.size(), "main.ino");
		map1.put("result", result);
		map1.put("page",pg.getPagination());
		return map1;
	}

	
	@RequestMapping("/freeBoardInsert.ino")
	public String freeBoardInsert(){
		return "freeBoardInsert";
	}

	@RequestMapping("/freeBoardInsertPro.ino")
	@ResponseBody
	public Map<String, Object> freeBoardInsertPro(HttpServletRequest request, FreeBoardDto dto){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			freeBoardService.freeBoardInsertPro(dto);
			map.put("result", true);
			map.put("num", freeBoardService.getNewNum(dto.getNum()));
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", false);
			map.put("error", e.getMessage());
		}
		return map;
	}

	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request, int num){
		ModelAndView mav = new ModelAndView();
			FreeBoardDto dto = freeBoardService.getDetailByNum(num);
			mav.setViewName("freeBoardDetail");
			mav.addObject("freeBoardDto", dto);
		return mav;
	}

	@RequestMapping("/freeBoardModify.ino")
	@ResponseBody
	public Map<String, Object> freeBoardModify(HttpServletRequest request, FreeBoardDto dto){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			freeBoardService.freeBoardModify(dto);
			map.put("result", true);
			map.put("num", dto.getNum());
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", false);
			map.put("error", e.getMessage());
		}
		return map;
	}


	@RequestMapping("/freeBoardDelete.ino")
	@ResponseBody
	public Map<String, Object> FreeBoardDelete(HttpServletRequest request, int num){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			freeBoardService.FreeBoardDelete(num);
			map.put("result", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", false);
			map.put("error", e.getMessage());
		}
		return map;
	}
	
	@RequestMapping("/freeBoardCheckDelete.ino")
	@ResponseBody
	public Map<String, Object> FreeBoardCheckDelete(HttpServletRequest request,@RequestParam(value="valueArr[]", required=false) List<Integer> list){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			freeBoardService.FreeBoardCheckDelete(list);
			map.put("result", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("result", false);
			map.put("error", e.getMessage());
		}
		return map;
	}
}