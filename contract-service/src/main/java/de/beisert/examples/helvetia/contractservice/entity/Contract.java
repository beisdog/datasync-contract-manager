package de.beisert.examples.helvetia.contractservice.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class Contract implements Short{

    @Id
    @Column(name="contract_id")
    private Long id;

    @Column(name = "contract_type")
    private String type;

    private String title;

    private String text;

    @Column(name = "start_date")
    private String startdate;

    public String getDisplayName() {
        return title;
    }

}
