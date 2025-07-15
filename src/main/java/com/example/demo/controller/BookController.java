package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.dao.BookDAO;
import com.example.demo.entity.Book;

@Controller
public class BookController {
	
	@Autowired
	private BookDAO dao;
	
	@CrossOrigin(origins = "*")
	@GetMapping("/book/list")
	@ResponseBody
	public List<Book> list(){
		return dao.findAll();
	}
	
	@PostMapping("/book/insert")
	public String insertSubmit(Book b) {
		dao.save(b);
		return "redirect:/book/list";
	}
}




