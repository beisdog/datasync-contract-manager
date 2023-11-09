import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {PartnerComponent} from "./partner/partner.component";
import {ContractComponent} from "./contract/contract.component";
import {ContractListComponent} from "./contract-list/contract-list.component";

const routes: Routes = [
  {path: 'partners/:id', component: PartnerComponent },
  {path: 'partners/:partnerId/contracts/:id', component: ContractComponent },
  {path: 'partners/:partnerId/contracts', component: ContractListComponent }

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
