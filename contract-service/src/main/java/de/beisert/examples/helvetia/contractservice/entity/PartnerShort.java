package de.beisert.examples.helvetia.contractservice.entity;

import org.springframework.data.rest.core.config.Projection;
import org.w3c.dom.stylesheets.LinkStyle;

import java.util.List;

/**
 * Used by list
 */
@Projection(name = "partnerShort", types = {Partner.class})
public interface PartnerShort extends Short{
    List<EmbeddedShort> getAddresses();
    List<EmbeddedShort> getContracts();

}
