package sn.ucad.esp.dgi.m2ssi.bankapi.dto;

import java.io.Serializable;

public class DecryptDTO implements Serializable {

    private String codeOTP;

    public String getCodeOTP() {
        return codeOTP;
    }

    public void setCodeOTP(String codeOTP) {
        this.codeOTP = codeOTP;
    }
}
