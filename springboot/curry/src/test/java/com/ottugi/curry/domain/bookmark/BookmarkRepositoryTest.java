package com.ottugi.curry.domain.bookmark;

import com.ottugi.curry.domain.recipe.Recipe;
import com.ottugi.curry.domain.user.User;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
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
    private User user;
    private Recipe recipe;
    private Bookmark bookmark;

    @Autowired
    private BookmarkRepository bookmarkRepository;

    @Autowired
    private TestEntityManager entityManager;

    @BeforeEach
    public void setUp() {

        // given
        user = User.builder().email(email).nickName(nickName).build();
        recipe = Recipe.builder()
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

        bookmark = new Bookmark();
        bookmark.setUser(user);
        bookmark.setRecipe(recipe);
        bookmarkRepository.save(bookmark);
    }

    @AfterEach
    void clean() {
        bookmarkRepository.deleteAll();
    }

    @Test
    void 북마크추가() {

        // when
        Bookmark findBookmark = bookmarkRepository.findByUserIdAndRecipeId(user, recipe);

        // then
        assertEquals(findBookmark, bookmark);
    }

    @Test
    void 북마크유저이름과레시피아이디로조회() {

        // when
        Bookmark findBookmark = bookmarkRepository.findByUserIdAndRecipeId(user, recipe);

        // then
        assertEquals(findBookmark.getUserId(), user);
        assertEquals(findBookmark.getRecipeId(), recipe);
    }

    @Test
    void 북마크유저이름으로리스트조회() {

        // when
        List<Bookmark> bookmarkList = bookmarkRepository.findByUserId(user);

        // then
        Bookmark findBookmark = bookmarkList.get(0);
        assertEquals(findBookmark.getUserId(), user);
        assertEquals(findBookmark.getRecipeId(), recipe);
    }
}