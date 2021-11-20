package sn.ucad.esp.dgi.m2ssi.bankapi.entities;

import sn.ucad.esp.dgi.m2ssi.bankapi.utils.InheritColumns;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name="code_otp")
public class CodeOTP extends InheritColumns implements Serializable {

    @Column(name="code", unique = true)
    private String code;

    @Column(name="used")
    private boolean used;

    @Lob
    @Column(name="encoded_code")
    private byte[] encodedCode;

    @Column(name="stringify_code")
    private String stringifyCode;

    @ManyToOne
    private Client client;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public boolean isUsed() {
        return used;
    }

    public void setUsed(boolean used) {
        this.used = used;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public byte[] getEncodedCode() {
        return encodedCode;
    }

    public void setEncodedCode(byte[] encodedCode) {
        this.encodedCode = encodedCode;
    }

    public String getStringifyCode() {
        return stringifyCode;
    }

    public void setStringifyCode(String stringifyCode) {
        this.stringifyCode = stringifyCode;
    }
}
