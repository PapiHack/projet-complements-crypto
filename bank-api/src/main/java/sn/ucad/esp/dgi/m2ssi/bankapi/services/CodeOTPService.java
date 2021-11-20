package sn.ucad.esp.dgi.m2ssi.bankapi.services;

import javassist.NotFoundException;
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

    public boolean isCodeAlreadyExist(String code) {
        for(CodeOTP codeOTP : this.codeOTPRepository.findAll()) {
            if (codeOTP.getCode().equalsIgnoreCase(code)) {
                return true;
            }
        }
        return false;
    }

    public CodeOTP generateOTPCode(String phoneNumber) throws NotFoundException {
        CodeOTP codeOTP = new CodeOTP();
        Optional<Client> user = this.findUserByPhoneNumber(phoneNumber);
        if(!user.isPresent()) {
            throw new NotFoundException("L'utilisateur avec ce numéro de téléphone n'existe pas !");
        }
        String generatedCode = this.generateRandomOTPCode();
        if (this.isCodeAlreadyExist(generatedCode)) {
            generatedCode = this.generateRandomOTPCode();
        }
        codeOTP.setCode(generatedCode);
        codeOTP.setClient(user.get());
        try {
            byte[] encodedCode = this.cryptographyService.encryptMessage(generatedCode);
            String strCode = new String(encodedCode).getBytes(StandardCharsets.UTF_8).toString();
            codeOTP.setEncodedCode(encodedCode);
            codeOTP.setStringifyCode(strCode);
            this.smsSenderService.sendSMS(phoneNumber, strCode);
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
    }

    public String decryptOTPCode(DecryptDTO OTPCodeInfos) throws NotFoundException {
        List<CodeOTP> allOTPCodes = this.codeOTPRepository.findAll();
        CodeOTP otp = null;
        for (CodeOTP codeOTP: allOTPCodes) {
            if (codeOTP.getStringifyCode().equals(OTPCodeInfos.getCodeOTP())) {
                otp = codeOTP;
                break;
            }
        }
        if (otp == null) {
            throw new NotFoundException("Code OTP invalide !");
        }
        String decryptedCode = new String();
        try {
            decryptedCode = this.cryptographyService.decryptMessage(otp.getEncodedCode());
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
