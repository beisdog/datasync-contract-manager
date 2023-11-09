package de.beisert.examples.helvetia.contractservice.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class Address implements Short{

    @Id
    @Column(name="address_id")
    private Long id;

    private String street;

    private String city;

    private String zipcode;

    public String getDisplayName() {
        return street + ", " + city;
    }

}
