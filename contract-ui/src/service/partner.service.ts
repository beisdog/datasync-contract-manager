import { Injectable } from '@angular/core';
import {Partner} from "../model/partner";
import {PartnerShort} from "../model/partnershort";
import {environment} from "../environments/environment";

@Injectable({
  providedIn: 'root'
})
export class PartnerService {

  constructor() { }



  public async getPartnerById(id:number): Promise<Partner> {
    const response = await fetch(environment.apiRoot + '/partners/' + id, {
      method: 'GET',
      headers: {
        'Accept': 'application/hal+json'
      }});
    const json = await response.json();
    return json as Partner;
  }

  public async getPartners(): Promise<PartnerShort[]> {
    const response = await fetch(environment.apiRoot + '/partners', {
      method: 'GET',
      headers: {
        'Accept': 'application/hal+json'
      }});
    const json = await response.json();
    return json["_embedded"]["partners"] as PartnerShort[];
  }

  public async updatePartner(partner: Partner) {
    const response = await fetch(environment.apiRoot + '/partners/' + partner.id, {
      method: 'PATCH',
      headers: {
        'Accept': 'application/hal+json',
        'Content-Type': 'application/hal+json'
      },
      body: JSON.stringify(partner)
    });
    const json = await response.json();
    return json;
  }
}
