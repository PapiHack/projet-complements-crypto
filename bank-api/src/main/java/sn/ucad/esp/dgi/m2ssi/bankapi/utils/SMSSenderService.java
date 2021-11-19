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

    @Value("${orange.application-id}")
    private String applicationId;

    @Value("${orange.client-id}")
    private String clientId;

    @Value("${orange.client-secret}")
    private String clientSecret;

    @Value("${orange.token}")
    private String token;

    private static final String ORANGE_API_URL = "https://api.orange.com";

    private static final String DEV_PHONE_NUMBER = "2210000";

    private HttpService httpService;

    public SMSSenderService(HttpService httpService) {
        this.httpService = httpService;
    }

    public void sendSMS(String phoneNumber, String message) {
        String endpoint = ORANGE_API_URL + "/smsmessaging/v1/outbound/tel:+" + DEV_PHONE_NUMBER + "/requests";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
        headers.setBearerAuth(this.token);

        Map<String, String> outboundSMSTextMessage = new HashMap<>();
        outboundSMSTextMessage.put("message", message);

        Map<String, Object> outboundSMSMessageRequest = new HashMap<>();
        outboundSMSMessageRequest.put("address", "tel:+" + phoneNumber);
        outboundSMSMessageRequest.put("senderAddress", "tel:+" + DEV_PHONE_NUMBER);
        outboundSMSMessageRequest.put("outboundSMSTextMessage", outboundSMSTextMessage);

        Map<String, Object> data = new HashMap<>();
        data.put("outboundSMSMessageRequest", outboundSMSMessageRequest);

        // TODO : send SMS to phoneNumber here
        this.httpService.post(endpoint, data, headers);
    }
}
