package sn.ucad.esp.dgi.m2ssi.bankapi.utils;

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@Service
@Transactional
public class HttpService {

    private RestTemplate restTemplate;

    public HttpService(RestTemplateBuilder restTemplateBuilder) {
        this.restTemplate = restTemplateBuilder.build();
    }

    public void post(String url, Map<String, Object> data, HttpHeaders headers) {
        HttpEntity<Map<String, Object>> httpEntity = new HttpEntity<>(data, headers);
        this.restTemplate.exchange(
                url,
                HttpMethod.POST,
                httpEntity,
                new ParameterizedTypeReference<SMSSenderResponse>() {}
        );
    }
}
