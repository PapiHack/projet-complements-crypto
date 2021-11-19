package sn.ucad.esp.dgi.m2ssi.bankapi.dto;

import java.io.Serializable;

public class UserVerificationDTO implements Serializable {

    private String phoneNumber;

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

}
