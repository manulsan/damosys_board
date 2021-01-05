package egovframework.example.board.web;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.Globals;
import egovframework.example.board.service.BoardService;
import egovframework.example.board.service.BoardVO;
import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BoardController {
	@Resource(name = "boardService")
	private BoardService boardService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	
	@RequestMapping(value = "/list.do")
	public String list(@ModelAttribute("boardVO") BoardVO boardVO,ModelMap model) throws Exception {		
		/** EgovPropertyService.sample */
		boardVO.setPageUnit(propertiesService.getInt("pageUnit"));
		boardVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> list = boardService.selectBoardList(boardVO);
		model.addAttribute("resultList", list);

		int totCnt = boardService.selectBoardListTotCnt(boardVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);		
		return "board/list";
	}
	
	@RequestMapping(value = "/mgmt.do", method=RequestMethod.GET)
	public String mgmt(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model,  HttpServletRequest request) throws Exception {		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar cl = Calendar.getInstance();
		String strToday = sdf.format(cl.getTime());			System.out.println("Today="+strToday);		

		boardVO =boardService.selectBoard(boardVO);
		boardVO.setIndate(strToday);
		
		if(request.getSession().getAttribute("userId") !=null) {
			boardVO.setWriter(request.getSession().getAttribute("userId").toString());	
		}
		
		if(request.getSession().getAttribute("userName") !=null) {
			boardVO.setWriterName(request.getSession().getAttribute("userName").toString());	
		}
				
		
		model.addAttribute("boardVO", boardVO);
		
		return "board/mgmt";
	}
	
/*	@RequestMapping(value = "/mgmt.do", method=RequestMethod.POST)
	public String mgmt2(@ModelAttribute("boardVO") BoardVO boardVO, 
			@RequestParam("mode") String mode, ModelMap model,  HttpServletRequest request) throws Exception {
		System.out.println("mgmt.do post called");		System.out.println(boardVO);
		
		if("add".equals(mode)) boardService.insertBoard(boardVO);
		else if("mod".equals(mode)) boardService.updateBoard(boardVO);
		else if("del".equals(mode))boardService.deleteBoard(boardVO);		
		return "redirect:/list.do";
	}*/
	
	@RequestMapping(value = "/mgmt.do", method=RequestMethod.POST)
	public String mgmt2(@ModelAttribute("boardVO") BoardVO boardVO, 
			@RequestParam("mode") String mode, ModelMap model,  HttpServletRequest request) throws Exception {
		//System.out.println("mgmt.do post called");		System.out.println(boardVO);
		
		
		MultipartRequest mptRequest = (MultipartHttpServletRequest) request;
		Iterator<String> fileIter = mptRequest.getFileNames();

		while (fileIter.hasNext()) {
			MultipartFile mFile = mptRequest.getFile((String)fileIter.next());
		 
			if (mFile.getSize() > 0) {
				HashMap<String, String> _map = EgovFileMngUtil.uploadFile(mFile);
		 
				System.out.println("[ "+Globals.FILE_PATH+" : "+_map.get(Globals.FILE_PATH)+" ]");
				System.out.println("[ "+Globals.FILE_SIZE+" : "+_map.get(Globals.FILE_SIZE)+" ]");
				System.out.println("[ "+Globals.ORIGIN_FILE_NM+" : "+_map.get(Globals.ORIGIN_FILE_NM)+" ]");
				System.out.println("[ "+Globals.UPLOAD_FILE_NM+" : "+_map.get(Globals.UPLOAD_FILE_NM)+" ]");
				System.out.println("[ "+Globals.FILE_EXT+" : "+_map.get(Globals.FILE_EXT)+" ]");
				
				boardVO.setFilename(Globals.UPLOAD_FILE_NM);
			}
		}
		
		if("add".equals(mode)) boardService.insertBoard(boardVO);
		else if("mod".equals(mode)) boardService.updateBoard(boardVO);
		else if("del".equals(mode))boardService.deleteBoard(boardVO);		
		return "redirect:/list.do";
	}
	
	@RequestMapping(value = "/view.do")
	public String view(@ModelAttribute("boardVO") BoardVO boardVO,
			@RequestParam("idx") String idx, ModelMap model) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar cl = Calendar.getInstance();
		String strToday = sdf.format(cl.getTime());		
		System.out.println("Today="+strToday);
		
		boardService.updateBoardViewCount(boardVO);
		
		boardVO= boardService.selectBoard(boardVO);		
		model.addAttribute("boardVO",boardVO);
		model.addAttribute("strToday", strToday);
		
		List<?> list = boardService.selectReplyList(boardVO);
		model.addAttribute("resultList", list);
		
		return "board/view";
	}
	
	@RequestMapping(value = "/reply.do", method=RequestMethod.POST)
	public String reply(@ModelAttribute("boardVO") BoardVO boardVO, ModelMap model) throws Exception {		
		
		System.out.println("reply.do is called ");		
		boardService.insertReply(boardVO);
	/*	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar cl = Calendar.getInstance();
		String strToday = sdf.format(cl.getTime());
		
		System.out.print("Today="+strToday);
		
		//BoardVO boardVO = new BoardVo();
		boardVO.setIndate(strToday);
		boardVO.setWriter(request.getSession().getAttribute("userId").toString());
		boardVO.setWriterName(request.getSession().getAttribute("userName").toString());
		
		model.addAttribute("boardVO", boardVO);		
		return "redirect:/view.do";
		*/
		return "redirect:/view.do?idx="+boardVO.getIdx();
		
	}
	
	
	@RequestMapping(value = "/login.do")
	public String login(@RequestParam("user_id") String user_id , @RequestParam("password") String password ,
			ModelMap model, HttpServletRequest request ) throws Exception {
		System.out.println("user_id : "+ user_id);
		System.out.println("password: "+ password);
		BoardVO tVO = new BoardVO();
		
		tVO.setUserId(user_id);
		tVO.setPassword(password);		
		
		String user_name=boardService.selectLoginCheck(tVO);
		
		System.out.println(" 3 user_id : "+ user_id);
		
		if(user_name != null && !"".equals(user_name))
		{
			System.out.println(" 4 user_id : "+ user_id);
			
			request.getSession().setAttribute("userId", user_id);
			request.getSession().setAttribute("userName", user_name);	
		}
		else {
			System.out.println(" 5 user_id : "+ user_id);
			
			request.getSession().setAttribute("userId", "");
			request.getSession().setAttribute("userName", "'");			
			request.getSession().setAttribute("msg", "사용자 정보가 명확하지 않습니다.");
			
		}
		System.out.println(" 6 user_id : "+ user_id);
		//return "board/list";
		return "redirect:/list.do";
	}
	
	@RequestMapping(value = "/logout.do")
	public String logout(ModelMap model, HttpServletRequest request) throws Exception {
		request.getSession().invalidate();
		return "redirect:/list.do";
	}
}
