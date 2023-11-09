import {Address} from "./address";

export interface Contract {
  id: number;
  type: string;
  title: string;
  text: string;
  startdate: string;
  displayName: string;
}

export function newEmptyContract(): Contract {
  return {
    id: 0,
    type: "",
    title: "",
    text: "",
    startdate: "",
    displayName: ""
  }
}
