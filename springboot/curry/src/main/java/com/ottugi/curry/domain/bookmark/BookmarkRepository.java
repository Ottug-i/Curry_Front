package com.ottugi.curry.domain.bookmark;

import com.ottugi.curry.domain.recipe.Recipe;
import com.ottugi.curry.domain.user.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BookmarkRepository extends JpaRepository<Bookmark, Long> {
    Bookmark findByUserIdAndRecipeId(User user, Recipe recipe);
    List<Bookmark> findByUserId(User user);
}
