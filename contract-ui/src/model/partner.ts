import {Address} from "./address";
import {Contract} from "./contract";

export interface Partner {
  id: number;
  firstName: string;
  lastName: string;
  birthdate: string;
  displayName: string;
  addresses: Address[];
  contracts: Contract[];
}

export function newEmptyPartner(): Partner {
  return {
    id: 0,
    firstName: "",
    lastName: "",
    birthdate: "",
    displayName: "",
    addresses: [],
    contracts: []
  }
}
