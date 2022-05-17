package com.caocao.me.config;

import com.caocao.me.entities.Product;
import com.caocao.me.entities.ProductCategory;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;
import org.springframework.http.HttpMethod;
import org.springframework.web.servlet.config.annotation.CorsRegistry;

@Configuration
public class DataRestConfig implements RepositoryRestConfigurer {

    @Override
    public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config, CorsRegistry cors) {

        HttpMethod[] unauthorizedMethods = {HttpMethod.DELETE, HttpMethod.POST, HttpMethod.PUT};

        //Product
        config.getExposureConfiguration()
                .forDomainType(Product.class)
                .withItemExposure((metdata, httpMethods) -> httpMethods.disable(unauthorizedMethods))
                .withCollectionExposure((metdata, httpMethods) -> httpMethods.disable(unauthorizedMethods));

        //ProductCategory
        config.getExposureConfiguration()
                .forDomainType(ProductCategory.class)
                .withItemExposure((metdata, httpMethods) -> httpMethods.disable(unauthorizedMethods))
                .withCollectionExposure((metdata, httpMethods) -> httpMethods.disable(unauthorizedMethods));
    }
}
