package ma.formations.spring.rest.controller;

import ma.formations.spring.rest.domaine.EmpVo;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;

@Controller
public class EmpController {

    private final RestTemplate restTemplate;

    @Value("${server.rest.url}")
    private String url; // ex: http://localhost:9090/rest/emp

    public EmpController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @RequestMapping("/")
    public String showWelcomeFile(Model m) {
        return "index";
    }

    @RequestMapping("/empform")
    public String showform(Model m) {
        m.addAttribute("empVo", new EmpVo());
        return "empform";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public String save(@ModelAttribute("empVo") EmpVo emp) {

        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(List.of(MediaType.APPLICATION_JSON));
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<EmpVo> entity = new HttpEntity<>(emp, headers);

        ResponseEntity<String> response = restTemplate.exchange(
                url,
                HttpMethod.POST,
                entity,
                String.class
        );

        System.out.println("Response Status Code: " + response.getStatusCode());
        return "redirect:/viewemp";
    }

    @RequestMapping("/viewemp")
    public String viewemp(Model m) {

        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(List.of(MediaType.APPLICATION_JSON));

        HttpEntity<Void> entity = new HttpEntity<>(headers);

        ResponseEntity<EmpVo[]> response = restTemplate.exchange(
                url,
                HttpMethod.GET,
                entity,
                EmpVo[].class
        );

        System.out.println("Response Status Code: " + response.getStatusCode());

        EmpVo[] body = response.getBody();
        if (body == null) body = new EmpVo[0];

        m.addAttribute("list", Arrays.asList(body));
        return "viewemp";
    }

    @RequestMapping(value = "/editemp/{id}")
    public String edit(@PathVariable Long id, Model m) {

        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(List.of(MediaType.APPLICATION_JSON));

        HttpEntity<Void> entity = new HttpEntity<>(headers);

        // Back: GET /rest/emp/id/{id}
        ResponseEntity<EmpVo> response = restTemplate.exchange(
                url + "/id/" + id,
                HttpMethod.GET,
                entity,
                EmpVo.class
        );

        System.out.println("Response Status Code: " + response.getStatusCode());

        EmpVo emp = response.getBody();
        if (emp == null) emp = new EmpVo(); // évite NPE côté JSP
        m.addAttribute("empVo", emp);

        return "empeditform";
    }

    @RequestMapping(value = "/editsave", method = RequestMethod.POST)
    public String editsave(@ModelAttribute("empVo") EmpVo emp) {

        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(List.of(MediaType.APPLICATION_JSON));
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<EmpVo> entity = new HttpEntity<>(emp, headers);

        // Back: PUT /rest/emp/{id}
        ResponseEntity<String> response = restTemplate.exchange(
                url + "/" + emp.getId(),
                HttpMethod.PUT,
                entity,
                String.class
        );

        System.out.println("Response Status Code: " + response.getStatusCode());
        return "redirect:/viewemp";
    }

    @RequestMapping(value = "/deleteemp/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable Long id) {

        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(List.of(MediaType.APPLICATION_JSON));

        HttpEntity<Void> entity = new HttpEntity<>(headers);

        // Back: DELETE /rest/emp/{id}
        ResponseEntity<String> response = restTemplate.exchange(
                url + "/" + id,
                HttpMethod.DELETE,
                entity,
                String.class
        );

        System.out.println("Response Status Code: " + response.getStatusCode());
        return "redirect:/viewemp";
    }
}
