import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { TreeModule } from 'primeng/tree';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NodeService } from "../service/nodeservice";
import {SidebarModule} from "primeng/sidebar";
import {BrowserAnimationsModule} from "@angular/platform-browser/animations";
import {ToolbarModule} from "primeng/toolbar";
import {ButtonModule} from "primeng/button";
import {MessageService} from "primeng/api";
import {MessagesModule} from "primeng/messages";
import { PartnerComponent } from './partner/partner.component';
import { ContractListComponent } from './contract-list/contract-list.component';
import { ContractComponent } from './contract/contract.component';
import {PartnerService} from "../service/partner.service";
import {FormsModule} from "@angular/forms";
import {TableModule} from "primeng/table";
import {CardModule} from "primeng/card";
import {CalendarModule} from "primeng/calendar";
import {InputTextModule} from "primeng/inputtext";
import {InputTextareaModule} from "primeng/inputtextarea";

@NgModule({
  declarations: [
    AppComponent,
    PartnerComponent,
    ContractListComponent,
    ContractComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    TreeModule,
    SidebarModule,
    ToolbarModule,
    ButtonModule,
    FormsModule,
    TableModule,
    CardModule,
    CalendarModule,
    InputTextModule,
    InputTextareaModule,
    MessagesModule
  ],
  providers: [NodeService, PartnerService, MessageService],
  bootstrap: [AppComponent]
})
export class AppModule { }
