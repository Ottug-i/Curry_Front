package com.ottugi.curry.domain.bookmark;

import com.ottugi.curry.domain.recipe.Recipe;
import com.ottugi.curry.domain.user.User;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
@DataJpaTest
class BookmarkRepositoryTest {

    String email = "wn8925@sookmyung.ac.kr";
    String nickName = "가경";

    Long recipeId = 1234L;
    String name = "참치마요 덮밥";
    String thumbnail = "www";
    String time = "15분";
    String difficulty = "초급";
    String composition = "든든하게";
    String ingredients = "참치캔###마요네즈###쪽파";
    String seasoning = "진간장###올리고당###설탕###";
    String orders = "1. 기름 뺀 참치###2. 마요네즈 4.5큰 술###3. 잘 비벼주세요.";
    String photo = "www###wwww####wwww";

    @Autowired
    private BookmarkRepository bookmarkRepository;

    @Autowired
    private TestEntityManager entityManager;

    @AfterEach
    void clean() {
        bookmarkRepository.deleteAll();
    }

    @Test
    void 북마크추가() {

        // given
        User user = User.builder().email(email).nickName(nickName).build();
        Recipe recipe = Recipe.builder()
                .id(recipeId)
                .name(name)
                .thumbnail(thumbnail)
                .time(time)
                .difficulty(difficulty)
                .composition(composition)
                .ingredients(ingredients)
                .seasoning(seasoning)
                .orders(orders)
                .photo(photo)
                .build();
        entityManager.persist(user);
        entityManager.persist(recipe);

        Bookmark bookmark = new Bookmark();
        bookmark.setUser(user);
        bookmark.setRecipe(recipe);
        bookmarkRepository.save(bookmark);

        // when
        Bookmark findBookmark = bookmarkRepository.findByUserIdAndRecipeId(user, recipe);

        // then
        assertEquals(findBookmark, bookmark);
    }

    @Test
    void 북마크유저이름으로조회() {

        // given
        User user = User.builder().email(email).nickName(nickName).build();
        Recipe recipe = Recipe.builder()
                .id(recipeId)
                .name(name)
                .thumbnail(thumbnail)
                .time(time)
                .difficulty(difficulty)
                .composition(composition)
                .ingredients(ingredients)
                .seasoning(seasoning)
                .orders(orders)
                .photo(photo)
                .build();
        entityManager.persist(user);
        entityManager.persist(recipe);

        Bookmark bookmark = new Bookmark();
        bookmark.setUser(user);
        bookmark.setRecipe(recipe);
        bookmarkRepository.save(bookmark);

        // when
        Bookmark findBookmark = bookmarkRepository.findByUserIdAndRecipeId(user, recipe);

        // then
        assertEquals(findBookmark.getUserId(), user);
        assertEquals(findBookmark.getRecipeId(), recipe);
    }

    @Test
    void 북마크유저이름으로리스트조회() {

        // given
        User user = User.builder().email(email).nickName(nickName).build();
        Recipe recipe = Recipe.builder()
                .id(recipeId)
                .name(name)
                .thumbnail(thumbnail)
                .time(time)
                .difficulty(difficulty)
                .composition(composition)
                .ingredients(ingredients)
                .seasoning(seasoning)
                .orders(orders)
                .photo(photo)
                .build();
        entityManager.persist(user);
        entityManager.persist(recipe);

        Bookmark bookmark = new Bookmark();
        bookmark.setUser(user);
        bookmark.setRecipe(recipe);
        bookmarkRepository.save(bookmark);

        // when
        List<Bookmark> bookmarkList = bookmarkRepository.findByUserId(user);

        // then
        Bookmark findBookmark = bookmarkList.get(0);
        assertEquals(findBookmark.getUserId(), user);
        assertEquals(findBookmark.getRecipeId(), recipe);
    }
}