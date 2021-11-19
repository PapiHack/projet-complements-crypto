package sn.ucad.esp.dgi.m2ssi.bankapi.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.crypto.*;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Base64;

@Service
@Transactional
public class CryptographyService {

    @Value("${app.secret-key}")
    private String secretKey;

    private static final String ALGORITHM = "AES";

    public KeyGenerator createKeyGenerator() throws NoSuchAlgorithmException {
        return KeyGenerator.getInstance(ALGORITHM);
    }

    public SecretKey generateSecretKey(KeyGenerator keyGenerator) {
        return keyGenerator.generateKey();
    }

    public Cipher createCipher() throws NoSuchPaddingException, NoSuchAlgorithmException {
        return Cipher.getInstance(ALGORITHM);
    }

    public byte[] encryptMessage(String message) throws InvalidKeyException,
            IllegalBlockSizeException, BadPaddingException, NoSuchPaddingException, NoSuchAlgorithmException {
        Cipher cipher = this.createCipher();
        cipher.init(Cipher.ENCRYPT_MODE, this.string2SecretKey(this.secretKey));
        return cipher.doFinal(message.getBytes(StandardCharsets.UTF_8));
    }

    public String decryptMessage(String encryptedMessage) throws InvalidKeyException,
            IllegalBlockSizeException, BadPaddingException, NoSuchPaddingException, NoSuchAlgorithmException {
        Cipher cipher = this.createCipher();
        cipher.init(Cipher.DECRYPT_MODE, this.string2SecretKey(this.secretKey));
        return new String(cipher.doFinal(encryptedMessage.getBytes(StandardCharsets.UTF_8)));
    }

    public String decryptMessage(byte[] encryptedMessage) throws InvalidKeyException,
            IllegalBlockSizeException, BadPaddingException, NoSuchPaddingException, NoSuchAlgorithmException {
        Cipher cipher = this.createCipher();
        cipher.init(Cipher.DECRYPT_MODE, this.string2SecretKey(this.secretKey));
        return new String(cipher.doFinal(encryptedMessage));
    }

    private String secretKey2String(SecretKey secretKey) throws NoSuchAlgorithmException {
        byte[] rawData = secretKey.getEncoded();
        String encodedKey = Base64.getEncoder().encodeToString(rawData);
        return encodedKey;
    }

    private SecretKey string2SecretKey(String encodedKey) {
        byte[] decodedKey = Base64.getDecoder().decode(encodedKey);
        SecretKey originalKey = new SecretKeySpec(Arrays.copyOf(decodedKey, 16), "AES");
        return originalKey;
    }
}
