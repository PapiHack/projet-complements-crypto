package sn.ucad.esp.dgi.m2ssi.bankapi.utils;

import java.io.Serializable;

public class SMSSenderResponse implements Serializable {

    private String status;
    private String message;

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
