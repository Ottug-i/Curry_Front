package com.ottugi.curry.service.bookmark;

import com.ottugi.curry.domain.bookmark.Bookmark;
import com.ottugi.curry.domain.bookmark.BookmarkRepository;
import com.ottugi.curry.domain.recipe.Recipe;
import com.ottugi.curry.domain.recipe.RecipeRepository;
import com.ottugi.curry.domain.user.User;
import com.ottugi.curry.domain.user.UserRepository;
import com.ottugi.curry.web.dto.bookmark.BookmarkListResponseDto;
import com.ottugi.curry.web.dto.bookmark.BookmarkRequestDto;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@SpringBootTest
class BookmarkServiceTest {

    private final Long userId = 1L;
    private final String email = "wn8925@sookmyung.ac.kr";
    private final String nickName = "가경";

    private final Long recipeId = 1234L;
    private final String name = "참치마요 덮밥";
    private final String thumbnail = "www";
    private final String time = "15분";
    private final String difficulty = "초급";
    private final String composition = "든든하게";
    private final String ingredients = "참치캔###마요네즈###쪽파";
    private final String seasoning = "진간장###올리고당###설탕###";
    private final String orders = "1. 기름 뺀 참치###2. 마요네즈 4.5큰 술###3. 잘 비벼주세요.";
    private final String photo = "www###wwww####wwww";

    Long bookmarkId = 1L;

    @Mock
    private BookmarkRepository bookmarkRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private RecipeRepository recipeRepository;

    @InjectMocks
    private BookmarkServiceImpl bookmarkService;

    @Test
    void 북마크추가() {

        // given
        User user = new User(userId, email, nickName);
        Recipe recipe = new Recipe(recipeId, name, thumbnail, time, difficulty, composition, ingredients, seasoning, orders, photo);
        BookmarkRequestDto bookmarkRequestDto = new BookmarkRequestDto(userId, recipeId);

        // when
        when(userRepository.findById(userId)).thenReturn(java.util.Optional.of(user));
        when(recipeRepository.findById(recipeId)).thenReturn(java.util.Optional.of(recipe));
        when(bookmarkRepository.findByUserIdAndRecipeId(user, recipe)).thenReturn(null);
        when(bookmarkRepository.save(any())).thenReturn(new Bookmark());
        Boolean result = bookmarkService.addOrRemoveBookmark(bookmarkRequestDto);

        // then
        assertTrue(result);
    }

    @Test
    void 북마크삭제() {

        // given
        BookmarkRequestDto bookmarkRequestDto = new BookmarkRequestDto(userId, recipeId);
        User user = new User(userId, email, nickName);
        Recipe recipe = new Recipe(recipeId, name, thumbnail, time, difficulty, composition, ingredients, seasoning, orders, photo);
        Bookmark bookmark = new Bookmark();
        bookmark.setUser(user);
        bookmark.setRecipe(recipe);

        // when
        when(userRepository.findById(userId)).thenReturn(java.util.Optional.of(user));
        when(recipeRepository.findById(recipeId)).thenReturn(java.util.Optional.of(recipe));
        when(bookmarkRepository.findByUserIdAndRecipeId(user, recipe)).thenReturn(bookmark);
        Boolean result = bookmarkService.addOrRemoveBookmark(bookmarkRequestDto);

        // then
        assertFalse(result);
    }

    @Test
    void 북마크리스트조회() {

        // given
        User user = new User(userId, email, nickName);
        Recipe recipe = new Recipe(recipeId, name, thumbnail, time, difficulty, composition, ingredients, seasoning, orders, photo);
        Bookmark bookmark = new Bookmark(bookmarkId);
        bookmark.setUser(user);
        bookmark.setRecipe(recipe);

        // when
        when(userRepository.findById(userId)).thenReturn(java.util.Optional.of(user));
        List<Bookmark> bookmarkList = new ArrayList<>();
        bookmarkList.add(bookmark);
        when(bookmarkRepository.findByUserId(user)).thenReturn(bookmarkList);
        List<BookmarkListResponseDto> bookmarkListResponseDtoList = bookmarkService.getBookmarkAll(userId);

        // then
        assertEquals(bookmarkListResponseDtoList.get(0).getName(), recipe.getName());
    }

    @Test
    void 이름으로북마크조회() {

        // given
        User user = new User(userId, email, nickName);
        Recipe recipe = new Recipe(recipeId, name, thumbnail, time, difficulty, composition, ingredients, seasoning, orders, photo);
        Bookmark bookmark = new Bookmark(bookmarkId);
        bookmark.setUser(user);
        bookmark.setRecipe(recipe);

        // when
        when(userRepository.findById(userId)).thenReturn(java.util.Optional.of(user));
        List<Bookmark> bookmarkList = new ArrayList<>();
        bookmarkList.add(bookmark);
        when(bookmarkRepository.findByUserId(user)).thenReturn(bookmarkList);
        List<BookmarkListResponseDto> bookmarkListResponseDtoList = bookmarkService.searchByName(userId, recipe.getName());

        // then
        assertEquals(bookmarkListResponseDtoList.get(0).getName(), recipe.getName());
    }

    @Test
    void 옵션으로북마크조회() {

        // given
        User user = new User(userId, email, nickName);
        Recipe recipe = new Recipe(recipeId, name, thumbnail, time, difficulty, composition, ingredients, seasoning, orders, photo);
        Bookmark bookmark = new Bookmark(bookmarkId);
        bookmark.setUser(user);
        bookmark.setRecipe(recipe);

        // when
        when(userRepository.findById(userId)).thenReturn(java.util.Optional.of(user));
        List<Bookmark> bookmarkList = new ArrayList<>();
        bookmarkList.add(bookmark);
        when(bookmarkRepository.findByUserId(user)).thenReturn(bookmarkList);
        List<BookmarkListResponseDto> bookmarkListResponseDtoList = bookmarkService.searchByOption(userId, recipe.getTime(), recipe.getDifficulty(), recipe.getComposition());

        // then
        assertEquals(bookmarkListResponseDtoList.get(0).getName(), recipe.getName());
    }

}