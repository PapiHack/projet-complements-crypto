package sn.ucad.esp.dgi.m2ssi.bankapi.controllers;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import javassist.NotFoundException;
import org.springframework.web.bind.annotation.*;
import sn.ucad.esp.dgi.m2ssi.bankapi.dto.DecryptDTO;
import sn.ucad.esp.dgi.m2ssi.bankapi.dto.UserVerificationDTO;
import sn.ucad.esp.dgi.m2ssi.bankapi.entities.CodeOTP;
import sn.ucad.esp.dgi.m2ssi.bankapi.services.CodeOTPService;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api")
@Api(value = "CRUD sur les code OTP")
public class CodeOTPController {

    private CodeOTPService codeOTPService;

    public CodeOTPController(CodeOTPService codeOTPService) {
        this.codeOTPService = codeOTPService;
    }

    @PostMapping("/generate-code")
    @ApiOperation(value = "Génére un code OTP pour un utilisateur")
    public CodeOTP generateCode(@RequestBody UserVerificationDTO userVerificationDTO) throws NotFoundException {
        return this.codeOTPService.generateOTPCode(userVerificationDTO.getPhoneNumber());
    }

    @PostMapping("/decrypt-code")
    @ApiOperation(value = "Génére un code OTP pour un utilisateur")
    public String decryptCode(@RequestBody DecryptDTO codeOTP) throws NotFoundException {
        return this.codeOTPService.decryptOTPCode(codeOTP);
    }

    @GetMapping("/codes")
    @ApiOperation(value = "Permet de récupérer les codes")
    public List<CodeOTP> getAll() {
        return this.codeOTPService.getAllCodes();
    }

    @GetMapping("/codes/{id}")
    @ApiOperation(value = "Permet de récupérer les codes")
    public Optional<CodeOTP> getCodeById(@PathVariable Long id) {
        return this.codeOTPService.getById(id);
    }
}
