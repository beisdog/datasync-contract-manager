import { Component } from '@angular/core';
import {ActivatedRoute} from "@angular/router";
import {newEmptyPartner, Partner} from "../../model/partner";
import {Contract} from "../../model/contract";
import {PartnerService} from "../../service/partner.service";

@Component({
  selector: 'app-contract-list',
  templateUrl: './contract-list.component.html',
  styleUrls: ['./contract-list.component.sass']
})
export class ContractListComponent {
  partnerId?: string;

  partner: Partner = newEmptyPartner();
  contracts: Contract[] = []

  constructor(
    private activatedRoute:ActivatedRoute,
    private partnerService: PartnerService
  ) {
    this.activatedRoute.paramMap.subscribe(params => {
      this.partnerId = params.get('partnerId') as string;
      console.log(this.partnerId);
      this.initWithPartnerId(parseInt(this.partnerId));
    });
  }

  private async initWithPartnerId(id: number) {
    this.partner = await this.partnerService.getPartnerById(id);
    console.log("loaded partner: " + JSON.stringify(this.partner));
    this.contracts = this.partner.contracts;
  }

}
