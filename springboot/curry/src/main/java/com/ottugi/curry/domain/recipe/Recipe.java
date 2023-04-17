package com.ottugi.curry.domain.recipe;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Getter
@NoArgsConstructor
public class Recipe {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 100, nullable = false)
    private Integer recipeNo;

    @Column(length = 100, nullable = false)
    private String name;

    @Column(nullable = false)
    private String thumbnail;

    @Column(length = 100, nullable = false)
    private String time;

    @Column(length = 100, nullable = false)
    private String difficulty;

    @Column(length = 100, nullable = false)
    private String composition;

    @Column(length = 100, nullable = false)
    private String ingredients;

    @Column(length = 100, nullable = false)
    private String seasoning;

    @Column(nullable = false)
    private String order;

    private String photo;

    @Builder
    public Recipe(Long id, Integer recipeNo, String name, String thumbnail, String time, String difficulty, String composition, String ingredients, String seasoning, String order, String photo) {
        this.id = id;
        this.recipeNo = recipeNo;
        this.name = name;
        this.thumbnail = thumbnail;
        this.time = time;
        this.difficulty = difficulty;
        this.composition = composition;
        this.ingredients = ingredients;
        this.seasoning = seasoning;
        this.order = order;
        this.photo = photo;
    }
}
