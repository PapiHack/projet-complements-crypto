package sn.ucad.esp.dgi.m2ssi.bankapi.services;

import javassist.NotFoundException;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sn.ucad.esp.dgi.m2ssi.bankapi.dto.DecryptDTO;
import sn.ucad.esp.dgi.m2ssi.bankapi.entities.Client;
import sn.ucad.esp.dgi.m2ssi.bankapi.entities.CodeOTP;
import sn.ucad.esp.dgi.m2ssi.bankapi.repositories.ClientRepository;
import sn.ucad.esp.dgi.m2ssi.bankapi.repositories.CodeOTPRepository;
import sn.ucad.esp.dgi.m2ssi.bankapi.utils.CryptographyService;
import sn.ucad.esp.dgi.m2ssi.bankapi.utils.SMSSenderService;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.util.List;
import java.util.Optional;
import java.util.Random;

@Service
@Transactional
public class CodeOTPService {

    private CodeOTPRepository codeOTPRepository;
    private ClientRepository clientRepository;
    private CryptographyService cryptographyService;
    private SMSSenderService smsSenderService;

    public CodeOTPService(
            CodeOTPRepository codeOTPRepository,
            ClientRepository clientRepository,
            CryptographyService cryptographyService,
            SMSSenderService smsSenderService
    ) {
        this.codeOTPRepository = codeOTPRepository;
        this.clientRepository = clientRepository;
        this.cryptographyService = cryptographyService;
        this.smsSenderService = smsSenderService;
    }

    public List<CodeOTP> getAllCodes() {
        return this.codeOTPRepository.findAll();
    }

    public CodeOTP save(CodeOTP code) {
        return this.codeOTPRepository.save(code);
    }

    public Optional<CodeOTP> getById(Long id) {
        return this.codeOTPRepository.findById(id);
    }

    public void deleteCode(Long id) {
        this.codeOTPRepository.deleteById(id);
    }

    public Optional<CodeOTP> findByCode(String code) {
        Optional<CodeOTP> codeOTP = Optional.empty();
        List<CodeOTP> codes = this.codeOTPRepository.findAll();
        for (CodeOTP OTPCode : codes) {
            if (OTPCode.getCode().equalsIgnoreCase(code)) {
                codeOTP = Optional.of(OTPCode);
            }
        }
        return codeOTP;
    }

    public boolean findByCodeAndUsed(String code, boolean used) {
        for(CodeOTP codeOTP : this.codeOTPRepository.findAll()) {
            if (codeOTP.getCode().equalsIgnoreCase(code) && codeOTP.isUsed() == used) {
                return true;
            }
        }
        return false;
    }

    public CodeOTP generateOTPCode(String phoneNumber) throws NotFoundException {
        CodeOTP codeOTP = new CodeOTP();
        // this.smsSenderService.sendSMS(phoneNumber, "TESTING");
        Optional<Client> user = this.findUserByPhoneNumber(phoneNumber);
        if(!user.isPresent()) {
            throw new NotFoundException("L'utilisateur avec ce numéro de téléphone n'existe pas !");
        }
        String generatedCode = this.generateRandomOTPCode();
        if (this.findByCodeAndUsed(generatedCode, true)) {
            generatedCode = this.generateRandomOTPCode();
        }
        codeOTP.setCode(generatedCode);
        codeOTP.setClient(user.get());
        // TODO: Encrypt codeOTP and send it to the user by SMS
        try {
            byte[] encodedCode = this.cryptographyService.encryptMessage(generatedCode);
            codeOTP.setEncodedCode(encodedCode);
            String encryptedCode = new String(this.cryptographyService.encryptMessage(generatedCode));
            System.out.println("============================== GENERATED CODE = " + generatedCode);
            System.out.println("============================== ENCRYPTED GENERATED CODE = " + encryptedCode.getBytes(StandardCharsets.UTF_8).toString());
            // System.out.println("============================== DECRYPTED GENERATED CODE = " + this.cryptographyService.decryptMessage(this.cryptographyService.encryptMessage(generatedCode)));
            System.out.println("============================== DECRYPTED GENERATED CODE = " + this.cryptographyService.decryptMessage(codeOTP.getEncodedCode()));
            boolean res = (new String(codeOTP.getEncodedCode())).equals(encryptedCode);
            System.out.println("============================== EGALITE = " + res);
            // this.smsSenderService.sendSMS(phoneNumber, encryptedCode);
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (IllegalBlockSizeException e) {
            e.printStackTrace();
        } catch (BadPaddingException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return this.codeOTPRepository.save(codeOTP);
        // return codeOTP;
    }

    public String decryptOTPCode(DecryptDTO OTPCodeInfos) {
        // TODO: Use crypto service in order to decrypt the token and send it
        String decryptedCode = new String();
        try {
            decryptedCode = this.cryptographyService.decryptMessage(OTPCodeInfos.getCodeOTP());
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (IllegalBlockSizeException e) {
            e.printStackTrace();
        } catch (BadPaddingException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return decryptedCode;
    }

    private String generateRandomOTPCode() {
        int min = 100000;
        int max = 999999;
        int result = (new Random()).nextInt((max - min) + 1) + min;
        return Integer.toString(result);
    }

    private Optional<Client> findUserByPhoneNumber(String phoneNumber) {
        Optional<Client> user = Optional.empty();
        List<Client> users = this.clientRepository.findAll();
        for (Client client : users) {
            if (client.getPhoneNumber().equalsIgnoreCase(phoneNumber)) {
                user = Optional.of(client);
            }
        }
        return user;
    }
}
