package de.beisert.examples.helvetia.contractservice.entity;

import org.springframework.data.rest.core.config.Projection;

@Projection(name = "short", types = {Address.class, Contract.class})
public interface EmbeddedShort extends Short{
}
