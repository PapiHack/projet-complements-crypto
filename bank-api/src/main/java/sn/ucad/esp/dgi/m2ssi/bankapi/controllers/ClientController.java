package sn.ucad.esp.dgi.m2ssi.bankapi.controllers;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import sn.ucad.esp.dgi.m2ssi.bankapi.dto.LoginDTO;
import sn.ucad.esp.dgi.m2ssi.bankapi.dto.RegisterDTO;
import sn.ucad.esp.dgi.m2ssi.bankapi.entities.Client;
import sn.ucad.esp.dgi.m2ssi.bankapi.services.ClientService;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api")
@Api(value = "CRUD sur les users")
public class ClientController {

    // @Value("${orange.application-id}")
    // private String appId;
    private ClientService clientService;

    public ClientController(ClientService clientService) {
        this.clientService = clientService;
    }

    @GetMapping("/users")
    @ApiOperation(value = "Permet de récuperer tous les utilisateurs")
    public List<Client> getAll() { return  this.clientService.getAllClients(); }

    @GetMapping("/users/{id}")
    @ApiOperation(value = "Permet de récupérer un utilisateur d'identifiant connu")
    public Optional<Client> get(@PathVariable Long id) {
        return this.clientService.getClient(id);
    }

    @DeleteMapping("/users/{id}")
    @ApiOperation(value = "Permet de supprimer un utilisateur d'identifiant connu")
    public void deleteClient(@PathVariable Long id) {
        this.clientService.deleteClient(id);
    }

    @PostMapping("/users")
    @ApiOperation(value = "Permet de créer un utilisateur")
    public void saveClient(@RequestBody Client client) {
        this.clientService.saveClient(client);
    }

    @PostMapping("/login")
    @ApiOperation(value = "Permet d'authentifier un user")
    public void login(@RequestBody LoginDTO userInfos) throws NotFoundException {
        this.clientService.login(userInfos);
    }

    @PostMapping("/register")
    @ApiOperation(value = "Permet d'enregistrer un nouveau user")
    public void register(@RequestBody RegisterDTO userInfos) {
        this.clientService.register(userInfos);
    }

}
