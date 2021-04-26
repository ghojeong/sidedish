package com.codesquad.sidedish.SideDish.dto;

import com.codesquad.sidedish.SideDish.domain.Dish;

import java.util.List;

public class DishDto {
    private final String detailHash;
    private final String image;
    private final String title;
    private final String description;
    private final List<String> deliveryTypes;
    private final int price;
    private final int salePrice;
    private final List<String> badges;

    private DishDto(Builder builder) {
        this.detailHash = builder.detailHash;
        this.image = builder.image;
        this.deliveryTypes = builder.deliveryTypes;
        this.title = builder.title;
        this.description = builder.description;
        this.price = builder.price;
        this.salePrice = builder.salePrice;
        this.badges = builder.badges;
    }

    public static DishDto from(Dish dish) {
        return new Builder()
                .detailHash(dish.getDetailHash())
                .image(dish.getImage())
                .title(dish.getTitle())
                .description(dish.getDescription())
                .deliveryTypes(dish.getDeliveryTypes())
                .price(dish.getPrice())
                .salePrice(dish.getSalePrice())
                .badges(dish.getBadges())
                .build();
    }

    public static class Builder {
        private String detailHash;
        private String image;
        private String title;
        private String description;
        private List<String> deliveryTypes;
        private int price;
        private int salePrice;
        private List<String> badges;

        public DishDto build() {
            return new DishDto(this);
        }


        public Builder detailHash(String detailHash) {
            this.detailHash = detailHash;
            return this;
        }

        public Builder image(String image) {
            this.image = image;
            return this;
        }

        public Builder title(String title) {
            this.title = title;
            return this;
        }

        public Builder description(String description) {
            this.description = description;
            return this;
        }

        public Builder deliveryTypes(List<String> deliveryTypes) {
            this.deliveryTypes = deliveryTypes;
            return this;
        }

        public Builder price(int price) {
            this.price = price;
            return this;
        }

        public Builder salePrice(int salePrice) {
            this.salePrice = salePrice;
            return this;
        }

        public Builder badges(List<String> badges) {
            this.badges = badges;
            return this;
        }
    }

    public String getDetailHash() {
        return detailHash;
    }

    public String getImage() {
        return image;
    }

    public List<String> getDeliveryTypes() {
        return deliveryTypes;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public int getPrice() {
        return price;
    }

    public int getSalePrice() {
        return salePrice;
    }

    public List<String> getBadges() {
        return badges;
    }
}