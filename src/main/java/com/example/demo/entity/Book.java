package com.example.demo.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "book")
@Data
public class Book {
	@Id
	private int bookid;
	private String bookname;
	private int price;
	private String publisher;
}
