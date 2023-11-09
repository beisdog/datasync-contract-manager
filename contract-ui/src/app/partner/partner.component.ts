import { Component } from '@angular/core';
import {ActivatedRoute} from "@angular/router";
import {map} from "rxjs";
import {newEmptyPartner, Partner} from "../../model/partner";
import {Address} from "../../model/address";
import {Contract} from "../../model/contract";
import {PartnerService} from "../../service/partner.service";
import {Message, MessageService} from "primeng/api";

@Component({
  selector: 'app-partner',
  templateUrl: './partner.component.html',
  styleUrls: ['./partner.component.sass']
})
export class PartnerComponent {

    id?: string;
    partner: Partner = newEmptyPartner();
    addresses: Address[] = [];
    contracts: Contract[] = [];


    constructor(
      private activatedRoute:ActivatedRoute,
      private partnerService: PartnerService,
      private messageService: MessageService
    ) {
        this.activatedRoute.paramMap.subscribe(params => {
          this.id = params.get('id') as string;
          console.log(this.id);
          this.initWithId(parseInt(this.id));
        });
    }

    private async initWithId(id: number) {
      this.partner = await this.partnerService.getPartnerById(id);
      console.log("loaded partner: " + JSON.stringify(this.partner));
      this.contracts = this.partner.contracts;
      this.addresses = this.partner.addresses;
    }

    async save() {
      const response = await this.partnerService.updatePartner(this.partner);
      await this.initWithId(this.partner.id);
      const message: Message = {severity: 'info', summary: 'Success!', detail: "Partner saved"};
      this.messageService.clear();
      this.messageService.add(message);
      return response;
    }

    delete() {

    }
}
