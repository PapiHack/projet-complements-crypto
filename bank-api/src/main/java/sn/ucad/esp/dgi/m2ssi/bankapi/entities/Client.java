package sn.ucad.esp.dgi.m2ssi.bankapi.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import sn.ucad.esp.dgi.m2ssi.bankapi.utils.InheritColumns;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Set;

@Entity
@Table(name="client")
public class Client extends InheritColumns implements Serializable {

    @Column(name="name")
    private String name;

    @Column(name="pin")
    private String pin;

    @Column(name="phone_nubber", unique = true)
    private String phoneNumber;

    @OneToMany(mappedBy= "client")
    @JsonBackReference
    private Set<CodeOTP> codes;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPin() {
        return pin;
    }

    public void setPin(String pin) {
        this.pin = pin;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public Set<CodeOTP> getCodes() {
        return codes;
    }

    public void setCodes(Set<CodeOTP> codes) {
        this.codes = codes;
    }
}
