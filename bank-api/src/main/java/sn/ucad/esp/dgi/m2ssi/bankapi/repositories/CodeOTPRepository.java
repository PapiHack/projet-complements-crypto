package sn.ucad.esp.dgi.m2ssi.bankapi.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import sn.ucad.esp.dgi.m2ssi.bankapi.entities.CodeOTP;

import java.util.Optional;

@Repository
public interface CodeOTPRepository extends JpaRepository<CodeOTP, Long> {
    Optional<CodeOTP> findCodeOTPByCodeAndUsed(String code, boolean used);
}
