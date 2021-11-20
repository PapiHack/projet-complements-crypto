package sn.ucad.esp.dgi.m2ssi.bankapi.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

@Service
@Transactional
public class SMSSenderService {

    @Value("${sms-api-root-url}")
    private String smsSenderAPIRootUrl;

    private HttpService httpService;

    public SMSSenderService(HttpService httpService) {
        this.httpService = httpService;
    }

    public void sendSMS(String phoneNumber, String message) {
        String endpoint = this.smsSenderAPIRootUrl + "/v1/send-sms";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        Map<String, Object> data = new HashMap<>();
        data.put("phone_number", phoneNumber);
        data.put("message", message);

        this.httpService.post(endpoint, data, headers);
    }
}
