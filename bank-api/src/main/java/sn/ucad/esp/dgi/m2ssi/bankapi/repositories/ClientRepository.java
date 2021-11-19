package sn.ucad.esp.dgi.m2ssi.bankapi.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import sn.ucad.esp.dgi.m2ssi.bankapi.entities.Client;

import java.util.Optional;

@Repository
public interface ClientRepository extends JpaRepository<Client, Long> {
    Optional<Client> findClientByPhoneNumber(String phoneNumber);
    Optional<Client> findClientByPhoneNumberAndPin(String phoneNumber, String pin);
}
