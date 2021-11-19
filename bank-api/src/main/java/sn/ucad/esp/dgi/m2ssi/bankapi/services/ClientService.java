package sn.ucad.esp.dgi.m2ssi.bankapi.services;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sn.ucad.esp.dgi.m2ssi.bankapi.dto.LoginDTO;
import sn.ucad.esp.dgi.m2ssi.bankapi.dto.RegisterDTO;
import sn.ucad.esp.dgi.m2ssi.bankapi.entities.Client;
import sn.ucad.esp.dgi.m2ssi.bankapi.entities.CodeOTP;
import sn.ucad.esp.dgi.m2ssi.bankapi.repositories.ClientRepository;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ClientService {

    private ClientRepository clientRepository;
    private CodeOTPService codeOTPService;

    public ClientService(ClientRepository clientRepository, CodeOTPService codeOTPService) {
        this.clientRepository = clientRepository;
        this.codeOTPService = codeOTPService;
    }

    public List<Client> getAllClients() {
        return this.clientRepository.findAll();
    }

    public Optional<Client> getClient(Long id) {
        return this.clientRepository.findById(id);
    }

    public void saveClient(Client client) { this.clientRepository.save(client); }

    public void deleteClient(Long id) {
        this.clientRepository.deleteById(id);
    }

    public Optional<Client> findByPhoneNumber(String phoneNumber) {
        Optional<Client> user = Optional.empty();
        List<Client> users = this.clientRepository.findAll();
        for (Client client : users) {
            if (client.getPhoneNumber().equalsIgnoreCase(phoneNumber)) {
                user = Optional.of(client);
            }
        }
        return user;
    }

    public Optional<Client> findByPhoneNumberAndPin(String codeOTP, String pin) {
        Optional<Client> user = Optional.empty();
        Optional<CodeOTP> code = this.codeOTPService.findByCode(codeOTP);
        if (code.isPresent()) {
            if (code.get().getClient().getPin().equalsIgnoreCase(pin)) {
                user = Optional.of(code.get().getClient());
                CodeOTP entity = code.get();
                entity.setUsed(true);
                this.codeOTPService.save(entity);
            }
        }
        return user;
    }

    public Optional<Client> login(LoginDTO userInfos) {
        return this.findByPhoneNumberAndPin(userInfos.getCodeOTP(), userInfos.getPin());
    }

    public Client register(RegisterDTO userInfos) {
        Client user = new Client();
        user.setName(userInfos.getName());
        user.setPhoneNumber(userInfos.getPhoneNumber());
        user.setPin(userInfos.getPin());
        return this.clientRepository.save(user);
    }

}
