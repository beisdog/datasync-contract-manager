package de.beisert.examples.helvetia.contractservice.repo;

import de.beisert.examples.helvetia.contractservice.entity.Partner;
import de.beisert.examples.helvetia.contractservice.entity.PartnerShort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.CrossOrigin;

@Repository
@RepositoryRestResource(excerptProjection = PartnerShort.class)
@CrossOrigin
public interface PartnerRepository extends JpaRepository<Partner, Long> {
}
