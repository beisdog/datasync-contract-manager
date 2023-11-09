package de.beisert.examples.helvetia.contractservice.config;

import de.beisert.examples.helvetia.contractservice.entity.Address;
import de.beisert.examples.helvetia.contractservice.entity.Contract;
import de.beisert.examples.helvetia.contractservice.entity.Partner;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.CorsRegistry;

@Component
public class ExposeIdRestConfiguration
        implements RepositoryRestConfigurer {

    @Override
    public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config, CorsRegistry cors) {
        config.exposeIdsFor(Partner.class);
        config.exposeIdsFor(Contract.class);
        config.exposeIdsFor(Address.class);
    }

}
