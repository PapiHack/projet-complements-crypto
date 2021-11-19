package sn.ucad.esp.dgi.m2ssi.bankapi.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@EnableSwagger2
public class SwaggerConfig {
    @Bean
    public Docket api() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(this.apiInfo())
                .select()
                .apis(RequestHandlerSelectors.basePackage("sn.ucad.esp.dgi.m2ssi.bankapi"))
                .paths(PathSelectors.any())
                .build();
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder().title("BANK API")
                .description("Documentation API du Projet du module de compléments cryptographiques (Cryptographie, Stéganographie, Watermaking)")
                .termsOfServiceUrl("https://github.com/PapiHack")
                .contact(new Contact("Meissa Mbaye", "https://github.com/PapiHack", "mssmbaye@gmail.com")).license("MIT Licence")
                .licenseUrl("mssmbaye@gmail.com").version("1.0").build();
    }
}
