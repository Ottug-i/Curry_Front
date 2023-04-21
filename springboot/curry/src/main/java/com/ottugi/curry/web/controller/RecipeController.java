package com.ottugi.curry.web.controller;

import com.ottugi.curry.service.recipe.RecipeService;
import com.ottugi.curry.web.dto.recipe.RecipeRequestDto;
import com.ottugi.curry.web.dto.recipe.RecipeResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:3000")
public class RecipeController {

    private final RecipeService recipeService;

    @GetMapping("/api/recipe/getRecipeList")
    public ResponseEntity<List<RecipeResponseDto>> getRecipeList(@RequestBody RecipeRequestDto recipeRequestDto) {
        return ResponseEntity.ok().body(recipeService.getRecipeList(recipeRequestDto));
    }

    @GetMapping("/api/recipe/getRecipeDetail")
    public ResponseEntity<RecipeResponseDto> getRecipeDetail(@RequestParam Long userId, Long recipeId) {
        return ResponseEntity.ok().body(recipeService.getRecipeDetail(userId, recipeId));
    }
}
