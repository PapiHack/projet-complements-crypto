package sn.ucad.esp.dgi.m2ssi.bankapi.dto;

import java.io.Serializable;

public class LoginDTO implements Serializable {

    private String pin;
    private String codeOTP;

    public String getPin() {
        return pin;
    }

    public void setPin(String pin) {
        this.pin = pin;
    }

    public String getCodeOTP() {
        return codeOTP;
    }

    public void setCodeOTP(String codeOTP) {
        this.codeOTP = codeOTP;
    }
}
