import {Component, OnInit} from '@angular/core';
import {PrimeNGConfig, TreeNode} from "primeng/api";
import {NodeService} from "../service/nodeservice";
import {MessageService} from 'primeng/api';
import {Router} from "@angular/router";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.sass']
})
export class AppComponent implements OnInit{
  title = 'contract-ui';
  nodes!: TreeNode[];
  displaySidebar: boolean = true;
  selectedContracts: TreeNode<any> | TreeNode<any>[] | null = null;

  constructor(private nodeService: NodeService,
              private primengConfig: PrimeNGConfig,
              private messageService: MessageService,
              private router: Router) {}

  ngOnInit() {
    this.primengConfig.ripple = true;
    this.reload();
  }

  nodeSelect(event: any) {
    const message = {severity: 'info', summary: 'Node Selected', detail: event.node.key + ":" + event.node.label};
    console.log(message);
    this.router.navigate([event.node.data]);
    this.displaySidebar = false;
  }

  newPartner() {

  }

  reload() {
    this.nodeService.getTreeNodes().then((data) => (this.nodes = data));
  }
}
