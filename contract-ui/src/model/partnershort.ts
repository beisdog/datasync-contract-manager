import {Address} from "./address";
import {Contract} from "./contract";
import {Short} from "./short";

export interface PartnerShort extends Short{
  addresses?: Short[];
  contracts?: Short[];
}
