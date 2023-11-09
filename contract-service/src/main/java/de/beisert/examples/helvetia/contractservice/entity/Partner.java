package de.beisert.examples.helvetia.contractservice.entity;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Entity
@Data
public class Partner implements Short{

    @Id
    @Column(name="partner_id")
    private Long id;

    private String firstName;

    private String lastName;

    private String birthdate;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "partner_id")
    private List<Address> addresses;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "partner_id")
    private List<Contract> contracts;

    public String getDisplayName() {
        return firstName + " " + lastName;
    }

}
