package com.ottugi.curry.service.bookmark;

import com.ottugi.curry.web.dto.bookmark.BookmarkListResponseDto;
import com.ottugi.curry.web.dto.bookmark.BookmarkRequestDto;

import java.util.List;

public interface BookmarkService {

    Boolean addOrRemoveBookmark(BookmarkRequestDto bookmarkRequestDto);
    List<BookmarkListResponseDto> getBookmarkAll(Long userId);
    List<BookmarkListResponseDto> searchByName(Long userId, String name);
    List<BookmarkListResponseDto> searchByOption(Long userId, String time, String difficulty, String composition);
}
