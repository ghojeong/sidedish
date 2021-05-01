package com.codesquad.sidedish.SideDish.service;

import com.codesquad.sidedish.SideDish.domain.Category;
import com.codesquad.sidedish.SideDish.domain.CategoryRepository;
import com.codesquad.sidedish.SideDish.dto.CategoryDto;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CategoryService {
    private final CategoryRepository categoryRepository;

    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    public List<Category> getList() {
        return categoryRepository.findAll();
    }
}
