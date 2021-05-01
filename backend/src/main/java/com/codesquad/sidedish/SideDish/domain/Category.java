package com.codesquad.sidedish.SideDish.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.MappedCollection;

import java.util.*;

public class Category {
    @Id
    private final Long id;
    private final String categoryName;
    private final String endPoint;

    private Map<Integer, Dish> dishes = new HashMap<>();

    public Category(Long id, String categoryName, String endPoint) {
        this.id = id;
        this.categoryName = categoryName;
        this.endPoint = endPoint;
    }

    public long getId() {
        return id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public String getEndPoint() {
        return endPoint;
    }

    public Map<Integer, Dish> getDishes() {
        return dishes;
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", categoryName='" + categoryName + '\'' +
                ", endPoint='" + endPoint + '\'' +
                '}';
    }
}
