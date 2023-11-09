import { Component } from '@angular/core';
import {ActivatedRoute} from "@angular/router";
import {PartnerService} from "../../service/partner.service";
import {newEmptyPartner, Partner} from "../../model/partner";
import {Contract, newEmptyContract} from "../../model/contract";

@Component({
  selector: 'app-contract',
  templateUrl: './contract.component.html',
  styleUrls: ['./contract.component.sass']
})
export class ContractComponent {

  id?: string;
  partnerId?: string;
  contract: Contract = newEmptyContract();
  partner: Partner = newEmptyPartner();

  constructor(
    private activatedRoute:ActivatedRoute,
    private partnerService: PartnerService
  ) {
    this.activatedRoute.paramMap.subscribe(params => {
      this.id = params.get('id') as string;
      this.partnerId = params.get('partnerId') as string;
      console.log(this.id);
      this.initWithId(parseInt(this.id),  parseInt(this.partnerId));
    });
  }

  public async initWithId(contractId: number, partnerId: number) {
    this.partner = await this.partnerService.getPartnerById(partnerId);
    console.log("loaded partner: " + JSON.stringify(this.partner));
    this.contract = this.partner.contracts.filter( c => c .id === contractId)[0];
  }

  public async save() {

  }

  public async delete() {

  }

  public get displayName() {
    if (this.partner && this.contract) return "\"" + this.contract.displayName + "\"" ;
    return "";
  }

}
