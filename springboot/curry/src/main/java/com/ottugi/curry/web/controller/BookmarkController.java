package com.ottugi.curry.web.controller;

import com.ottugi.curry.service.bookmark.BookmarkService;
import com.ottugi.curry.web.dto.bookmark.BookmarkListResponseDto;
import com.ottugi.curry.web.dto.bookmark.BookmarkRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000")
public class BookmarkController {

    private final BookmarkService bookmarkService;

    @PostMapping("/api/bookmark/addAndRemoveBookmark")
    public ResponseEntity<Boolean> addOrRemoveBookmark(@RequestBody BookmarkRequestDto bookmarkRequestDto) {
        return ResponseEntity.ok().body(bookmarkService.addOrRemoveBookmark(bookmarkRequestDto));
    }

    @GetMapping("/api/bookmark/getBookmarkAll")
    public ResponseEntity<List<BookmarkListResponseDto>> getBookmarkAll(@RequestParam Long userId) {
        return ResponseEntity.ok().body(bookmarkService.getBookmarkAll(userId));
    }

    @GetMapping("/api/bookmark/searchByName")
    public ResponseEntity<List<BookmarkListResponseDto>> searchByName(@RequestParam Long userId, String name) {
        return ResponseEntity.ok().body(bookmarkService.searchByName(userId, name));
    }

    @GetMapping("/api/bookmark/searchByOption")
    public ResponseEntity<List<BookmarkListResponseDto>> searchByOption(@RequestParam Long userId, String time, String difficulty, String composition) {
        return ResponseEntity.ok().body(bookmarkService.searchByOption(userId, time, difficulty, composition));
    }
}
