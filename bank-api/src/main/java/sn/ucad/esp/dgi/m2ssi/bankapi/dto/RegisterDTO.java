package sn.ucad.esp.dgi.m2ssi.bankapi.dto;

import java.io.Serializable;

public class RegisterDTO implements Serializable {

    private String name;
    private String phoneNumber;
    private String pin;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPin() {
        return pin;
    }

    public void setPin(String pin) {
        this.pin = pin;
    }
}
